# -*- coding: utf-8 -*-
#
# Cookbook Name:: ndenv
# Library:: mixin_ndenv
#
# Copyright 2014, Numergy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/mixin/shell_out'

class Chef
  module Mixin
    # Chef::Mixin::Ndenv module to manage ndenv commands
    module Ndenv
      include Chef::Mixin::ShellOut

      def ndenv_command(cmd, options = {})
        unless ndenv_installed?
          fail 'ndenv is not installed, can\'t run ndenv_command.'
        end

        default_options = {
          user: node['ndenv']['user'],
          group: node['ndenv']['group'],
          cwd: node['ndenv']['user_home'],
          env: { 'NDENV_ROOT' => node['ndenv']['root_path'] },
          timeout: 3600 }

        shell_out("#{node['ndenv']['root_path']}/bin/ndenv #{cmd}", Chef::Mixin::DeepMerge.deep_merge!(options, default_options))
      end

      def ndenv_installed?
        shell_out("ls #{node['ndenv']['root_path']}/bin/ndenv").exitstatus == 0
      end

      def node_version_installed?(version)
        shell_out("ls #{node['ndenv']['root_path']}/versions/#{version}").exitstatus == 0
      end

      def ndenv_global_version?(version)
        out = shell_out("cat #{node['ndenv']['root_path']}/version")
        out.stdout.chomp == version
      end
    end
  end
end
