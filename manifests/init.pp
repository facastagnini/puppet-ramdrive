# Class: ramdrive
#
# This module manages ramdrive
#
define ramdrive (
  $fstype  = 'tmpfs',
  $size    = '1G',
  $mode    = '1777', 
  $owner   = 'root', 
  $group   = 'root', 
  $recurse = false
) {
  $mountpoint = $name

  # validate the parameters
  validate_absolute_path($mountpoint)
  validate_re($fstype, [ '^tmpfs$', '^ramfs$' ])
  validate_re($size, ['^\d+\w+$', ''])
  validate_re($mode, ['^\d+$', ''])
  validate_slength($mode,4)
  validate_string($owner,$group)
  validate_bool($recurse)

  # make sure the mountpoint exists
  file { $mountpoint:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    recurse => $recurse,
    backup  => false;
  }

  mount { $mountpoint:
    ensure  => mounted,
    require => File[$mountpoint],
    device  => 'none',
    fstype  => $fstype,
    options => "defaults,mode=${mode},size=${size}",
  }
}
