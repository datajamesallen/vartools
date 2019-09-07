"""
command line application for reducing repetitive variant analysis
"""
from setuptools import find_packages, setup

dependencies = ['click','openpyxl']

setup(
    name='vartools',
    version='0.1.0',
    url='https://github.com/datajamesallen/vartools',
    license='BSD',
    author='James Allen',
    author_email='jpatallen@protonmail.com',
    description='command line application for reducing repetitive variant analysis',
    long_description=__doc__,
    packages=find_packages(exclude=['tests']),
    include_package_data=True,
    zip_safe=False,
    platforms='any',
    install_requires=dependencies,
    package_data = {'vartools': ['oocytes/blank.oo', 'config.ini']},
    entry_points={
        'console_scripts': [
            'vartools = vartools.cli:main',
        ],
    },
    classifiers=[
        # As from http://pypi.python.org/pypi?%3Aaction=list_classifiers
        # 'Development Status :: 1 - Planning',
        # 'Development Status :: 2 - Pre-Alpha',
        # 'Development Status :: 3 - Alpha',
        'Development Status :: 4 - Beta',
        # 'Development Status :: 5 - Production/Stable',
        # 'Development Status :: 6 - Mature',
        # 'Development Status :: 7 - Inactive',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: BSD License',
        'Operating System :: POSIX',
        'Operating System :: MacOS',
        'Operating System :: Unix',
        'Operating System :: Microsoft :: Windows',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3',
        'Topic :: Software Development :: Libraries :: Python Modules',
    ]
)
