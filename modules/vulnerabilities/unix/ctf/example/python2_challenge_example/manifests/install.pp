class python2_challenge_example::install {
  $secgen_params = secgen_functions::get_parameters($::base64_inputs_file)
  $group = $secgen_params['group']
  $script_data = $secgen_params['script_data']

  if $secgen_params['account'][0] and $secgen_params['account'][0] != '' {
    $account = parsejson($secgen_params['account'][0])
  } else {
    $account = undef
  }

  if $secgen_params['storage_directory'] and $secgen_params['storage_directory'][0] {
    $storage_dir = $secgen_params['storage_directory'][0]
  } else {
    $storage_dir = undef
  }

  if $group {
    ::secgen_functions::install_setgid_script { 'python2_challenge_example':
      source_module_name => $module_name,
      challenge_name     => $secgen_params['challenge_name'][0],
      script_name        => 'test.py',
      script_data        => $script_data[0],
      group              => $group[0],
      account            => $account,
      flag               => $secgen_params['flag'][0],
      flag_name          => 'flag',
      storage_dir        => $storage_dir,
      strings_to_leak    => $secgen_params['strings_to_leak'],
    }
  } else {
    ::secgen_functions::install_setuid_root_script { 'python2_challenge_example':
      source_module_name => $module_name,
      challenge_name     => $secgen_params['challenge_name'][0],
      script_name        => 'test.py',
      script_data        => $script_data[0],
      account            => $account,
      flag               => $secgen_params['flag'][0],
      flag_name          => 'flag',
      storage_dir        => $storage_dir,
      strings_to_leak    => $secgen_params['strings_to_leak'],
    }
  }

}
