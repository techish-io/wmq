class Chef
  class Resource
    class Queue < Chef::Resource
      identity_attr :name

      def initialize(name, run_context=nil)
        super
        @resource_name = :queue
        @provider = Chef::Provider::Queue
        @action = 'create'
        @allowed_actions.push(:create)
        @name = name
        @returns = 0
      end

      def type(arg=nil)
        set_or_return(:type, arg, :kind_of => [String], :default => "local" )
      end
      def maxdepth(arg=nil)
        set_or_return(:maxdepth, arg, :kind_of => [Integer], :default => 5000 )
      end
      def descr(arg=nil)
        set_or_return(:descr, arg, :kind_of => [String], :default => "" )
      end
      def installation_root(arg=nil)
        set_or_return(:installation_root, arg, :kind_of => [String], :default => "" )
      end
      def qmgr_name(arg=nil)
        set_or_return(:qmgr_name, arg, :kind_of => [String], :default => "" )
      end
      def user(arg=nil)
        set_or_return(:user, arg, :kind_of => [String], :default => "" )
      end
      
    end
  end
end

class Chef
  class Provider
    class Queue < Chef::Provider
      # implement load_current_resource method to load previous resource before action
      def load_current_resource
        @current_resource = Chef::Resource::Queue.new(@new_resource.name)
        @current_resource.name(@new_resource.name)
        @current_resource.type(@new_resource.type)
        @current_resource.maxdepth(@new_resource.maxdepth)
        @current_resource.descr(@new_resource.descr)
        @current_resource.installation_root(@new_resource.installation_root)
        @current_resource.qmgr_name(@new_resource.qmgr_name)
        @current_resource.user(@new_resource.user)
        @current_resource
      end

      def action_create
      	type = @new_resource.type
      	name = @new_resource.name
      	maxdepth = @new_resource.maxdepth
      	descr = @new_resource.descr
      	installation_root = @new_resource.installation_root
      	qmgr_name = @new_resource.qmgr_name
      	user = @new_resource.user
      	if user == ""
      		user=node[:wmq][:user]
      	end
      	if qmgr_name == ""
      		qmgr_name=node[:wmq][:qmgr][:name]
      	end
      	if installation_root == "" 
      		installation_root=node[:wmq][:installation][:root]
      	end
      	
        new_resource.updated_by_last_action(true)
        execute "Creating queue #{type} #{name}" do
        	user "#{user}"
        	command "echo \"DEF  Q#{type.upcase}('#{name}') MAXDEPTH(#{maxdepth}) DESCR('#{descr}') REPLACE\" | #{installation_root}/bin/runmqsc #{qmgr_name}"
        end
      end
      
     end
  end
end