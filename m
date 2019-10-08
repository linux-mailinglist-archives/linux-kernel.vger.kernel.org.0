Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83ACF49C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfJHIHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 04:07:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41680 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730478AbfJHIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:07:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0TeQ2MnF_1570522040;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TeQ2MnF_1570522040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Oct 2019 16:07:24 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, akpm@linux-foundation.org,
        mhocko@suse.com, willy@infradead.org, hannes@cmpxchg.org,
        ziqian.lzq@antfin.com, osandov@fb.com, arunks@codeaurora.org,
        ying.huang@intel.com, richard.weiyang@gmail.com, jgg@ziepe.ca,
        dan.j.williams@intel.com, rppt@linux.ibm.com, jglisse@redhat.com,
        b.zolnierkie@samsung.com, axboe@kernel.dk, dennis@kernel.org,
        nborisov@suse.com, tj@kernel.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC v4] zswap: Add CONFIG_ZSWAP_IO_SWITCH to handle swap IO issue
Date:   Tue,  8 Oct 2019 16:07:06 +0800
Message-Id: <1570522026-12757-1-git-send-email-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth version of this patch.  The perious versions
are in [1], [2] and [3].

The parameters read_in_flight_limit and write_in_flight_limit were
replaced by io_switch_enabled_enabled in this verion to make this
function more clear.

Currently, I use a VM that has 1 CPU, 4G memory and 4G swap file.
I found that swap will affect the IO performance when it is running.
So I open zswap to handle it because it just use CPU cycles but not
disk IO.

It work OK but I found that zswap is slower than normal swap in this
VM.  zswap is about 300M/s and normal swap is about 500M/s. (The reason
is the swap disk device config is "cache=none,aio=native".)
So open zswap is make memory shrinker slower but good for IO performance
in this VM.
So I just want zswap work when the disk of the swap file is under high
IO load.

This commit is designed for this idea.
When this function is enabled by the swap parameter
io_switch_enabled_enabled, zswap will just work when the swap disk has
outstanding I/O requests.

[1] https://lkml.org/lkml/2019/9/11/935
[2] https://lkml.org/lkml/2019/9/20/90
[3] https://lkml.org/lkml/2019/9/22/927

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 include/linux/swap.h |  3 +++
 mm/Kconfig           | 14 ++++++++++++++
 mm/page_io.c         | 16 ++++++++++++++++
 mm/zswap.c           | 25 +++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index de2c67a..82b621f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -389,6 +389,9 @@ extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
 extern int swap_set_page_dirty(struct page *page);
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+extern void swap_io_in_flight(struct page *page, unsigned int inflight[2]);
+#endif
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/mm/Kconfig b/mm/Kconfig
index 56cec63..f5740e3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -546,6 +546,20 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
+config ZSWAP_IO_SWITCH
+	bool "Compressed cache for swap pages according to the IO status"
+	depends on ZSWAP
+	help
+	  This function helps the system that normal swap speed is higher
+	  than zswap speed to handle the swap IO issue.
+	  For example, a VM where the swap disk device with config
+	  "cache=none,aio=native".
+
+	  When this function is enabled by the swap parameter
+	  io_switch_enabled_enabled, zswap will just work when the swap disk
+	  has outstanding I/O requests.
+	  If unsure, say "n".
+
 config ZPOOL
 	tristate "Common API for compressed memory storage"
 	help
diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600..e66b050 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -434,3 +434,19 @@ int swap_set_page_dirty(struct page *page)
 		return __set_page_dirty_no_writeback(page);
 	}
 }
+
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+void swap_io_in_flight(struct page *page, unsigned int inflight[2])
+{
+	struct swap_info_struct *sis = page_swap_info(page);
+
+	if (!sis->bdev) {
+		inflight[0] = 0;
+		inflight[1] = 0;
+		return;
+	}
+
+	part_in_flight_rw(bdev_get_queue(sis->bdev), sis->bdev->bd_part,
+					  inflight);
+}
+#endif
diff --git a/mm/zswap.c b/mm/zswap.c
index 0e22744..b50d8fb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -114,6 +114,18 @@ static bool zswap_same_filled_pages_enabled = true;
 module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
 		   bool, 0644);
 
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+/*
+ * Enable/disable the io switch functon (disabled by default)
+ * When the io switch functon is enabled, zswap will only try to
+ * store pages when IO of the swap device is low (read and write io in
+ * flight number is 0).
+ */
+static bool zswap_io_switch_enabled;
+module_param_named(io_switch_enabled_enabled, zswap_io_switch_enabled,
+		   bool, 0644);
+#endif
+
 /*********************************
 * data structures
 **********************************/
@@ -1009,6 +1021,19 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto reject;
 	}
 
+#ifdef CONFIG_ZSWAP_IO_SWITCH
+	if (zswap_io_switch_enabled) {
+		unsigned int inflight[2];
+
+		swap_io_in_flight(page, inflight);
+
+		if (inflight[0] == 0 || inflight[1] == 0) {
+			ret = -EIO;
+			goto reject;
+		}
+	}
+#endif
+
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
 		zswap_pool_limit_hit++;
-- 
2.7.4

