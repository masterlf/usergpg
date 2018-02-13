# usergpg

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with user gpg](#setup)
    * [Beginning with usergpg](#beginning-with-gpg)
3. [Usage - Configuration options](#usage)
    * [Customize usergpg](#Options)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

The usergpg module install gpg key for specific user.

this module is able to install public and private gpg key as needed. the user can be any user present in the agent as well as root.

## Setup

### Beginning with usergpg

To install a server with the default options:

`::usergpg::key { 'key_name':
    user => 'username'
    }`

## Usage

This module can download gpg key from puppet server or use a key file of your choice already present in a file on the agent

### Options

TODO: provide scenario

## Reference

TODO
man [gpgv2](https://linux.die.net/man/1/gpg2)

## Limitations

Should work fine on Ubuntu 16.04 and Centos 7 (not tested), both with GPGv2.

## Development

Feel free to PR and propose improvements.
