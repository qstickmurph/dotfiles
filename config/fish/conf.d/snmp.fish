function refresh-mibs
  set -l mibsfile ~/.config/snmp/mibs

  if not test -f $mibsfile
    echo "refresh-mibs: $mibsfile does not exist" >&2
    return 1
  end

  set -l mibs
  set -l mibdirs

  for mib in (cat $mibsfile | string match -rv '^\s*(#|$)')

    set -l expanded

    if string match -q -- '*\**' $mib
      set expanded (fish -c "printf '%s\n' $mib" 2>/dev/null)

      if test (count $expanded) -eq 0
        echo "refresh-mibs: warning: no matches for glob: $mib" >&2
        continue
      end
    else
      set expanded $mib
    end

    for path in $expanded
      if test -f $path
        set -a mibs $path
      else if test -d $path
        set -a mibdirs $path
      else
        echo "refresh-mibs: warning: path does not exist: $path" >&2
      end
    end
  end

  if test (count $mibs) -eq 0
    echo "refresh-mibs: no valid MIBs found" >&2
    return 1
  end

  set -gx MIBS (string join : $mibs)
  set -gx MIBDIRS (string join : $mibdirs)

  echo "MIBS=$MIBS"
  echo "MIBDIRS=$MIBDIRS"
end
