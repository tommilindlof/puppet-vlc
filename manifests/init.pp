class vlc(
  $package_name = params_lookup( 'package_name' ),
  $enabled       = params_lookup( 'enabled' )
) inherits vlc::params {

    $ensure = $enabled ? {
      true => present,
      false => absent
    }

  include vlc::package, vlc::config
}

define firefox(
	$version='firefox-mozilla-build',
	$removeiceweasel=true,
	$ensure='latest'
) {
	case $::operatingsystem {
		'ubuntu', 'debian': {
			apt::source {'firefoxsource':
			  name => 'downloads-sourceforge-net_project_ubuntuzilla_mozilla_apt',
				location    => 'http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt',
				release     => ' ',
				repos       => 'all main',
				key        => 'C1289A29',
			key_server => 'keyserver.ubuntu.com',
				include_src => false
			}

		}
		default: {
			apt::source {'firefoxsource':
        name => 'downloads-sourceforge-net_project_ubuntuzilla_mozilla_apt',
        location    => 'http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt',
        release     => ' ',
        repos       => 'all main',
        key        => 'C1289A29',
        key_server => 'keyserver.ubuntu.com',
        include_src => false
      }
		}
	}
	
	if $removeiceweasel == true {
		package{"removeiceweasel":
			name=>"iceweasel",
			ensure=>"purged"
		}
	}
	
	package{"installfirefox":
		name=>$version,
		ensure=>$ensure,
		require=>Apt::Source['firefoxsource']
	}
}
