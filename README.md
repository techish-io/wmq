# wmq-cookbook

The was cookbook installs and configures the WebSphere MQ. Current version of cookbook installs MQ binaries, creates queue manager and creates a listener.

## Supported Platforms

CentOS

RedHat

Note: This cookbook was tested only on CentOS release 6.4

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['wmq']['version']</tt></td>
    <td>int</td>
    <td>default wmq version</td>
    <td><tt>7.5</tt></td>
  </tr>
  <tr>
    <td><tt>['wmq'][:package][:location]</tt></td>
    <td>string</td>
    <td>default wmq package location</td>
    <td><tt>/opt/software/wmq</tt></td>
  </tr>
  <tr>
    <td><tt>['wmq'][:package][:name][:runtime]</tt></td>
    <td>string</td>
    <td>default wmq runtime package name</td>
    <td><tt>MQSeriesRuntime-7.5.0-2.x86_64</tt></td>
  </tr>
   <tr>
    <td><tt>['wmq'][:package][:name][:jre]</tt></td>
    <td>string</td>
    <td>default wmq jre package name</td>
    <td><tt>MQSeriesJRE-7.5.0-2.x86_64</tt></td>
  </tr>
   <tr>
    <td><tt>['wmq'][:package][:name][:java]</tt></td>
    <td>string</td>
    <td>default wmq java package name</td>
    <td><tt>MQSeriesJava-7.5.0-2.x86_64</tt></td>
  </tr>
   <tr>
    <td><tt>['wmq'][:package][:name][:gskit]</tt></td>
    <td>string</td>
    <td>default wmq gskit package name</td>
    <td><tt>MQSeriesGSKit-7.5.0-2.x86_64</tt></td>
  </tr>
  <tr>
    <td><tt>['wmq'][:package][:name][:man]</tt></td>
    <td>string</td>
    <td>default wmq man package name</td>
    <td><tt>MQSeriesMan-7.5.0-2.x86_64</tt></td>
  </tr>
  <tr>
    <td><tt>['wmq'][:package][:name][:samples]</tt></td>
    <td>string</td>
    <td>default wmq samples package name</td>
    <td><tt>MQSeriesSamples-7.5.0-2.x86_64</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:installation][:root]</tt></td>
    <td>string</td>
    <td>default installation location</td>
    <td><tt>/opt/mqm</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:log][:primary]</tt></td>
    <td>int</td>
    <td>default primary log files</td>
    <td><tt>3</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:log][:secondary]</tt></td>
    <td>int</td>
    <td>default secondary log files</td>
    <td><tt>2</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:log][:filesize]</tt></td>
    <td>int</td>
    <td>default primary log filesize</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:log][:type]</tt></td>
    <td>string</td>
    <td>default primary log type</td>
    <td><tt>lc</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:user]</tt></td>
    <td>string</td>
    <td>default wmq user</td>
    <td><tt>mqm</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:group]</tt></td>
    <td>string</td>
    <td>default wmq group</td>
    <td><tt>mqm</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:group]</tt></td>
    <td>string</td>
    <td>default wmq group</td>
    <td><tt>mqm</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:qmgr][:name]</tt></td>
    <td>string</td>
    <td>default qmgr name</td>
    <td><tt>TECHISH.QUEUE.MANAGER</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:qmgr][:listener][:name]</tt></td>
    <td>string</td>
    <td>default qmgr listener name</td>
    <td><tt>TECHISH.LISTENER</tt></td>
  </tr>
  <tr>
    <td><tt>[:wmq][:qmgr][:listener][:port]</tt></td>
    <td>int</td>
    <td>default qmgr listener port</td>
    <td><tt>1414</tt></td>
  </tr>
</table>


## Resources/Providers

This cookbook contains the `queue` custom resorce and provider.
### Actions

- `:create`: create a local queue

### Attribute Parameters

- `type`: Type of the queue, only 'local' is supported at the moment. Default is local
- `maxdepth`: Maximum depth of queue. Default is 5000.
- `descr`: Description of  of queue. Default is empty
- `installation_root`: MQ installation location. Default is value of node attribute default[:wmq][:installation][:root]
- `qmgr_name`: Queue manager name. Default is value of node attribute default[:wmq][:qmgr][:name]
- `user`: User under which queue manager is running. Default is value of node attribute default[:wmq][:user]

### Examples
	
	#Creates queue named TEST.LOCAL.QUEUE
	queue "TEST.LOCAL.QUEUE" do
		action :create
	end

## Usage

### wmq::default

Include `wmq` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[wmq::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Ishtiaq Ahmed (ishtiaq@techish.com)
