Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F90A70F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfICQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:47:48 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:50319 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfICQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:47:48 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 926AA3A32A; Tue,  3 Sep 2019 18:47:40 +0200 (CEST)
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: exfat: cleanup braces for if/else statements
Date:   Tue,  3 Sep 2019 18:47:32 +0200
Message-Id: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings:

  CHECK: Unbalanced braces around else statement
  CHECK: braces {} should be used on all arms of this statement

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/exfat/exfat_core.c  | 12 ++++++------
 drivers/staging/exfat/exfat_super.c | 16 +++++++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 46b9f4455da1..1246afcffb8d 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -743,11 +743,11 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 				pr_debug("to 0x%X (amount of 0x%X)\n",
 					 index, uni);
 				skip = FALSE;
-			} else if (uni == index)
+			} else if (uni == index) {
 				index++;
-			else if (uni == 0xFFFF)
+			} else if (uni == 0xFFFF) {
 				skip = TRUE;
-			else { /* uni != index , uni != 0xFFFF */
+			} else { /* uni != index , uni != 0xFFFF */
 				u16 col_index = get_col_index(index);
 
 				if (upcase_table[col_index] == NULL) {
@@ -805,11 +805,11 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 			index += uni;
 			pr_debug("to 0x%X (amount of 0x%X)\n", index, uni);
 			skip = FALSE;
-		} else if (uni == index)
+		} else if (uni == index) {
 			index++;
-		else if (uni == 0xFFFF)
+		} else if (uni == 0xFFFF) {
 			skip = TRUE;
-		else { /* uni != index , uni != 0xFFFF */
+		} else { /* uni != index , uni != 0xFFFF */
 			u16 col_index = get_col_index(index);
 
 			if (upcase_table[col_index] == NULL) {
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 881cd85cf677..e44b860e35e8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -344,8 +344,10 @@ static int exfat_cmpi(const struct dentry *dentry, unsigned int len,
 		if (t == NULL) {
 			if (strncasecmp(name->name, str, alen) == 0)
 				return 0;
-		} else if (nls_strnicmp(t, name->name, str, alen) == 0)
-			return 0;
+		} else {
+			if (nls_strnicmp(t, name->name, str, alen) == 0)
+				return 0;
+		}
 	}
 	return 1;
 }
@@ -999,7 +1001,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 								   &new_clu);
 			if (num_alloced == 0)
 				break;
-			else if (num_alloced < 0) {
+			if (num_alloced < 0) {
 				ret = FFS_MEDIAERR;
 				goto out;
 			}
@@ -1248,9 +1250,9 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		p_fs->fs_func->set_entry_clu0(ep2, CLUSTER_32(0));
 	}
 
-	if (p_fs->vol_type != EXFAT)
+	if (p_fs->vol_type != EXFAT) {
 		buf_modify(sb, sector);
-	else {
+	} else {
 		update_dir_checksum_with_entry_set(sb, es);
 		release_entry_set(es);
 	}
@@ -1561,9 +1563,9 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	fid->attr = attr;
 	p_fs->fs_func->set_entry_attr(ep, attr);
 
-	if (p_fs->vol_type != EXFAT)
+	if (p_fs->vol_type != EXFAT) {
 		buf_modify(sb, sector);
-	else {
+	} else {
 		update_dir_checksum_with_entry_set(sb, es);
 		release_entry_set(es);
 	}
-- 
2.20.1

