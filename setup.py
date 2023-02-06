"""vpp_snmp_agent setuptools setup.py for pip and deb pkg installations"""
from setuptools import setup

setup(
    name="vpp-snmp-agent",
    version="0.0.1",
    install_requires=[
        "requests",
        'importlib-metadata; python_version >= "3.8"',
        "vpp_papi",
    ],
    packages=["vpp_snmp_agent", "vpp_snmp_agent/agentx"],
    entry_points={
        "console_scripts": [
            "vpp-snmp-agent = vpp_snmp_agent.vpp_snmp_agent:main",
        ]
    }
)
