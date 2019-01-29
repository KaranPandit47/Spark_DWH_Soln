# Check package dependency and install if not present
from pip._internal import main


def check_dependency():
	pkgs = ['pandas']
	for package in pkgs:
		try:
			import package
		except ImportError:
			main(['install', package])

if __name__ == '__main__':
	check_dependency()		
