[string]$Path = "HKLM:\SYSTEM\CurrentControlSet\services\i8042prt\Parameters"
$LDriverJP = @("kbd106.dll","kbd101.dll")
$OverKbdId = @("PCAT_106KEY", "PCAT_101KEY")
$OverKbdType = @(7, 7)
$OverKbdSType = @(2, 0)

function Change-KbdLayout(){

    Write-Host "Change keyboad layout" -ForegroundColor Cyan
    Write-Host "[0] JIS" -ForegroundColor Cyan
    Write-Host "[1] US" -ForegroundColor Cyan
    Write-Host "[9] Confirm current setting" -ForegroundColor Cyan
    Write-Host "[q] exit" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Enter number" -NoNewline -ForegroundColor Yellow
    $Flag = Read-Host

    if(($Flag -eq 0) -or ($Flag -eq 1))
    {
        #レジストリ変更
        Set-ItemProperty -Path $Path -Name "LayerDriver JPN" -Value $LDriverJP[$Flag]
        Set-ItemProperty -Path $Path -Name "OverrideKeyboardIdentifier" -Value $OverKbdId[$Flag]
        Set-ItemProperty -Path $Path -Name "OverrideKeyboardType" -Value $OverKbdType[$Flag]
        Set-ItemProperty -Path $Path -Name "OverrideKeyboardSubtype" -Value $OverKbdSType[$Flag]

        Get-ItemProperty -Path $Path

        #再起勁E
        Write-Host "Restart computer" -ForegroundColor Yellow
        Write-Host "[Y]Restart [N]Agter restart Default[N]:" -NoNewline -ForegroundColor Yellow
        $Return = Read-Host
        if($Return -eq "Y")
        {
            Restart-Computer -Force
            return
        }
    }
    elseif($Flag -eq 9)
    {
        Write-Host "Current setting"
        Get-ItemProperty -Path $Path
    }
    elseif($Flag -eq "q")
    {
        return
    }

    Change-KbdLayout
}

Change-KbdLayout