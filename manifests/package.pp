class vlc::package {

  package  { $vlc::package_name:
    ensure  => $vlc::ensure,
    require => Apt::Ppa['ppa:videolan/stable-daily'],
  }

  # The videolan daily build of the stable branch
  apt::ppa { 'ppa:videolan/stable-daily': }
}
