.PHONY: test docs build

install:
	-pip install -e .

build:
	-rm -f dist/*
	python setup.py sdist bdist_wheel --universal
	ls -la dist

clean:
	-rm -f ./*.so
	-rm -rf ./docs/build
	-rm -rf ./.cache
	-rm -rf ./build
	-rm -rf ./dist
	-rm -rf ./temp
	-rm -rf ./_trial_temp
	-rm -rf ./.tox
	-rm -rf ./.eggs
	-rm -rf ./htmlcov
	-rm -f ./.coverage
	-rm -f ./coverage.xml
	-rm -f ./.coverage.*
	-rm -rf ~/coverage
	-rm -f  ./twisted/plugins/dropin.cache
	-find . -name "*dropin.cache.new" -type f -exec rm -f {} \;
	-find . -name "*.tar.gz" -type f -exec rm -f {} \;
	-find . -name "*.egg" -type f -exec rm -f {} \;
	-find . -name "*.pyc" -type f -exec rm -f {} \;
	-find . \( -name "*__pycache__" -type d \) -prune -exec rm -rf {} +

publish: clean
	python setup.py sdist bdist_wheel --universal
	twine upload dist/*

docs:
	cd docs && make html

spelling:
	cd docs && sphinx-build -b spelling . _spelling
