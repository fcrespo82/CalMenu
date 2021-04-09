#!.venv/bin/python
import argparse
import re
from pprint import pprint
import markdown

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('FILE', help='Changelog file')
    args = parser.parse_args()

    versions = dict()
    with open(args.FILE, 'r') as changelog_file:
        changelog = ''.join(changelog_file.readlines())

        regex = r'^## \[(?P<version>[^Unreleased].*?)\](?: - (?P<date>\d{4}-\d{2}-\d{2}))?\s+(?P<changes>.*?)(?=## \[|<!-- END -->)'

        matches = re.finditer(regex, changelog, re.MULTILINE + re.DOTALL)

        for matchNum, match in enumerate(matches, start=1):
            versions.update({match.group('version'): match.groupdict()})

    latest = sorted(versions)[-1]

    for version in versions:
        output = markdown.markdown(versions[version]['changes'].strip())
        
        with open(f'releases/CalMenu.app-v{version}.html', 'w') as releasenotes_file:
            releasenotes_file.write(output)


if __name__ == "__main__":
    main()
