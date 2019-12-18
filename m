Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3611250BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfLRShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 13:37:48 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:20524 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576694268; x=1608230268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6aYnzds9BF7bd/ktBuL6CxJjY5pmEpuzxZF1/5BjyeM=;
  b=I/0aU+mO4Da1I0R6mjsb2MN3Cwa+gTRva7OAA37nIjS4wpqC9TE95KdT
   nb9c0x9MdgDOPdoYHRYJ+XH/zJoYAC25Nd7SS4FE7lS3TFEH/jhpa1z6x
   HMwU+AltiFQOG/hjdN7oqN2hvfrkyN5whNeXblPpp2m3XWdROVhe6mEm1
   I=;
IronPort-SDR: XQPrqb/oNc03XfSNsIFpBqjAx3UW2KfrL9lLsvXIYbxL8I597b9H8rXHCUirM9tac4Kf/l+32z
 Dl7AwWb7xp9A==
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="9082721"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 18 Dec 2019 18:37:46 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 35CF9A2511;
        Wed, 18 Dec 2019 18:37:44 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 18:37:43 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Dec 2019 18:37:38 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <pdurrant@amazon.com>,
        <sj38.park@gmail.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 0/5] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 18 Dec 2019 19:37:13 +0100
Message-ID: <20191218183718.31719-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.109]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and then introduce a lock for race
condition avoidance (patch 2).  After that, patch 3 applies the callback
mechanism to mitigate the problem in 'xen-blkback'.  The fourth and
fifth patches are trivial cleanups; those fix nits we found during the
development of this patchset.

Note that patches 1, 4, and 5 are not changed since v9.


Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/patches/blkback/buffer_squeeze/v13


Patch History
-------------

Changes from v12
(https://lore.kernel.org/xen-devel/20191218104232.9606-1-sjpark@amazon.com/)
 - Do not unnecessarily disable interrupts (suggested by Juergen)
 - Hold lock from xenbus side (suggested by Juergen)

Changes from v11
(https://lore.kernel.org/xen-devel/20191217160748.693-2-sjpark@amazon.com/)
 - Fix wrong trylock use (reported by Juergen)
 - Merge patch 3 and 4 (suggested by Juergen)
 - Update test result

Changes from v10
(https://lore.kernel.org/xen-devel/20191216124527.30306-1-sjpark@amazon.com/)
 - Fix race condition (reported by SeongJae, suggested by Juergen)

Changes from v9
(https://lore.kernel.org/xen-devel/20191213153546.17425-1-sjpark@amazon.de/)
 - Add 'Reviewed-by' and 'Acked-by' from Roger Pau Monné
 - Update the commit message for overhead test of the 2nd path

Changes from v8
(https://lore.kernel.org/xen-devel/20191213130211.24011-1-sjpark@amazon.de/)
 - Drop 'Reviewed-by: Juergen' from the second patch
   (suggested by Roger Pau Monné)
 - Update contact of the new module param to SeongJae Park
   <sjpark@amazon.de>
   (suggested by Roger Pau Monné)
 - Wordsmith the description of the parameter
   (suggested by Roger Pau Monné)
 - Fix dumb bugs
   (suggested by Roger Pau Monné)
 - Move module param definition to xenbus.c and reduce the number of
   lines for this change
   (suggested by Roger Pau Monné)
 - Add a comment for the new callback, reclaim_memory, as other
   callbacks also have
 - Add another trivial cleanup of xenbus.c file (4th patch)

Changes from v7
(https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/)
 - Update sysfs-driver-xen-blkback for new parameter
   (suggested by Roger Pau Monné)
 - Use per-xen_blkif buffer_squeeze_end instead of global variable
   (suggested by Roger Pau Monné)

Changes from v6
(https://lore.kernel.org/linux-block/20191211042428.5961-1-sjpark@amazon.de/)
 - Remove more unnecessary prefixes (suggested by Roger Pau Monné)
 - Constify a variable (suggested by Roger Pau Monné)
 - Rename 'reclaim' into 'reclaim_memory' (suggested by Roger Pau Monné)
 - More wordsmith of the commit message (suggested by Roger Pau Monné)

Changes from v5
(https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
 - Wordsmith the commit messages (suggested by Roger Pau Monné)
 - Change the reclaim callback return type (suggested by Roger Pau
   Monné)
 - Change the type of the blkback squeeze duration variable
   (suggested by Roger Pau Monné)
 - Add a patch for removal of unnecessary static variable name prefixes
   (suggested by Roger Pau Monné)
 - Fix checkpatch.pl warnings

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Juergen
   Gross)
 - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen
   Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity
   (aggressive shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily`
   (suggested by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch


SeongJae Park (5):
  xenbus/backend: Add memory pressure handler callback
  xenbus/backend: Protect xenbus callback with lock
  xen/blkback: Squeeze page pools if a memory pressure is detected
  xen/blkback: Remove unnecessary static variable name prefixes
  xen/blkback: Consistently insert one empty line between functions

 .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++
 drivers/block/xen-blkback/blkback.c           | 42 +++++++++----------
 drivers/block/xen-blkback/common.h            |  1 +
 drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++---
 drivers/xen/xenbus/xenbus_probe.c             |  8 +++-
 drivers/xen/xenbus/xenbus_probe_backend.c     | 38 +++++++++++++++++
 include/xen/xenbus.h                          |  3 ++
 7 files changed, 103 insertions(+), 27 deletions(-)

-- 
2.17.1

