Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7817C830
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 23:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFWOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 17:14:38 -0500
Received: from gateway21.websitewelcome.com ([192.185.46.113]:25304 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgCFWOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:14:38 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 71C93400C3400
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 16:14:35 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ALEpjBe3FXVkQALEpjV9x0; Fri, 06 Mar 2020 16:14:35 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nBwlfiUJo4l1eGO3/VAyVjlX3AwTc9M2cRFum/DqUP4=; b=fe6wMZH1EP5Z1nRJw+m77yeD7Y
        LHTno/j6YfqvsizLS41Ci6tS5mt7f7WZwjCHdoj10jsWv5JkH/rFiKn9/IUbAsDhJ4d89Wcmdw5ZF
        ii3lzokrhXZgXuXny9XUOcAvzgK5MxSWqpaFLrPJ1yZwItR8q651NhjY32XLDJKeK5swMZoLx+1ho
        6mFvOG70z8q3O2FUpe1KOOQaX0Simy1E4RWU7JvqgEKSXhAlVG1vcjt0A9vfctAV5Mw0qIKZclvWn
        zRQj5N1DwAnTND2B16g6sM43703jTsyo05l6qeztEPQRVgT2PIstsaExAaTQgXeSrb9tsljAcUTL5
        ZZrMEvew==;
Received: from [201.162.241.123] (port=6921 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jALEm-000Jn7-UR; Fri, 06 Mar 2020 16:14:34 -0600
Date:   Fri, 6 Mar 2020 16:17:40 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] cifs: cifspdu.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200306221740.GA31410@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.123
X-Source-L: No
X-Exim-ID: 1jALEm-000Jn7-UR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.123]:6921
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/cifs/cifspdu.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index 8e15887d1f1f..593d826820c3 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -1021,7 +1021,7 @@ typedef struct smb_com_writex_req {
 	__le16 ByteCount;
 	__u8 Pad;		/* BB check for whether padded to DWORD
 				   boundary and optimum performance here */
-	char Data[0];
+	char Data[];
 } __attribute__((packed)) WRITEX_REQ;
 
 typedef struct smb_com_write_req {
@@ -1041,7 +1041,7 @@ typedef struct smb_com_write_req {
 	__le16 ByteCount;
 	__u8 Pad;		/* BB check for whether padded to DWORD
 				   boundary and optimum performance here */
-	char Data[0];
+	char Data[];
 } __attribute__((packed)) WRITE_REQ;
 
 typedef struct smb_com_write_rsp {
@@ -1306,7 +1306,7 @@ typedef struct smb_com_ntransact_req {
 	/* SetupCount words follow then */
 	__le16 ByteCount;
 	__u8 Pad[3];
-	__u8 Parms[0];
+	__u8 Parms[];
 } __attribute__((packed)) NTRANSACT_REQ;
 
 typedef struct smb_com_ntransact_rsp {
@@ -1523,7 +1523,7 @@ struct file_notify_information {
 	__le32 NextEntryOffset;
 	__le32 Action;
 	__le32 FileNameLength;
-	__u8  FileName[0];
+	__u8  FileName[];
 } __attribute__((packed));
 
 /* For IO_REPARSE_TAG_SYMLINK */
@@ -1536,7 +1536,7 @@ struct reparse_symlink_data {
 	__le16	PrintNameOffset;
 	__le16	PrintNameLength;
 	__le32	Flags;
-	char	PathBuffer[0];
+	char	PathBuffer[];
 } __attribute__((packed));
 
 /* Flag above */
@@ -1553,7 +1553,7 @@ struct reparse_posix_data {
 	__le16	ReparseDataLength;
 	__u16	Reserved;
 	__le64	InodeType; /* LNK, FIFO, CHR etc. */
-	char	PathBuffer[0];
+	char	PathBuffer[];
 } __attribute__((packed));
 
 struct cifs_quota_data {
@@ -1762,7 +1762,7 @@ struct set_file_rename {
 	__le32 overwrite;   /* 1 = overwrite dest */
 	__u32 root_fid;   /* zero */
 	__le32 target_name_len;
-	char  target_name[0];  /* Must be unicode */
+	char  target_name[];  /* Must be unicode */
 } __attribute__((packed));
 
 struct smb_com_transaction2_sfi_req {
@@ -2451,7 +2451,7 @@ struct cifs_posix_acl { /* access conrol list  (ACL) */
 	__le16	version;
 	__le16	access_entry_count;  /* access ACL - count of entries */
 	__le16	default_entry_count; /* default ACL - count of entries */
-	struct cifs_posix_ace ace_array[0];
+	struct cifs_posix_ace ace_array[];
 	/* followed by
 	struct cifs_posix_ace default_ace_arraay[] */
 } __attribute__((packed));  /* level 0x204 */
@@ -2757,7 +2757,7 @@ typedef struct file_xattr_info {
 	/* BB do we need another field for flags? BB */
 	__u32 xattr_name_len;
 	__u32 xattr_value_len;
-	char  xattr_name[0];
+	char  xattr_name[];
 	/* followed by xattr_value[xattr_value_len], no pad */
 } __attribute__((packed)) FILE_XATTR_INFO; /* extended attribute info
 					      level 0x205 */
-- 
2.25.0

