Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408C0123284
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfLQQbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 11:31:50 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18856 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfLQQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576600307; x=1608136307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=0HyRVMghdtV+tK4t2O4rhJZ4omB7wWKasfkgKQVvX+M=;
  b=DtJoiKX7iMc5GTUwOwsWZA8hutPbqlJ26UPj0MYZop6NxA0wEizlVzqR
   1cr8o8cbGQEvpzS1XcyaFDuRs3eKJXypsN/w+vfogBHZOkUjLW6NcmBJK
   8bfSAp5Um0rI59CHFipiL/axTIqartJVB14EwN2AGbpLS+/zXCGBV9KnJ
   k=;
IronPort-SDR: syuyglB0yNqcG0rDH91e1FUxt9b5bR/iJUx/EMDGw72mjqDGQdnwqATFUlXYhvlm7OR8CW4dw/
 PIQYYraJ4+kg==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="15427431"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 17 Dec 2019 16:31:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 986DCA20F8;
        Tue, 17 Dec 2019 16:31:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:31:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:31:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>
CC:     <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <roger.pau@citrix.com>,
        <sj38.park@gmail.com>, <sjpark@amazon.com>, <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 1/3] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Tue, 17 Dec 2019 17:31:06 +0100
Message-ID: <20191217163106.6497-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <027a402d-029a-e6c4-9f07-98728a161f22@suse.com>
References: <027a402d-029a-e6c4-9f07-98728a161f22@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D12UWA003.ant.amazon.com (10.43.160.50) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

I though it would be better to review separated patches, but seems it
was my mistake.  As Juergen asked, merged them again and post here.
Also, dropped Roger's reviewed-by.


Thanks,
SeongJae Park


------------------------ >8 -------------------------------------------
Subject: [PATCH 1/3] xen/blkback: Squeeze page pools if a memory pressure is
 detected

Each `blkif` has a free pages pool for the grant mapping.  The size of
the pool starts from zero and is increased on demand while processing
the I/O requests.  If current I/O requests handling is finished or 100
milliseconds has passed since last I/O requests handling, it checks and
shrinks the pool to not exceed the size limit, `max_buffer_pages`.

Therefore, host administrators can cause memory pressure in blkback by
attaching a large number of block devices and inducing I/O.  Such
problematic situations can be avoided by limiting the maximum number of
devices that can be attached, but finding the optimal limit is not so
easy.  Improper set of the limit can results in memory pressure or a
resource underutilization.  This commit avoids such problematic
situations by squeezing the pools (returns every free page in the pool
to the system) for a while (users can set this duration via a module
parameter) if memory pressure is detected.

Discussions
===========

The `blkback`'s original shrinking mechanism returns only pages in the
pool which are not currently be used by `blkback` to the system.  In
other words, the pages that are not mapped with granted pages.  Because
this commit is changing only the shrink limit but still uses the same
freeing mechanism it does not touch pages which are currently mapping
grants.

Once memory pressure is detected, this commit keeps the squeezing limit
for a user-specified time duration.  The duration should be neither too
long nor too short.  If it is too long, the squeezing incurring overhead
can reduce the I/O performance.  If it is too short, `blkback` will not
free enough pages to reduce the memory pressure.  This commit sets the
value as `10 milliseconds` by default because it is a short time in
terms of I/O while it is a long time in terms of memory operations.
Also, as the original shrinking mechanism works for at least every 100
milliseconds, this could be a somewhat reasonable choice.  I also tested
other durations (refer to the below section for more details) and
confirmed that 10 milliseconds is the one that works best with the test.
That said, the proper duration depends on actual configurations and
workloads.  That's why this commit allows users to set the duration as a
module parameter.

Memory Pressure Test
====================

To show how this commit fixes the memory pressure situation well, I
configured a test environment on a xen-running virtualization system.
On the `blkfront` running guest instances, I attach a large number of
network-backed volume devices and induce I/O to those.  Meanwhile, I
measure the number of pages that swapped in (pswpin) and out (pswpout)
on the `blkback` running guest.  The test ran twice, once for the
`blkback` before this commit and once for that after this commit.  As
shown below, this commit has dramatically reduced the memory pressure:

                pswpin  pswpout
    before      76,672  185,799
    after          212    3,325

Optimal Aggressive Shrinking Duration
-------------------------------------

To find a best squeezing duration, I repeated the test with three
different durations (1ms, 10ms, and 100ms).  The results are as below:

    duration    pswpin  pswpout
    1           852     6,424
    10          212     3,325
    100         203     3,340

As expected, the memory pressure has decreased as the duration is
increased, but the reduction stopped from the `10ms`.  Based on this
results, I chose the default duration as 10ms.

Performance Overhead Test
=========================

This commit could incur I/O performance degradation under severe memory
pressure because the squeezing will require more page allocations per
I/O.  To show the overhead, I artificially made a worst-case squeezing
situation and measured the I/O performance of a `blkfront` running
guest.

For the artificial squeezing, I set the `blkback.max_buffer_pages` using
the `/sys/module/xen_blkback/parameters/max_buffer_pages` file.  In this
test, I set the value to `1024` and `0`.  The `1024` is the default
value.  Setting the value as `0` is same to a situation doing the
squeezing always (worst-case).

If the underlying block device is slow enough, the squeezing overhead
could be hidden.  For the reason, I use a fast block device, namely the
rbd[1]:

    # xl block-attach guest phy:/dev/ram0 xvdb w

For the I/O performance measurement, I run a simple `dd` command 5 times
directly to the device as below and collect the 'MB/s' results.

    $ for i in {1..5}; do dd if=/dev/zero of=/dev/xvdb \
                             bs=4k count=$((256*512)); sync; done

The results are as below.  'max_pgs' represents the value of the
`blkback.max_buffer_pages` parameter.

    max_pgs   Min       Max       Median     Avg    Stddev
    0         417       423       420        419.4  2.5099801
    1024      414       425       416        417.8  4.4384682
    No difference proven at 95.0% confidence

In short, even worst case squeezing on ramdisk based fast block device
makes no visible performance degradation.  Please note that this is just
a very simple and minimal test.  On systems using super-fast block
devices and a special I/O workload, the results might be different.  If
you have any doubt, test on your machine with your workload to find the
optimal squeezing duration for you.

[1] https://www.kernel.org/doc/html/latest/admin-guide/blockdev/ramdisk.html

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../ABI/testing/sysfs-driver-xen-blkback      | 10 ++++++
 drivers/block/xen-blkback/blkback.c           |  7 ++--
 drivers/block/xen-blkback/common.h            |  1 +
 drivers/block/xen-blkback/xenbus.c            | 32 ++++++++++++++++++-
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index 4e7babb3ba1f..f01224231f3f 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -25,3 +25,13 @@ Description:
                 allocated without being in use. The time is in
                 seconds, 0 means indefinitely long.
                 The default is 60 seconds.
+
+What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
+Date:           December 2019
+KernelVersion:  5.5
+Contact:        SeongJae Park <sjpark@amazon.de>
+Description:
+                When memory pressure is reported to blkback this option
+                controls the duration in milliseconds that blkback will not
+                cache any page not backed by a grant mapping.
+                The default is 10ms.
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index fd1e19f1a49f..79f677aeb5cc 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -656,8 +656,11 @@ int xen_blkif_schedule(void *arg)
 			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
 		}
 
-		/* Shrink if we have more than xen_blkif_max_buffer_pages */
-		shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+		/* Shrink the free pages pool if it is too large. */
+		if (time_before(jiffies, blkif->buffer_squeeze_end))
+			shrink_free_pagepool(ring, 0);
+		else
+			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d773f7..536c84f61fed 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -319,6 +319,7 @@ struct xen_blkif {
 	/* All rings for this device. */
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
+	unsigned long		buffer_squeeze_end;
 };
 
 struct seg_buf {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b90dbcd99c03..20045827a391 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -492,6 +492,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 static int xen_blkbk_remove(struct xenbus_device *dev)
 {
 	struct backend_info *be = dev_get_drvdata(&dev->dev);
+	unsigned long flags;
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
 
@@ -504,6 +505,7 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		be->backend_watch.node = NULL;
 	}
 
+	spin_lock_irqsave(&dev->reclaim_lock, flags);
 	dev_set_drvdata(&dev->dev, NULL);
 
 	if (be->blkif) {
@@ -512,6 +514,7 @@ static int xen_blkbk_remove(struct xenbus_device *dev)
 		/* Put the reference we set in xen_blkif_alloc(). */
 		xen_blkif_put(be->blkif);
 	}
+	spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 
 	return 0;
 }
@@ -597,6 +600,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 	int err;
 	struct backend_info *be = kzalloc(sizeof(struct backend_info),
 					  GFP_KERNEL);
+	unsigned long flags;
 
 	/* match the pr_debug in xen_blkbk_remove */
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
@@ -607,6 +611,7 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 		return -ENOMEM;
 	}
 	be->dev = dev;
+	spin_lock_irqsave(&dev->reclaim_lock, flags);
 	dev_set_drvdata(&dev->dev, be);
 
 	be->blkif = xen_blkif_alloc(dev->otherend_id);
@@ -614,8 +619,10 @@ static int xen_blkbk_probe(struct xenbus_device *dev,
 		err = PTR_ERR(be->blkif);
 		be->blkif = NULL;
 		xenbus_dev_fatal(dev, err, "creating block interface");
+		spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 		goto fail;
 	}
+	spin_unlock_irqrestore(&dev->reclaim_lock, flags);
 
 	err = xenbus_printf(XBT_NIL, dev->nodename,
 			    "feature-max-indirect-segments", "%u",
@@ -824,6 +831,28 @@ static void frontend_changed(struct xenbus_device *dev,
 }
 
 
+/* Once a memory pressure is detected, squeeze free page pools for a while. */
+static unsigned int buffer_squeeze_duration_ms = 10;
+module_param_named(buffer_squeeze_duration_ms,
+		buffer_squeeze_duration_ms, int, 0644);
+MODULE_PARM_DESC(buffer_squeeze_duration_ms,
+"Duration in ms to squeeze pages buffer when a memory pressure is detected");
+
+/*
+ * Callback received when the memory pressure is detected.
+ */
+static void reclaim_memory(struct xenbus_device *dev)
+{
+	struct backend_info *be = dev_get_drvdata(&dev->dev);
+
+	/* Device is registered but not probed yet */
+	if (!be)
+		return;
+
+	be->blkif->buffer_squeeze_end = jiffies +
+		msecs_to_jiffies(buffer_squeeze_duration_ms);
+}
+
 /* ** Connection ** */
 
 
@@ -1115,7 +1144,8 @@ static struct xenbus_driver xen_blkbk_driver = {
 	.ids  = xen_blkbk_ids,
 	.probe = xen_blkbk_probe,
 	.remove = xen_blkbk_remove,
-	.otherend_changed = frontend_changed
+	.otherend_changed = frontend_changed,
+	.reclaim_memory = reclaim_memory,
 };
 
 int xen_blkif_xenbus_init(void)
-- 
2.17.1

