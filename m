Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC94D4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfFTRXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:23:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbfFTRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PtklCVYV8bfZXS0SZvAiOjrQ2yJ2ynrocAeQpsRsGX4=; b=qvy1DnsrQMDY+x7l2EDUa1Zzt
        xH+CIfz798eRgQY5Dwqv5+1Vljg6V97bxL+2kW12XBVpiZSNBUkF45q0S2EqcBAUzEYrQb9A292SS
        SHpspALsABTf0JfPK/Mf2E+bfeFaeYeozApspZuFz6vC/+i0ERMr4YFxxVWooJAWU93T91kio6B+v
        keFWRxSDm71JYxBAkDUYF++SlVECMUqfEAEt5UJkCjZg03fOakEUTxDjdL1YVsGxeOjCVE3h2ykEa
        BAWp9RqNtku+W1LN2uJGbd40rpcNyHl93x3HxfeDWK3azPlN5/jMVrnxivRmyuaAmWvxYnS6c0j00
        cmgZjQ9Vw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rr-CV; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Cc-GA; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 00/22] Add ABI and features docs to the Kernel documentation
Date:   Thu, 20 Jun 2019 14:22:52 -0300
Message-Id: <cover.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version of the scripts with parse
Documentation/ABI and Documentation/feature files
and produce a ReST output. Those scripts are added to the
Kernel building system, in order to output their contents
inside the Kernel documentation.

Please notice that, as discussed, I added support at get_abi.pl
to handle ABI files as if they're compatible with ReST. Right
now, this feature can't be enabled for normal builds, as it will
cause Sphinx crashes. After getting the offending ABI files fixed,
a single line change will be enough to make it default.

a version "0" was sent back on 2017.

v1: 
  - rebased version of ABI scripts requested during KS/2019 discussions,
    with some additional changes for it to parse newer ABI files;

v2:
  - Some additional fixes and improvements to get_abi.pl script;
  - get_abi.pl script now optionally suports parsing ABI files with
    uses ReST format (by default, this is disabled);
  - Added scripts/get_feat.pl to parse Documentation/features;
  - Added SPDX headers.

Mauro Carvalho Chehab (22):
  ABI: sysfs-bus-pci-devices-aer_stats uses an invalid tag
  ABI: Fix KernelVersion tags
  scripts: add an script to parse the ABI files
  scripts/get_abi.pl: parse files with text at beginning
  scripts/get_abi.pl: avoid use literal blocks when not needed
  scripts/get_abi.pl: split label naming from xref logic
  scripts/get_abi.pl: add support for searching for ABI symbols
  scripts/get_abi.pl: represent what in tables
  scripts/get_abi.pl: fix parse issues with some files
  scripts/get_abi.pl: avoid creating duplicate names
  scripts/get_abi.pl: add a handler for invalid "where" tag
  scripts/get_abi.pl: add a validate command
  doc-rst: add ABI documentation to the admin-guide book
  docs: sphinx/kernel_abi.py: fix UTF-8 support
  sphinx/kernel_abi.py: make it compatible with Sphinx 1.7+
  docs: Kconfig/Makefile: add a check for broken ABI files
  docs: kernel_abi.py: Update copyrights
  doc: ABI scripts: add a SPDX header file
  scripts: add a script to handle Documentation/features
  docs: admin-guide, x86: add a features list
  scripts/get_feat.pl: handle ".." special case
  scripts/get_abi.pl: change script to allow parsing in ReST mode

 Documentation/ABI/testing/pstore              |   2 +-
 .../sysfs-bus-event_source-devices-format     |   2 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |   6 +-
 .../testing/sysfs-bus-pci-devices-aer_stats   |  24 +-
 .../ABI/testing/sysfs-bus-pci-devices-cciss   |  22 +-
 .../testing/sysfs-bus-usb-devices-usbsevseg   |  10 +-
 .../ABI/testing/sysfs-driver-altera-cvp       |   2 +-
 Documentation/ABI/testing/sysfs-driver-ppi    |   2 +-
 Documentation/ABI/testing/sysfs-driver-st     |   2 +-
 Documentation/ABI/testing/sysfs-driver-wacom  |   2 +-
 Documentation/Kconfig                         |  11 +
 Documentation/Makefile                        |   5 +
 Documentation/admin-guide/abi-obsolete.rst    |  10 +
 Documentation/admin-guide/abi-removed.rst     |   4 +
 Documentation/admin-guide/abi-stable.rst      |  13 +
 Documentation/admin-guide/abi-testing.rst     |  19 +
 Documentation/admin-guide/abi.rst             |  11 +
 Documentation/admin-guide/features.rst        |   3 +
 Documentation/admin-guide/index.rst           |   2 +
 Documentation/conf.py                         |   2 +-
 Documentation/sphinx/kernel_abi.py            | 166 ++++++
 Documentation/sphinx/kernel_feat.py           | 169 ++++++
 Documentation/x86/features.rst                |   3 +
 Documentation/x86/index.rst                   |   1 +
 lib/Kconfig.debug                             |   2 +
 scripts/get_abi.pl                            | 498 ++++++++++++++++++
 scripts/get_feat.pl                           | 474 +++++++++++++++++
 27 files changed, 1429 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/Kconfig
 create mode 100644 Documentation/admin-guide/abi-obsolete.rst
 create mode 100644 Documentation/admin-guide/abi-removed.rst
 create mode 100644 Documentation/admin-guide/abi-stable.rst
 create mode 100644 Documentation/admin-guide/abi-testing.rst
 create mode 100644 Documentation/admin-guide/abi.rst
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/sphinx/kernel_abi.py
 create mode 100644 Documentation/sphinx/kernel_feat.py
 create mode 100644 Documentation/x86/features.rst
 create mode 100755 scripts/get_abi.pl
 create mode 100755 scripts/get_feat.pl

-- 
2.21.0


