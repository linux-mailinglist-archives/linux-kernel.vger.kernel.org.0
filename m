Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D377BF9BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 22:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKLVNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:43 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37604 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727482AbfKLVNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:41 -0500
Received: from mr2.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDd9N029658
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:39 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLDYSe026533
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:39 -0500
Received: by mail-qk1-f197.google.com with SMTP id s144so24036qke.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4SKBtoSlW1zU7PxDPXG8hf+Ro2xTNT/ccRyTR/Wyas0=;
        b=sVIHVOonmZEiJ5pcJxFnKZqUVl4f5W410md4ge7G2EYkoJZva5B1lh9aX8nEh+1gOm
         AhzqsT+mb5oMQHh905nMMgTUpQJGzZFnHo4UdIC8WgKNwzjWpsmSHHNhVpmHtE+DrdGY
         toW5K6paFNwJu02HSTGxm5nwcvuXMlme3skNvA2jWdESOZAUEb/qhUMdA/8YnMlCmC6e
         Uka9494VTZ1b0Yw1bku1HEP8w5X8fK5qp1nf8gm0uZj2VMLbKCdR+JEQvfGdfqewPygv
         2rgV5E7euO4YyfoFuT3bZ57cOR+V1XxStzpABhtYXktMLMx49WVq19d8H1mcT+MJq4BV
         MO6w==
X-Gm-Message-State: APjAAAXp1YJx4mjKucqZJn47+EhJvaLz9kd5KOC9pyA5110+VMmjJGK0
        mT0QOwoVPbnsRvxAMf9HZLnN4fRnLaSTZosilD4Lc0Mo8CYuIAJgxWjiSVU8o8gywOAksIQLrAe
        88lPtTlcE04P+4tnFNJeSlEuKWRt1/XITpb0=
X-Received: by 2002:ac8:3386:: with SMTP id c6mr34262124qtb.115.1573593214075;
        Tue, 12 Nov 2019 13:13:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqz609Fw43km0k9/m3er9ECFRJsXbTuD4MD/bmDlbA0Xb+ziuL/z8YMxyocNj+LogijwBmhNbg==
X-Received: by 2002:ac8:3386:: with SMTP id c6mr34262071qtb.115.1573593213497;
        Tue, 12 Nov 2019 13:13:33 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:32 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] staging: exfat: Clean up the namespace pollution part 1
Date:   Tue, 12 Nov 2019 16:12:31 -0500
Message-Id: <20191112211238.156490-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything referenced in the struct fs_func exfat_fs_func is located
in that same .c file.  Make them static and remove from exfat.h

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      | 32 -----------------------
 drivers/staging/exfat/exfat_core.c | 42 +++++++++++++++---------------
 2 files changed, 21 insertions(+), 53 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 470e409ef536..5efba3d4259b 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -759,13 +759,8 @@ void fs_error(struct super_block *sb);
 
 /* cluster management functions */
 s32 clear_cluster(struct super_block *sb, u32 clu);
-s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
-			struct chain_t *p_chain);
-void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
-			s32 do_relse);
 u32 find_last_cluster(struct super_block *sb, struct chain_t *p_chain);
 s32 count_num_clusters(struct super_block *sb, struct chain_t *dir);
-s32 exfat_count_used_clusters(struct super_block *sb);
 void exfat_chain_cont_cluster(struct super_block *sb, u32 chain, s32 len);
 
 /* allocation bitmap management functions */
@@ -781,29 +776,11 @@ s32 load_upcase_table(struct super_block *sb);
 void free_upcase_table(struct super_block *sb);
 
 /* dir entry management functions */
-u32 exfat_get_entry_type(struct dentry_t *p_entry);
-void exfat_set_entry_type(struct dentry_t *p_entry, u32 type);
-u32 exfat_get_entry_attr(struct dentry_t *p_entry);
-void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr);
-u8 exfat_get_entry_flag(struct dentry_t *p_entry);
-void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flag);
-u32 exfat_get_entry_clu0(struct dentry_t *p_entry);
-void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu);
-u64 exfat_get_entry_size(struct dentry_t *p_entry);
-void exfat_set_entry_size(struct dentry_t *p_entry, u64 size);
 struct timestamp_t *tm_current(struct timestamp_t *tm);
-void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode);
-void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
-			  u8 mode);
-s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 s32 entry, u32 type, u32 start_clu, u64 size);
 void init_file_entry(struct file_dentry_t *ep, u32 type);
 void init_strm_entry(struct strm_dentry_t *ep, u8 flags, u32 start_clu,
 		     u64 size);
 void init_name_entry(struct name_dentry_t *ep, u16 *uniname);
-void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, s32 order, s32 num_entries);
 
 s32 find_location(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 		  sector_t *sector, s32 *offset);
@@ -822,11 +799,6 @@ s32 search_deleted_or_unused_entry(struct super_block *sb,
 				   struct chain_t *p_dir, s32 num_entries);
 s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir,
 		     s32 num_entries);
-s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
-			 struct uni_name_t *p_uniname, s32 num_entries,
-			 struct dos_name_t *p_dosname, u32 type);
-s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
-			    s32 entry, struct dentry_t *p_entry);
 s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 			   u32 type);
 void update_dir_checksum(struct super_block *sb, struct chain_t *p_dir,
@@ -839,12 +811,8 @@ bool is_dir_empty(struct super_block *sb, struct chain_t *p_dir);
 s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 				 struct uni_name_t *p_uniname, s32 *entries,
 				 struct dos_name_t *p_dosname);
-void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
-				       struct chain_t *p_dir, s32 entry,
-				       u16 *uniname);
 s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep,
 				     u16 *uniname, s32 order);
-s32 exfat_calc_num_entries(struct uni_name_t *p_uniname);
 u16 calc_checksum_2byte(void *data, s32 len, u16 chksum, s32 type);
 
 /* name resolution functions */
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index c3454e883e3c..2dc07e81bad0 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -156,7 +156,7 @@ s32 clear_cluster(struct super_block *sb, u32 clu)
 	return ret;
 }
 
-s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
+static s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 			struct chain_t *p_chain)
 {
 	s32 num_clusters = 0;
@@ -235,7 +235,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	return num_clusters;
 }
 
-void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
+static void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 			s32 do_relse)
 {
 	s32 num_clusters = 0;
@@ -341,7 +341,7 @@ s32 count_num_clusters(struct super_block *sb, struct chain_t *p_chain)
 	return count;
 }
 
-s32 exfat_count_used_clusters(struct super_block *sb)
+static s32 exfat_count_used_clusters(struct super_block *sb)
 {
 	int i, map_i, map_b, count = 0;
 	u8 k;
@@ -785,7 +785,7 @@ void free_upcase_table(struct super_block *sb)
  *  Directory Entry Management Functions
  */
 
-u32 exfat_get_entry_type(struct dentry_t *p_entry)
+static u32 exfat_get_entry_type(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -830,7 +830,7 @@ u32 exfat_get_entry_type(struct dentry_t *p_entry)
 	return TYPE_BENIGN_SEC;
 }
 
-void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
+static void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
@@ -860,56 +860,56 @@ void exfat_set_entry_type(struct dentry_t *p_entry, u32 type)
 	}
 }
 
-u32 exfat_get_entry_attr(struct dentry_t *p_entry)
+static u32 exfat_get_entry_attr(struct dentry_t *p_entry)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	return (u32)GET16_A(ep->attr);
 }
 
-void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
+static void exfat_set_entry_attr(struct dentry_t *p_entry, u32 attr)
 {
 	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
 
 	SET16_A(ep->attr, (u16)attr);
 }
 
-u8 exfat_get_entry_flag(struct dentry_t *p_entry)
+static u8 exfat_get_entry_flag(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return ep->flags;
 }
 
-void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
+static void exfat_set_entry_flag(struct dentry_t *p_entry, u8 flags)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	ep->flags = flags;
 }
 
-u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
+static u32 exfat_get_entry_clu0(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET32_A(ep->start_clu);
 }
 
-void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
+static void exfat_set_entry_clu0(struct dentry_t *p_entry, u32 start_clu)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	SET32_A(ep->start_clu, start_clu);
 }
 
-u64 exfat_get_entry_size(struct dentry_t *p_entry)
+static u64 exfat_get_entry_size(struct dentry_t *p_entry)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
 	return GET64_A(ep->valid_size);
 }
 
-void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
+static void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 {
 	struct strm_dentry_t *ep = (struct strm_dentry_t *)p_entry;
 
@@ -917,7 +917,7 @@ void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
 	SET64_A(ep->size, size);
 }
 
-void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
 	u16 t = 0x00, d = 0x21;
@@ -946,7 +946,7 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	tp->year = (d >> 9);
 }
 
-void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
+static void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 			  u8 mode)
 {
 	u16 t, d;
@@ -971,7 +971,7 @@ void exfat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
 	}
 }
 
-s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 s32 entry, u32 type, u32 start_clu, u64 size)
 {
 	sector_t sector;
@@ -1086,7 +1086,7 @@ void init_name_entry(struct name_dentry_t *ep, u16 *uniname)
 	}
 }
 
-void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static void exfat_delete_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, s32 order, s32 num_entries)
 {
 	int i;
@@ -1670,7 +1670,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
  * -1 : (root dir, ".") it is the root dir itself
  * -2 : entry with the name does not exist
  */
-s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 			 struct uni_name_t *p_uniname, s32 num_entries,
 			 struct dos_name_t *p_dosname, u32 type)
 {
@@ -1813,7 +1813,7 @@ s32 exfat_find_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return -2;
 }
 
-s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
+static s32 exfat_count_ext_entries(struct super_block *sb, struct chain_t *p_dir,
 			    s32 entry, struct dentry_t *p_entry)
 {
 	int i, count = 0;
@@ -1976,7 +1976,7 @@ s32 get_num_entries_and_dos_name(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
+static void exfat_get_uni_name_from_ext_entry(struct super_block *sb,
 				       struct chain_t *p_dir, s32 entry,
 				       u16 *uniname)
 {
@@ -2030,7 +2030,7 @@ s32 extract_uni_name_from_name_entry(struct name_dentry_t *ep, u16 *uniname,
 	return len;
 }
 
-s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
+static s32 exfat_calc_num_entries(struct uni_name_t *p_uniname)
 {
 	s32 len;
 
-- 
2.24.0

