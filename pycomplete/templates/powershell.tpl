# Powershell completion script for %{script_name}
# Generated by pycomplete %{version}

if ((Test-Path Function:\TabExpansion) -and -not (Test-Path Function:\%{function}Backup)) {
    Rename-Item Function:\TabExpansion %{function}Backup
}

function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    $aliases = @(%{aliases})
    $aliasPattern = "($($aliases -join '|'))"
    if ($lastBlock -match "^$aliasPattern ") {
        $command = ($lastBlock.Split() | Where-Object { $_ -NotLike "-*" })[1]

        if ($lastWord.StartsWith("-")) {
            # Complete options
            $opts = @(%{opts})
            Switch ($command) {

%{command_list}

                default {}
            }
            $opts | Where-Object { $_ -Like "$lastWord*" }
        } elseif ($lastWord -eq $command) {
            # Complete commands
            $commands = @(%{coms})

            $commands | Where-Object { $_ -Like "$lastWord*" }
        }


    }
    elseif (Test-Path Function:\%{function}Backup) {
        # Fall back on existing tab expansion
        %{function}Backup $line $lastWord
    }
}
