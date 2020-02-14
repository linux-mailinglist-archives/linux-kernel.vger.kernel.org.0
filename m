Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9858215D4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBNJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 04:45:17 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729166AbgBNJpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:45:15 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 23EBED497044317487E6;
        Fri, 14 Feb 2020 17:45:11 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 17:45:00 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: clean up bggc mount option
Date:   Fri, 14 Feb 2020 17:44:13 +0800
Message-ID: <20200214094413.12784-4-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200214094413.12784-1-yuchao0@huawei.com>
References: <20200214094413.12784-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three status for background gc: on, off and sync, it's
a little bit confused to use test_opt(BG_GC) and test_opt(FORCE_FG_GC)
combinations to indicate status of background gc.

So let's remove F2FS_MOUNT_BG_GC and F2FS_MOUNT_FORCE_FG_GC mount
options, and add F2FS_OPTION().bggc_mode with below three status
to clean up codes and enhance bggc mode's scalability.

enum {
	BGGC_MODE_ON,		/* background gc is on */
	BGGC_MODE_OFF,		/* background gc is off */
	BGGC_MODE_SYNC,		/*
				 * background gc is on, migrating blocks
				 * like foreground gc
				 */
};

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 12 ++++++++++--
 fs/f2fs/gc.c    |  6 +++++-
 fs/f2fs/super.c | 29 +++++++++++++----------------
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d2d50827772c..9f65ba8057ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -74,7 +74,6 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 /*
  * For mount options
  */
-#define F2FS_MOUNT_BG_GC		0x00000001
 #define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000002
 #define F2FS_MOUNT_DISCARD		0x00000004
 #define F2FS_MOUNT_NOHEAP		0x00000008
@@ -88,7 +87,6 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_NOBARRIER		0x00000800
 #define F2FS_MOUNT_FASTBOOT		0x00001000
 #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
-#define F2FS_MOUNT_FORCE_FG_GC		0x00004000
 #define F2FS_MOUNT_DATA_FLUSH		0x00008000
 #define F2FS_MOUNT_FAULT_INJECTION	0x00010000
 #define F2FS_MOUNT_USRQUOTA		0x00080000
@@ -137,6 +135,7 @@ struct f2fs_mount_info {
 	int alloc_mode;			/* segment allocation policy */
 	int fsync_mode;			/* fsync policy */
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
+	int bggc_mode;			/* bggc mode: off, on or sync */
 	bool test_dummy_encryption;	/* test dummy encryption */
 	block_t unusable_cap;		/* Amount of space allowed to be
 					 * unusable when disabling checkpoint
@@ -1170,6 +1169,15 @@ enum {
 	GC_URGENT,
 };
 
+enum {
+	BGGC_MODE_ON,		/* background gc is on */
+	BGGC_MODE_OFF,		/* background gc is off */
+	BGGC_MODE_SYNC,		/*
+				 * background gc is on, migrating blocks
+				 * like foreground gc
+				 */
+};
+
 enum {
 	FS_MODE_ADAPTIVE,	/* use both lfs/ssr allocation */
 	FS_MODE_LFS,		/* use lfs allocation only */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8aebe2b9c655..897de003e423 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -31,6 +31,8 @@ static int gc_thread_func(void *data)
 
 	set_freezable();
 	do {
+		bool sync_mode;
+
 		wait_event_interruptible_timeout(*wq,
 				kthread_should_stop() || freezing(current) ||
 				gc_th->gc_wake,
@@ -101,8 +103,10 @@ static int gc_thread_func(void *data)
 do_gc:
 		stat_inc_bggc_count(sbi->stat_info);
 
+		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+
 		/* if return value is not zero, no victim was selected */
-		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, NULL_SEGNO))
+		if (f2fs_gc(sbi, sync_mode, true, NULL_SEGNO))
 			wait_ms = gc_th->no_gc_sleep_time;
 
 		trace_f2fs_background_gc(sbi->sb, wait_ms,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 427409eff354..4ef7e6eb37da 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -427,14 +427,11 @@ static int parse_options(struct super_block *sb, char *options)
 			if (!name)
 				return -ENOMEM;
 			if (strlen(name) == 2 && !strncmp(name, "on", 2)) {
-				set_opt(sbi, BG_GC);
-				clear_opt(sbi, FORCE_FG_GC);
+				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 			} else if (strlen(name) == 3 && !strncmp(name, "off", 3)) {
-				clear_opt(sbi, BG_GC);
-				clear_opt(sbi, FORCE_FG_GC);
+				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
 			} else if (strlen(name) == 4 && !strncmp(name, "sync", 4)) {
-				set_opt(sbi, BG_GC);
-				set_opt(sbi, FORCE_FG_GC);
+				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
 			} else {
 				kvfree(name);
 				return -EINVAL;
@@ -1436,14 +1433,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
 
-	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, BG_GC)) {
-		if (test_opt(sbi, FORCE_FG_GC))
-			seq_printf(seq, ",background_gc=%s", "sync");
-		else
-			seq_printf(seq, ",background_gc=%s", "on");
-	} else {
+	if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC)
+		seq_printf(seq, ",background_gc=%s", "sync");
+	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_ON)
+		seq_printf(seq, ",background_gc=%s", "on");
+	else if (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF)
 		seq_printf(seq, ",background_gc=%s", "off");
-	}
+
 	if (test_opt(sbi, DISABLE_ROLL_FORWARD))
 		seq_puts(seq, ",disable_roll_forward");
 	if (test_opt(sbi, DISCARD))
@@ -1573,8 +1569,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
 	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
 	F2FS_OPTION(sbi).compress_ext_cnt = 0;
+	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 
-	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
@@ -1780,7 +1776,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if background_gc = off is passed in mount
 	 * option. Also sync the filesystem.
 	 */
-	if ((*flags & SB_RDONLY) || !test_opt(sbi, BG_GC)) {
+	if ((*flags & SB_RDONLY) ||
+			F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_OFF) {
 		if (sbi->gc_thread) {
 			f2fs_stop_gc_thread(sbi);
 			need_restart_gc = true;
@@ -3664,7 +3661,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * If filesystem is not mounted as read-only then
 	 * do start the gc_thread.
 	 */
-	if (test_opt(sbi, BG_GC) && !f2fs_readonly(sb)) {
+	if (F2FS_OPTION(sbi).bggc_mode != BGGC_MODE_OFF && !f2fs_readonly(sb)) {
 		/* After POR, we can run background GC thread.*/
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
-- 
2.18.0.rc1

