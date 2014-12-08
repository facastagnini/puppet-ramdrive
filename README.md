puppet-ramdrive
===============

Create a ramdrive with puppet

###How to use this module? ...Examples

	# logdir in ram
	$log_path = '/var/log/ipsec'
	ramdrive { $log_path:
	  size       => '100M',
	  mode       => '0750',
	  owner      => 'root',
	  group      => 'adm',
	  notify     => Service[$strongswan::service_name],
	  require    => Package[$strongswan::package],
	}


	# mount a ramdrive for each temporary folder
	ramdrive { [
	  "${project_dir}/app/storage/cache",
	  "${project_dir}/app/storage/logs",
	  "${project_dir}/app/storage/meta",
	  "${project_dir}/app/storage/sessions",
	  "${project_dir}/app/storage/views"]:
	  size    => '50M',
	  mode    => 0770,
	  recurse => true,
	  owner   => $owner,
	  group   => $group,
	  require => File["${project_dir}/app/storage"]
	}
