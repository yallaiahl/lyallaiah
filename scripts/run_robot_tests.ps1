New-Item -ItemType Directory -Force -Path results | Out-Null
robot --outputdir results tests
