class lein (
   $tmpdir = '/tmp',
   $destdir = '/usr/bin',
   $version = 'stable',
) {
  package {'wget':}
  exec { "/usr/bin/wget --timestamping https://raw.github.com/technomancy/leiningen/$version/bin/lein":
      alias => "leinlatest",
      cwd => "$tmpdir/lein-$version",
  }
  file { "$destdir/lein": 
    ensure => present,
    source => '$tmpdir/lein-$version/lein',
  }
}
