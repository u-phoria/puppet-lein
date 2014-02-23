class lein (
   $tmpdir = '/tmp',
   $destdir = '/usr/bin',
   $version = 'stable',
) {
  package {'wget':}
  file { "$tmpdir/lein-$version":
    alias => "createtmpdir",
    ensure => "directory",
  }
  exec { "/usr/bin/wget https://raw.github.com/technomancy/leiningen/$version/bin/lein":
    alias => "leinlatest",
    cwd => "$tmpdir/lein-$version",
    require => File["createtmpdir"],
    creates => "$tmpdir/lein-$version/lein", # shouldn't do anything if already exists
  }
  file { "$destdir/lein": 
    ensure => present,
    source => "$tmpdir/lein-$version/lein",
    subscribe => Exec['leinlatest']
  }
}
