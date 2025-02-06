# for collecting coverage data on Windows with Git Bash
# the canonical, Perl-based HTML generator wasn't as easy to set up as the dotnet reportgenerator:
# winget install Microsoft.DotNet.SDK.8 # if you don't already have the dotnet CLI
# dotnet tool install --global dotnet-coverage
# dotnet tool install --global dotnet-reportgenerator-globaltool
# also requires Dart coverage package:
# pub global activate coverage
flutter pub global run full_coverage
flutter test --branch-coverage
reportgenerator "-reports:./coverage/lcov.info" "-targetdir:./coverage/report" '-filefilters:-lib\generated\**'
start ./coverage_report/index.html