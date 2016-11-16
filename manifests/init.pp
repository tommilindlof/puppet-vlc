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
