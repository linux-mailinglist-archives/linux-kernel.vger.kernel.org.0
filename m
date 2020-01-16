Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3513D755
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgAPKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 05:01:25 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55590 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730717AbgAPKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:01:24 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712966|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.558945-0.0280628-0.412993;DS=CONTINUE|ham_alarm|0.198028-0.000466123-0.801506;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Gd3Kgdg_1579168866;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Gd3Kgdg_1579168866)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 16 Jan 2020 18:01:16 +0800
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
Subject: [PATCH 04/11] pstore/blk: blkoops: support console recorder
Date:   Thu, 16 Jan 2020 18:00:24 +0800
Message-Id: <1579168831-16399-5-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1579168831-16399-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1579168831-16399-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support recorder for console. To enable console recorder, just make
console_size be greater than 0 and a multiple of 4096.

Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig          |  12 ++++++
 fs/pstore/blkoops.c        |  11 +++++
 fs/pstore/blkzone.c        | 100 ++++++++++++++++++++++++++++++++++-----------
 include/linux/blkoops.h    |   6 ++-
 include/linux/pstore_blk.h |   8 +++-
 5 files changed, 111 insertions(+), 26 deletions(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 656d63dc3f01..af83ae59f31a 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -198,6 +198,18 @@ config PSTORE_BLKOOPS_PMSG_SIZE
 	  NOTE that, both kconfig and module parameters can configure blkoops,
 	  but module parameters have priority over kconfig.
 
+config PSTORE_BLKOOPS_CONSOLE_SIZE
+	int "console size in kbytes for blkoops"
+	depends on PSTORE_BLKOOPS
+	depends on PSTORE_CONSOLE
+	default 64
+	help
+	  This just sets size of console (console_size) for pstore/blk. The
+	  value must be a multiple of 4096.
+
+	  NOTE that, both kconfig and module parameters can configure blkoops,
+	  but module parameters have priority over kconfig.
+
 config PSTORE_BLKOOPS_BLKDEV
 	string "block device for blkoops"
 	depends on PSTORE_BLKOOPS
diff --git a/fs/pstore/blkoops.c b/fs/pstore/blkoops.c
index 846ba8bc930f..8e1235308cdb 100644
--- a/fs/pstore/blkoops.c
+++ b/fs/pstore/blkoops.c
@@ -35,6 +35,10 @@
 module_param(pmsg_size, long, 0400);
 MODULE_PARM_DESC(pmsg_size, "pmsg size in kbytes");
 
+static long console_size = -1;
+module_param(console_size, long, 0400);
+MODULE_PARM_DESC(console_size, "console size in kbytes");
+
 static int dump_oops = -1;
 module_param(dump_oops, int, 0400);
 MODULE_PARM_DESC(total_size, "whether dump oops");
@@ -85,6 +89,12 @@
 #define DEFAULT_PMSG_SIZE 0
 #endif
 
+#ifdef CONFIG_PSTORE_BLKOOPS_CONSOLE_SIZE
+#define DEFAULT_CONSOLE_SIZE CONFIG_PSTORE_BLKOOPS_CONSOLE_SIZE
+#else
+#define DEFAULT_CONSOLE_SIZE 0
+#endif
+
 #ifdef CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
 #define DEFAULT_DUMP_OOPS CONFIG_PSTORE_BLKOOPS_DUMP_OOPS
 #else
@@ -139,6 +149,7 @@ int blkoops_register_device(struct blkoops_device *bo_dev)
 
 	verify_size(dmesg_size, DEFAULT_DMESG_SIZE, 4096);
 	verify_size(pmsg_size, DEFAULT_PMSG_SIZE, 4096);
+	verify_size(console_size, DEFAULT_CONSOLE_SIZE, 4096);
 #undef verify_size
 	dump_oops = !!(dump_oops < 0 ? DEFAULT_DUMP_OOPS : dump_oops);
 
diff --git a/fs/pstore/blkzone.c b/fs/pstore/blkzone.c
index 8716c51d7f98..679aaf598e9e 100644
--- a/fs/pstore/blkzone.c
+++ b/fs/pstore/blkzone.c
@@ -104,9 +104,11 @@ struct blkz_zone {
 struct blkz_context {
 	struct blkz_zone **dbzs;	/* dmesg block zones */
 	struct blkz_zone *pbz;		/* Pmsg block zone */
+	struct blkz_zone *cbz;		/* console block zone */
 	unsigned int dmesg_max_cnt;
 	unsigned int dmesg_read_cnt;
 	unsigned int pmsg_read_cnt;
+	unsigned int console_read_cnt;
 	unsigned int dmesg_write_cnt;
 	/*
 	 * the counter should be recovered when recover.
@@ -127,6 +129,9 @@ struct blkz_context {
 };
 static struct blkz_context blkz_cxt;
 
+static void blkz_flush_all_dirty_zones(struct work_struct *);
+static DECLARE_WORK(blkz_cleaner, blkz_flush_all_dirty_zones);
+
 enum blkz_flush_mode {
 	FLUSH_NONE = 0,
 	FLUSH_PART,
@@ -215,6 +220,9 @@ static int blkz_zone_write(struct blkz_zone *zone,
 	return 0;
 set_dirty:
 	atomic_set(&zone->dirty, true);
+	/* flush dirty zones nicely */
+	if (wcnt == -EBUSY && !is_on_panic())
+		schedule_work(&blkz_cleaner);
 	return -EBUSY;
 }
 
@@ -281,6 +289,15 @@ static int blkz_move_zone(struct blkz_zone *old, struct blkz_zone *new)
 	return 0;
 }
 
+static void blkz_flush_all_dirty_zones(struct work_struct *work)
+{
+	struct blkz_context *cxt = &blkz_cxt;
+
+	blkz_flush_dirty_zone(cxt->pbz);
+	blkz_flush_dirty_zone(cxt->cbz);
+	blkz_flush_dirty_zones(cxt->dbzs, cxt->dmesg_max_cnt);
+}
+
 static int blkz_recover_dmesg_data(struct blkz_context *cxt)
 {
 	struct blkz_info *info = cxt->bzinfo;
@@ -434,15 +451,13 @@ static int blkz_recover_dmesg(struct blkz_context *cxt)
 	return ret;
 }
 
-static int blkz_recover_pmsg(struct blkz_context *cxt)
+static int blkz_recover_zone(struct blkz_context *cxt, struct blkz_zone *zone)
 {
 	struct blkz_info *info = cxt->bzinfo;
 	struct blkz_buffer *oldbuf;
-	struct blkz_zone *zone = NULL;
 	int ret = 0;
 	ssize_t rcnt, len;
 
-	zone = cxt->pbz;
 	if (!zone || zone->oldbuf)
 		return 0;
 
@@ -508,7 +523,11 @@ static inline int blkz_recovery(struct blkz_context *cxt)
 	if (ret)
 		goto recover_fail;
 
-	ret = blkz_recover_pmsg(cxt);
+	ret = blkz_recover_zone(cxt, cxt->pbz);
+	if (ret)
+		goto recover_fail;
+
+	ret = blkz_recover_zone(cxt, cxt->cbz);
 	if (ret)
 		goto recover_fail;
 
@@ -527,6 +546,7 @@ static int blkz_pstore_open(struct pstore_info *psi)
 
 	cxt->dmesg_read_cnt = 0;
 	cxt->pmsg_read_cnt = 0;
+	cxt->console_read_cnt = 0;
 	return 0;
 }
 
@@ -554,7 +574,7 @@ static inline int blkz_dmesg_erase(struct blkz_context *cxt,
 	return blkz_zone_write(zone, FLUSH_META, NULL, 0, 0);
 }
 
-static inline int blkz_pmsg_erase(struct blkz_context *cxt,
+static inline int blkz_record_erase(struct blkz_context *cxt,
 		struct blkz_zone *zone)
 {
 	if (unlikely(!blkz_old_ok(zone)))
@@ -581,9 +601,10 @@ static int blkz_pstore_erase(struct pstore_record *record)
 	case PSTORE_TYPE_DMESG:
 		return blkz_dmesg_erase(cxt, cxt->dbzs[record->id]);
 	case PSTORE_TYPE_PMSG:
-		return blkz_pmsg_erase(cxt, cxt->pbz);
-	default:
-		return -EINVAL;
+		return blkz_record_erase(cxt, cxt->pbz);
+	case PSTORE_TYPE_CONSOLE:
+		return blkz_record_erase(cxt, cxt->cbz);
+	default: return -EINVAL;
 	}
 }
 
@@ -668,17 +689,15 @@ static int notrace blkz_dmesg_write(struct blkz_context *cxt,
 	return 0;
 }
 
-static int notrace blkz_pmsg_write(struct blkz_context *cxt,
-		struct pstore_record *record)
+static int notrace blkz_record_write(struct blkz_context *cxt,
+		struct blkz_zone *zone, struct pstore_record *record)
 {
-	struct blkz_zone *zone;
 	size_t start, rem;
 	int cnt = record->size;
 	bool is_full_data = false;
 	char *buf = record->buf;
 
-	zone = cxt->pbz;
-	if (!zone)
+	if (!zone || !record)
 		return -ENOSPC;
 
 	if (atomic_read(&zone->buffer->datalen) >= zone->buffer_size)
@@ -725,11 +744,20 @@ static int notrace blkz_pstore_write(struct pstore_record *record)
 			record->reason == KMSG_DUMP_PANIC)
 		atomic_set(&cxt->on_panic, 1);
 
+	/*
+	 * if on panic, do not write except dmesg records
+	 * Fix case that panic_write prints log which wakes up console recorder.
+	 */
+	if (is_on_panic() && record->type != PSTORE_TYPE_DMESG)
+		return -EBUSY;
+
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
 		return blkz_dmesg_write(cxt, record);
+	case PSTORE_TYPE_CONSOLE:
+		return blkz_record_write(cxt, cxt->cbz, record);
 	case PSTORE_TYPE_PMSG:
-		return blkz_pmsg_write(cxt, record);
+		return blkz_record_write(cxt, cxt->pbz, record);
 	default:
 		return -EINVAL;
 	}
@@ -753,6 +781,13 @@ static struct blkz_zone *blkz_read_next_zone(struct blkz_context *cxt)
 			return zone;
 	}
 
+	if (cxt->console_read_cnt == 0) {
+		cxt->console_read_cnt++;
+		zone = cxt->cbz;
+		if (blkz_old_ok(zone))
+			return zone;
+	}
+
 	return NULL;
 }
 
@@ -814,7 +849,7 @@ static ssize_t blkz_dmesg_read(struct blkz_zone *zone,
 	return size + hlen;
 }
 
-static ssize_t blkz_pmsg_read(struct blkz_zone *zone,
+static ssize_t blkz_record_read(struct blkz_zone *zone,
 		struct pstore_record *record)
 {
 	size_t size, start;
@@ -840,7 +875,7 @@ static ssize_t blkz_pmsg_read(struct blkz_zone *zone,
 static ssize_t blkz_pstore_read(struct pstore_record *record)
 {
 	struct blkz_context *cxt = record->psi->data;
-	ssize_t (*blkz_read)(struct blkz_zone *zone,
+	ssize_t (*readop)(struct blkz_zone *zone,
 			struct pstore_record *record);
 	struct blkz_zone *zone;
 	ssize_t ret;
@@ -858,17 +893,18 @@ static ssize_t blkz_pstore_read(struct pstore_record *record)
 	record->type = zone->type;
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
-		blkz_read = blkz_dmesg_read;
+		readop = blkz_dmesg_read;
 		record->id = cxt->dmesg_read_cnt - 1;
 		break;
+	case PSTORE_TYPE_CONSOLE:
 	case PSTORE_TYPE_PMSG:
-		blkz_read = blkz_pmsg_read;
+		readop = blkz_record_read;
 		break;
 	default:
 		goto next_zone;
 	}
 
-	ret = blkz_read(zone, record);
+	ret = readop(zone, record);
 	if (ret == READ_NEXT_ZONE)
 		goto next_zone;
 	return ret;
@@ -1016,15 +1052,25 @@ static int blkz_cut_zones(struct blkz_context *cxt)
 		goto fail_out;
 	}
 
+	off_size += info->console_size;
+	cxt->cbz = blkz_init_zone(PSTORE_TYPE_CONSOLE, &off,
+			info->console_size);
+	if (IS_ERR(cxt->cbz)) {
+		err = PTR_ERR(cxt->cbz);
+		goto free_pmsg;
+	}
+
 	cxt->dbzs = blkz_init_zones(PSTORE_TYPE_DMESG, &off,
 			info->total_size - off_size,
 			info->dmesg_size, &cxt->dmesg_max_cnt);
 	if (IS_ERR(cxt->dbzs)) {
 		err = PTR_ERR(cxt->dbzs);
-		goto free_pmsg;
+		goto free_console;
 	}
 
 	return 0;
+free_console:
+	blkz_free_zone(&cxt->cbz);
 free_pmsg:
 	blkz_free_zone(&cxt->pbz);
 fail_out:
@@ -1042,7 +1088,7 @@ int blkz_register(struct blkz_info *info)
 		return -EINVAL;
 	}
 
-	if (!info->dmesg_size && !info->pmsg_size) {
+	if (!info->dmesg_size && !info->pmsg_size && !info->console_size) {
 		pr_warn("at least one of the records be non-zero\n");
 		return -EINVAL;
 	}
@@ -1070,6 +1116,7 @@ int blkz_register(struct blkz_info *info)
 	check_size(total_size, 4096);
 	check_size(dmesg_size, SECTOR_SIZE);
 	check_size(pmsg_size, SECTOR_SIZE);
+	check_size(console_size, SECTOR_SIZE);
 
 #undef check_size
 
@@ -1102,6 +1149,7 @@ int blkz_register(struct blkz_info *info)
 	pr_debug("\ttotal size : %ld Bytes\n", info->total_size);
 	pr_debug("\tdmesg size : %ld Bytes\n", info->dmesg_size);
 	pr_debug("\tpmsg size : %ld Bytes\n", info->pmsg_size);
+	pr_debug("\tconsole size : %ld Bytes\n", info->console_size);
 
 	err = blkz_cut_zones(cxt);
 	if (err) {
@@ -1123,11 +1171,15 @@ int blkz_register(struct blkz_info *info)
 		cxt->pstore.flags |= PSTORE_FLAGS_DMESG;
 	if (info->pmsg_size)
 		cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
+	if (info->console_size)
+		cxt->pstore.flags |= PSTORE_FLAGS_CONSOLE;
 
-	pr_info("Registered %s as blkzone backend for %s%s%s\n", info->name,
+	pr_info("Registered %s as blkzone backend for %s%s%s%s\n",
+			info->name,
 			cxt->dbzs && cxt->bzinfo->dump_oops ? "Oops " : "",
 			cxt->dbzs && cxt->bzinfo->panic_write ? "Panic " : "",
-			cxt->pbz ? "Pmsg" : "");
+			cxt->pbz ? "Pmsg " : "",
+			cxt->cbz ? "Console" : "");
 
 	err = pstore_register(&cxt->pstore);
 	if (err) {
@@ -1154,6 +1206,8 @@ void blkz_unregister(struct blkz_info *info)
 {
 	struct blkz_context *cxt = &blkz_cxt;
 
+	flush_work(&blkz_cleaner);
+
 	pstore_unregister(&cxt->pstore);
 	kfree(cxt->pstore.buf);
 	cxt->pstore.bufsize = 0;
diff --git a/include/linux/blkoops.h b/include/linux/blkoops.h
index fe63739309aa..8f40f225545d 100644
--- a/include/linux/blkoops.h
+++ b/include/linux/blkoops.h
@@ -23,8 +23,10 @@
  *	Both of the @size and @offset parameters on this interface are
  *	the relative size of the space provided, not the whole disk/flash.
  *
- *	On success, the number of bytes read should be returned.
- *	On error, negative number should be returned.
+ *	On success, the number of bytes read/write should be returned.
+ *	On error, negative number should be returned. The following returning
+ *	number means more:
+ *	  -EBUSY: pstore/blk should try again later.
  * @panic_write:
  *	The write operation only used for panic.
  *
diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index af06be25bd01..546375e04419 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -22,6 +22,9 @@
  * @pmsg_size:
  *	The size of zone for pmsg. Zero means disabled, othewise, it must be
  *	multiple of SECTOR_SIZE(512).
+ * @console_size:
+ *	The size of zone for console. Zero means disabled, othewise, it must
+ *	be multiple of SECTOR_SIZE(512).
  * @dump_oops:
  *	Dump oops and panic log or only panic.
  * @read, @write:
@@ -33,7 +36,9 @@
  *	the relative size of the space provided, not the whole disk/flash.
  *
  *	On success, the number of bytes read/write should be returned.
- *	On error, negative number should be returned.
+ *	On error, negative number should be returned. The following returning
+ *	number means more:
+ *	  -EBUSY: pstore/blk should try again later.
  * @panic_write:
  *	The write operation only used for panic. It's optional if you do not
  *	care panic record. If panic occur but blkzone do not recover yet, the
@@ -54,6 +59,7 @@ struct blkz_info {
 	unsigned long total_size;
 	unsigned long dmesg_size;
 	unsigned long pmsg_size;
+	unsigned long console_size;
 	int dump_oops;
 	blkz_read_op read;
 	blkz_write_op write;
-- 
1.9.1

