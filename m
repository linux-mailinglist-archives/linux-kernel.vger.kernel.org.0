Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0B14213B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 02:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgATBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 20:04:24 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59870 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728895AbgATBEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:04:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.405886-0.0232577-0.570856;DS=CONTINUE|ham_regular_dialog|0.0837547-0.000396562-0.915849;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gf.OYKf_1579482234;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gf.OYKf_1579482234)
          by smtp.aliyun-inc.com(10.147.42.16);
          Mon, 20 Jan 2020 09:04:08 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v1 09/11] pstore/blk: blkoops: support special removing jobs for dmesg.
Date:   Mon, 20 Jan 2020 09:03:51 +0800
Message-Id: <1579482233-2672-10-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's one of a series of patches for adaptive to MTD device.

MTD device is not block device. To write to flash device on MTD, erase
must to be done before. However, pstore/blk just set datalen as 0 when
remove, which is not enough for mtd device. That's why this patch here,
to support special jobs when removing pstore/blk record.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 Documentation/admin-guide/pstore-block.rst |  9 +++++++++
 fs/pstore/blkoops.c                        |  4 +++-
 fs/pstore/blkzone.c                        |  9 ++++++++-
 include/linux/blkoops.h                    | 10 ++++++++++
 include/linux/pstore_blk.h                 | 11 +++++++++++
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pstore-block.rst b/Documentation/admin-guide/pstore-block.rst
index f4fc205406aa..e351b0ebd8e5 100644
--- a/Documentation/admin-guide/pstore-block.rst
+++ b/Documentation/admin-guide/pstore-block.rst
@@ -197,6 +197,15 @@ negative number will be returned. The following return numbers mean more:
 1. -EBUSY: pstore/blk should try again later.
 #. -ENEXT: this zone is used or broken, pstore/blk should try next one.
 
+erase
+~~~~~
+
+It's generic erase API for pstore/blk, which is requested by non-block device.
+It will be called while pstore record is removing. It's required only when the
+device has special removing jobs. For example, MTD device tries to erase block.
+
+Normally zero should be returned, otherwise it indicates an error.
+
 panic_write (for non-block device)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
index d9b51880144b..6b74189e5820 100644
--- a/fs/pstore/blkoops.c
+++ b/fs/pstore/blkoops.c
@@ -179,6 +179,7 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
 	bzinfo->dump_oops = dump_oops;
 	bzinfo->read = bo_dev->read;
 	bzinfo->write = bo_dev->write;
+	bzinfo->erase = bo_dev->erase;
 	bzinfo->panic_write = bo_dev->panic_write;
 	bzinfo->name = "blkoops";
 	bzinfo->owner = THIS_MODULE;
@@ -398,10 +399,11 @@ int blkoops_register_blkdev(unsigned int major, unsigned int flags,
 	bo_dev.total_size = blkoops_bdev_size(bdev);
 	if (bo_dev.total_size == 0)
 		goto err_put_bdev;
-	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
 	bo_dev.flags = flags;
 	bo_dev.read = blkoops_generic_blk_read;
 	bo_dev.write = blkoops_generic_blk_write;
+	bo_dev.erase = NULL;
+	bo_dev.panic_write = panic_write ? blkoops_blk_panic_write : NULL;
 
 	ret = blkoops_register_device(&bo_dev);
 	if (ret)
diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
index 3f58ff85f49c..a006a4a5b012 100644
--- a/fs/pstore/blkzone.c
+++ b/fs/pstore/blkzone.c
@@ -609,11 +609,18 @@ static inline bool blkz_ok(struct blkz_zone *zone)
 static inline int blkz_dmesg_erase(struct blkz_context *cxt,
 		struct blkz_zone *zone)
 {
+	size_t size;
+
 	if (unlikely(!blkz_ok(zone)))
 		return 0;
 
 	atomic_set(&zone->buffer->datalen, 0);
-	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
+
+	size = buffer_datalen(zone) + sizeof(*zone->buffer);
+	if (cxt->bzinfo->erase)
+		return cxt->bzinfo->erase(size, zone->off);
+	else
+		return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
 
 static inline int blkz_record_erase(struct blkz_context *cxt,
diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
index bc7665d14a98..11cb3036ad5f 100644
--- a/include/linux/blkoops.h
+++ b/include/linux/blkoops.h
@@ -33,6 +33,15 @@
  *	number means more:
  *	  -EBUSY: pstore/blk should try again later.
  *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
+ * @erase:
+ *	The general (not panic) erase operation. It will be call while pstore
+ *	record is removing. It's required only when device have special
+ *	removing jobs, for example, MTD device try to erase block.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, 0 should be returned. Others mean error.
  * @panic_write:
  *	The write operation only used for panic.
  *
@@ -53,6 +62,7 @@ struct blkoops_device {
 	unsigned long total_size;
 	blkz_read_op read;
 	blkz_write_op write;
+	blkz_erase_op erase;
 	blkz_write_op panic_write;
 };
 
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index bbbe4fe37f7c..9641969f888f 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -46,6 +46,15 @@
  *	number means more:
  *	  -EBUSY: pstore/blk should try again later.
  *	  -ENEXT: this zone is used or broken, pstore/blk should try next one.
+ * @erase:
+ *	The general (not panic) erase operation. It will be call while pstore
+ *	record is removing. It's required only when device have special
+ *	removing jobs, for example, MTD device try to erase block.
+ *
+ *	Both of the @size and @offset parameters on this interface are
+ *	the relative size of the space provided, not the whole disk/flash.
+ *
+ *	On success, 0 should be returned. Others mean error.
  * @panic_write:
  *	The write operation only used for panic. It's optional if you do not
  *	care panic record. If panic occur but blkzone do not recover yet, the
@@ -59,6 +68,7 @@
  */
 typedef ssize_t (*blkz_read_op)(char *, size_t, loff_t);
 typedef ssize_t (*blkz_write_op)(const char *, size_t, loff_t);
+typedef ssize_t (*blkz_erase_op)(size_t, loff_t);
 struct blkz_info {
 	struct module *owner;
 	const char *name;
@@ -71,6 +81,7 @@ struct blkz_info {
 	int dump_oops;
 	blkz_read_op read;
 	blkz_write_op write;
+	blkz_erase_op erase;
 	blkz_write_op panic_write;
 };
 
-- 
1.9.1

