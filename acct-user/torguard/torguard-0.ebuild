# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for torguard"
ACCT_USER_HOME=/opt/torguard
ACCT_USER_ID=100
ACCT_USER_GROUPS=( torguard )

acct-user_add_deps
