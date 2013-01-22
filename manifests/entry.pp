define sudo::entry (
  $users,
  $hosts    = [ 'ALL' ],
  $commands = { 'ALL' => { 'runas_user' => 'root', } },
) {
  notify { "${title}-users:    '${users}'": } 
  notify { "${title}-hosts:    '${hosts}'": } 
  notify { "${title}-commands: '${commands}'": } 
}
