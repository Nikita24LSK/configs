if ($args.Length -eq 0) {
    exit
}

$LISTPATH = "C:\Users\виртуал\Desktop\radiolist"
[regex]$num_re = "[0-9]+$"
$hotkeys = (
    '--global-key-quit alt-x',
    '--global-key-play-pause alt-p'
)

if ($args[0] -eq "list") {
    $stations = gc $LISTPATH | select-string -Pattern "  .+$" | % {$_.Matches} | % {$_.Value}
    for ($i = 1; $i -le $stations.Count; $i++) {
        $ch_str = $stations[$i-1].Replace("  ", "")
        write-output "$($i) $($ch_str)"
    }
}
elseif ($args[0] -match $num_re) {
    $station_num = [int]$args[0]
    $station_value = gc $LISTPATH | measure-object -line | % {$_.Lines}
    $station_value = [int]$station_value

    if ($station_num -gt $station_value) {
        exit
    }

    $station = gc $LISTPATH |  select-string -Pattern "^.+  " | % {$_.Matches} | % {$_.Value} | select -first $station_num | select -last 1
    $station = $station.Replace("  ", "")

    $end_command = 'vlc -I dummy ' +  $($hotkeys -join ' ') + ' ' + $station
    Invoke-Expression $end_command
}
else {
    exit
}