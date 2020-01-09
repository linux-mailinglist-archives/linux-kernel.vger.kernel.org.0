Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB38413625F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgAIVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 16:20:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725763AbgAIVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:20:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009LHdlg108791;
        Thu, 9 Jan 2020 16:19:57 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe2vswwev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 16:19:57 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 009LI2rU109581;
        Thu, 9 Jan 2020 16:19:56 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xe2vswwdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 16:19:56 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 009LG2g4029750;
        Thu, 9 Jan 2020 21:19:55 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 2xajb85beq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 21:19:55 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009LJruN47251770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 21:19:53 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF98E136053;
        Thu,  9 Jan 2020 21:19:53 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34339136055;
        Thu,  9 Jan 2020 21:19:53 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 21:19:52 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.ibm.com>
Subject: [PATCH] drivers/base/memory.c: cache blocks in radix tree to accelerate lookup
Date:   Thu,  9 Jan 2020 15:19:52 -0600
Message-Id: <20200109211952.12747-1-cheloha@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217193238-1-cheloha@linux.vnet.ibm.com>
References: <20191217193238-1-cheloha@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_05:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching for a particular memory block by id is an O(n) operation
because each memory block's underlying device is kept in an unsorted
linked list on the subsystem bus.

We can cut the lookup cost to O(log n) if we cache the memory blocks in
a radix tree.  With a radix tree cache in place both memory subsystem
initialization and memory hotplug run palpably faster on systems with a
large number of memory blocks.

Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Nathan Lynch <nathanl@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v2 incorporates suggestions from David Hildenbrand.

v3 changes:
  - Rebase atop "drivers/base/memory.c: drop the mem_sysfs_mutex"

  - Be conservative: don't use radix_tree_for_each_slot() in
    walk_memory_blocks() yet.  It introduces RCU which could
    change behavior.  Walking the tree "by hand" with
    find_memory_block_by_id() is slower but keeps the patch
    simple.

v4 changes:
  - Rewrite commit message to explicitly note the time
    complexity improvements.

  - Provide anecdotal accounts of time-savings in the changelog
    (see below).

mhocko@suse.com has asked for additional details on time
savings, so here are some results I've collected when measuring
memory_dev_init() with/without the patch.

1. A 32GB POWER9 VM with 16MB memblocks has 2048 blocks:

# Unpatched
[    0.005121] adding memory block 0... ok
[...]
[    0.095230] adding memory block 1024... ok
[...]
[    0.304248] adding memory block 2047... ok
[    0.304508] added all memory blocks

# Patched
[    0.004701] adding memory block 0... ok
[...]
[    0.033383] adding memory block 1024... ok
[...]
[    0.061387] adding memory block 2047... ok
[    0.061414] added all memory blocks

   Unpatched, memory_dev_init() runs in about 0.299 seconds.  Patched,
   it runs in about 0.057 seconds.  Savings of .242 seconds, or nearly
   a quarter of a second.

2. A 32TB POWER9 LPAR with 256MB memblocks has 131072 blocks:

# Unpatched
[   13.703907] memory_dev_init: adding blocks
[   13.703931] memory_dev_init: added block 0
[   13.762678] memory_dev_init: added block 1024
[   13.910359] memory_dev_init: added block 2048
[   14.146941] memory_dev_init: added block 3072
[...]
[  218.516235] memory_dev_init: added block 57344
[  229.310467] memory_dev_init: added block 58368
[  240.590857] memory_dev_init: added block 59392
[  252.351665] memory_dev_init: added block 60416
[...]
[ 2152.023248] memory_dev_init: added block 128000
[ 2196.464430] memory_dev_init: added block 129024
[ 2241.746515] memory_dev_init: added block 130048
[ 2287.406099] memory_dev_init: added all blocks

# Patched
[   13.696898] memory_dev_init: adding blocks
[   13.696920] memory_dev_init: added block 0
[   13.710966] memory_dev_init: added block 1024
[   13.724865] memory_dev_init: added block 2048
[   13.738802] memory_dev_init: added block 3072
[...]
[   14.520999] memory_dev_init: added block 57344
[   14.536355] memory_dev_init: added block 58368
[   14.551747] memory_dev_init: added block 59392
[   14.567128] memory_dev_init: added block 60416
[...]
[   15.595638] memory_dev_init: added block 126976
[   15.611761] memory_dev_init: added block 128000
[   15.627889] memory_dev_init: added block 129024
[   15.644048] memory_dev_init: added block 130048
[   15.660035] memory_dev_init: added all blocks

   Unpatched, memory_dev_init() runs in about 2275 seconds,
   or ~37 minutes.  Patched, memory_dev_init() runs in about
   1.97 seconds.  Savings of ~37 minutes.

   I did not actually measure walk_memory_blocks(), but during
   boot on this machine without the patch I got the following
   (abbreviated) traces:

[ 2347.494986] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2527.625378] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2707.761977] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 2887.899975] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3068.028318] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3248.158764] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3428.287296] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3608.425357] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3788.554572] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 3968.695071] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160
[ 4148.823970] [c000000014c5bb60] [c000000000869af4] walk_memory_blocks+0x94/0x160

   Those traces disappeared with the patch, so I'm pretty sure
   this patch shaves ~30 minutes off of walk_memory_blocks()
   at boot.

Given the above results I think it is safe to say that this patch will
dramatically improve boot times on large POWER systems.

 drivers/base/memory.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 799b43191dea..8902930d5ef2 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -19,6 +19,7 @@
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
 #include <linux/mm.h>
+#include <linux/radix-tree.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 
@@ -56,6 +57,13 @@ static struct bus_type memory_subsys = {
 	.offline = memory_subsys_offline,
 };
 
+/*
+ * Memory blocks are cached in a local radix tree to avoid
+ * a costly linear search for the corresponding device on
+ * the subsystem bus.
+ */
+static RADIX_TREE(memory_blocks, GFP_KERNEL);
+
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
@@ -572,20 +580,14 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
 /* A reference for the returned memory block device is acquired. */
 static struct memory_block *find_memory_block_by_id(unsigned long block_id)
 {
-	struct device *dev;
+	struct memory_block *mem;
 
-	dev = subsys_find_device_by_id(&memory_subsys, block_id, NULL);
-	return dev ? to_memory_block(dev) : NULL;
+	mem = radix_tree_lookup(&memory_blocks, block_id);
+	if (mem)
+		get_device(&mem->dev);
+	return mem;
 }
 
-/*
- * For now, we have a linear search to go find the appropriate
- * memory_block corresponding to a particular phys_index. If
- * this gets to be a real problem, we can always use a radix
- * tree or something here.
- *
- * This could be made generic for all device subsystems.
- */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
 	unsigned long block_id = base_memory_block_id(__section_nr(section));
@@ -628,9 +630,15 @@ int register_memory(struct memory_block *memory)
 	memory->dev.offline = memory->state == MEM_OFFLINE;
 
 	ret = device_register(&memory->dev);
-	if (ret)
+	if (ret) {
 		put_device(&memory->dev);
-
+		return ret;
+	}
+	ret = radix_tree_insert(&memory_blocks, memory->dev.id, memory);
+	if (ret) {
+		put_device(&memory->dev);
+		device_unregister(&memory->dev);
+	}
 	return ret;
 }
 
@@ -688,6 +696,8 @@ static void unregister_memory(struct memory_block *memory)
 	if (WARN_ON_ONCE(memory->dev.bus != &memory_subsys))
 		return;
 
+	WARN_ON(radix_tree_delete(&memory_blocks, memory->dev.id) == NULL);
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
-- 
2.24.1

