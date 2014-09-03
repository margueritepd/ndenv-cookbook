ndenv Cookbook
==============
This cookbook installs and configures [ndenv](https://github.com/riywo/ndenv) for a specific user.

Requirements
------------
#### cookbooks
- `apt` - https://supermarket.getchef.com/cookbooks/apt
- `build-essential` - https://supermarket.getchef.com/cookbooks/build-essential
- `git` - https://supermarket.getchef.com/cookbooks/git

#### platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- `Ubuntu 12.04`

Attributes
----------
#### ndenv::default
<table>
<tr>
<th>Key</th>
<th>Type</th>
<th>Description</th>
<th>Default</th>
</tr>
<tr>
<td><tt>['ndenv']['user']</tt></td>
<td>String</td>
<td>User to use for ndenv install, create if not exists.</td>
<td><tt>ndenv</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['user_home']</tt></td>
<td>String</td>
<td>User home</td>
<td><tt>/home/ndenv</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['group']</tt></td>
<td>String</td>
<td>Group to use for ndenv install, create if not exists.</td>
<td><tt>ndenv</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['group_users']</tt></td>
<td>Array</td>
<td>List of users to add to specified group.</td>
<td><tt>[]</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['manage_home']</tt></td>
<td>Boolean</td>
<td>Manage user home. Used for `user` resource.</td>
<td><tt>true</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['root_path']</tt></td>
<td>String</td>
<td>Ndenv root path.</td>
<td><tt>/opt/ndenv</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['profile_path']</tt></td>
<td>String</td>
<td>Profile.d path where will be stored ndenv init script.</td>
<td><tt>/etc/profile.d</tt></td>
</tr>
</table>

#### ndenv::install
<table>
<tr>
<td><tt>['ndenv']['installs']</tt></td>
<td>Array</td>
<td>List of node.js versions to install.</td>
<td><tt>['v0.10.26']</tt></td>
</tr>
<tr>
<td><tt>['ndenv']['global']</tt></td>
<td>String</td>
<td>Node.js version to set as global.</td>
<td><tt>0.10.26</tt></td>
</tr>
</table>

Usage
-----
#### ndenv::default
This recipe install and configure ndenv for specified user/group.
Just include `ndenv` in your node's `run_list`:

```json
{
"name":"my_node",
  "run_list": [
    "recipe[ndenv]"
  ]
}
```

#### ndenv::install
This recipe install specified node.js versions. Ndenv must be installed to use this recipe!
Set `installs` and `global` attributes and include `ndenv::install` in your node's `run_list`:

```json
{
"name":"my_node",
  "run_list": [
    "recipe[ndenv]"
    "recipe[ndenv::install]"
  ],
  "attributes": [
    "ndenv": [
      "installs": ["0.10.20", "0.10.26"],
      "global": "0.10.26"
    ]
  ]
}
```

Resources/Providers
-------------------
#### ndenv_node
Install specified version of Node.js to be managed by ndenv.

##### Actions
Action  | Description                   | Default
------- |-------------                  |---------
install | Install the version of Nodejs | Yes

##### Attributes
Attribute    | Description                                                 | Default
-------      |-------------                                                |---------
node_version | the node version you wish to install                        | name
force        | install even if this version is already present (reinstall) | false
global       | set this node.js version as the global version              | false

Examples
--------
##### Installing Node.js 0.10.20

    ndenv_node "v0.10.20"

##### Forcefully install Node.js 0.10.20

    ndenv_node "Node.js 0.10.20" do
      node_version "0.10.20"
      force true
    end

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
|                      |                                             |
|:---------------------|:--------------------------------------------|
| **Author**           | Antoine Rouyer <antoine.rouyer@numergy.com> |
|                      |                                             |
| **Copyright**        | Copyright (c) 2014 Numergy                  |

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
