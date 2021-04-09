# CalMenu

A simple, yet useful, menu extras item to show the current month on macOS 10.15+.

<p>
    <img src="images/image1.png" height="414em" />
    <img src="images/image2.png" height="414em" />
</p>

The changelog is available [here](./CHANGELOG.md)

## Deploying

1. Bump app version in XCode
1. Generate the archive in XCode
1. Send to notarization
1. Export the notarized app to *releases* folder
1. Compress the app to a file named `CalMenu.app-v{version}.zip`
1. Generate changelog files per version
    ```shell
    scripts/generate_changelog.py CHANGELOG.md
    ```
1. Update appcast.xml
    ```shell
    scripts/generate_appcast releases
    ```