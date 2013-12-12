name 'zion'
description 'Role para zion'

# override_attributes(
#   'chef_client' => {
#     'init_style' => 'init',
#     'server_url' => 'https://api.opscode.com/organizations/rcovarru',
#     'interval'  => '600',
#     'splay'  => '10',
#     'validation_client_name' => 'rcovarru-validator'
#   }
# )

run_list(
  'recipe[zion]',
#  'recipe[chef_handler]',
#  'recipe[one]',
#  'recipe[chef-client::config]',
#  'recipe[chef-client::service]',
#  'recipe[hosts]',
#  'recipe[resolver]',
#  'recipe[users]',
#  'recipe[yumrepo::lan]',
#  'recipe[screen]',
#  'recipe[sudo]',
#  'recipe[base::decrypt_per_dc]',
#  'recipe[base]',
#  'recipe[nagios::client]',
#  'recipe[tripwire::client]',
)
