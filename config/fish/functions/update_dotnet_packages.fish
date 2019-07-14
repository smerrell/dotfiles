function update_dotnet_packages
	set -l csproj $argv
	if not test -n $csproj
		echo "Missing project parameter"
		exit 1
	end

	set packages (cat $csproj | grep PackageReference | sed -n 's/^.* Include="\([^"]*\).*$/\1/p')
	for package in $packages
		dotnet add package $package
	end
end
