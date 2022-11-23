environment:
	brew install swiftgen || true

all:
	swiftgen config run --config ./Swiftgen/strings.yml
	swiftgen config run --config ./Swiftgen/fonts.yml
	swiftgen config run --config ./Swiftgen/assets.yml