
# Fixes issues, but also overrides your manually set data

# Delete all .DS_Store files on user home, custom appended info for files will get wiped
find ~ -name '.DS_Store' -depth -exec rm {} \;
