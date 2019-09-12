Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0353B06E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 04:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfILCyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 22:54:52 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:51600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbfILCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:54:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 36473100E806B;
        Thu, 12 Sep 2019 02:54:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:69:355:379:541:968:973:988:989:1260:1345:1437:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:2894:3138:3139:3140:3141:3142:3353:3865:3867:3868:3870:4605:5007:6261:7974:10004:10848:11658:11914:12043:12291:12297:12679:12683:12895:14093:14096:14394:14721:14824:21080:21451:21627:21740:30054:30056:30070,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: band82_814fcf5b47631
X-Filterd-Recvd-Size: 2846
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:54:48 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] nvdimm: Use more common kernel coding style
Date:   Wed, 11 Sep 2019 19:54:30 -0700
Message-Id: <cover.1568256705.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have a local coding style, use the typical kernel style.

Joe Perches (13):
  nvdimm: Use more typical whitespace
  nvdimm: Move logical continuations to previous line
  nvdimm: Use octal permissions
  nvdimm: Use a more common kernel spacing style
  nvdimm: Use "unsigned int" in preference to "unsigned"
  nvdimm: Add and remove blank lines
  nvdimm: Use typical kernel brace styles
  nvdimm: Use typical kernel style indentation
  nvdimm: btt.h: Neaten #defines to improve readability
  nvdimm: namespace_devs: Move assignment operators
  nvdimm: Use more common logic testing styles and bare ; positions
  nvdimm: namespace_devs: Change progess typo to progress
  nvdimm: Miscellaneous neatening

 drivers/nvdimm/badrange.c       |  22 +-
 drivers/nvdimm/blk.c            |  39 ++--
 drivers/nvdimm/btt.c            | 249 +++++++++++----------
 drivers/nvdimm/btt.h            |  56 ++---
 drivers/nvdimm/btt_devs.c       |  68 +++---
 drivers/nvdimm/bus.c            | 138 ++++++------
 drivers/nvdimm/claim.c          |  50 ++---
 drivers/nvdimm/core.c           |  42 ++--
 drivers/nvdimm/dax_devs.c       |   3 +-
 drivers/nvdimm/dimm.c           |   3 +-
 drivers/nvdimm/dimm_devs.c      | 107 ++++-----
 drivers/nvdimm/e820.c           |   2 +-
 drivers/nvdimm/label.c          | 213 +++++++++---------
 drivers/nvdimm/label.h          |   6 +-
 drivers/nvdimm/namespace_devs.c | 472 +++++++++++++++++++++-------------------
 drivers/nvdimm/nd-core.h        |  31 +--
 drivers/nvdimm/nd.h             |  94 ++++----
 drivers/nvdimm/nd_virtio.c      |  20 +-
 drivers/nvdimm/of_pmem.c        |   6 +-
 drivers/nvdimm/pfn_devs.c       | 136 ++++++------
 drivers/nvdimm/pmem.c           |  57 ++---
 drivers/nvdimm/pmem.h           |   2 +-
 drivers/nvdimm/region.c         |  20 +-
 drivers/nvdimm/region_devs.c    | 160 +++++++-------
 drivers/nvdimm/security.c       | 138 ++++++------
 drivers/nvdimm/virtio_pmem.c    |  10 +-
 26 files changed, 1115 insertions(+), 1029 deletions(-)

-- 
2.15.0

