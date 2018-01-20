rm luacov.report.out
rm luacov.report.out.index
rm luacov.stats.out
rm -rf ./coverage
rm -rf coverage
busted -c test
luacov
# luacov-console
# luacov-console -s


# mkdir ./coverage
# cp luacov.stats.out ./coverage/lcov.info
luacov-coveralls -i luafp -t 97tePdW8ffhc1OED7xCnW2EuDd2nyCVQ3
# istanbul report