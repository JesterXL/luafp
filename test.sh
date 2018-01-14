# run unit tests
busted -c -p "test" tests

# generate coverage
luacov

# do... stuff with... report... or something
luacov-console

# show coverage
luacov-console -s