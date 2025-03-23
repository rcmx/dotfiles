# apps to uninstall
$bloatApps = @(
  @{name = "3D Viewer"; source = "msstore" },
  @{name = "Cortana"; source = "msstore" },
  @{name = "Feedback Hub"; source = "msstore" },
  @{name = "MSN Weather"; source = "msstore" },
  @{name = "Mail and Calendar"; source = "msstore" },
  @{name = "Microsoft 365 Copilot"; source = "msstore" },
  @{name = "Microsoft Clipchamp"; source = "msstore" },
  @{name = "Microsoft OneDrive"; source = "msstore" }
  @{name = "Microsoft Pay"; source = "msstore" },
  @{name = "Microsoft People"; source = "msstore" },
  @{name = "Microsoft People"; source = "msstore" },
  @{name = "Microsoft Photos"; source = "msstore" },
  @{name = "Microsoft Solitaire Collection"; source = "msstore" },
  @{name = "Microsoft Sticky Notes"; source = "msstore" }
  @{name = "Microsoft Teams" }
  @{name = "Microsoft Teams (personal)" }
  @{name = "Microsoft To Do"; source = "msstore" }
  @{name = "Mixed Reality Portal"; source = "msstore" },
  @{name = "Movies & TV"; source = "msstore" },
  @{name = "Office"; source = "msstore" },
  @{name = "OneNote for Windows 10"; source = "msstore" },
  @{name = "OneNote"; source = "msstore" },
  @{name = "Outlook for Windows"; source = "msstore" },
  @{name = "Paint 3D"; source = "msstore" },
  @{name = "Phone Link"; source = "msstore" },
  @{name = "Skype"; source = "msstore" },
  @{name = "Solitaire & Casual Games"; source = "msstore" },
  @{name = "Windows Maps"; source = "msstore" }
  @{name = "Xbox Game Speech Window"; source = "msstore" }
  @{name = "Xbox Identity Provider"; source = "msstore" }
)

# get list of already installed apps
Write-Host "removing bloatware"
Foreach ($app in $bloatApps) {
  Write-host "Removing: [$($app.name)]"

  $cmd = "winget uninstall --exact --name ""$($app.name)"""
  if ($app.source -ne $null) {
    $cmd += " --source $($app.source)"
  }

  Invoke-Expression $cmd
 
  if ($LASTEXITCODE -lt 0) {
    Write-Error "failed to remove [$app]. exit code [$LASTEXITCODE]"
  }
}

