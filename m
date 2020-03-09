Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5DE17E6E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCISVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 14:21:41 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.142]:33734 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727323AbgCISVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:21:40 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7F633532C7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 13:19:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BN0QjRLHPRP4zBN0QjnpbW; Mon, 09 Mar 2020 13:19:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=63jw/prEVJock7mXqnT82GLzheK/ipgQZ6xG7DJdzt8=; b=U3mVtLLU9t4qqmh6bUX4Q6KiKe
        3GfIRllL3lkcjyiAQ+3noBaZOHMAk+aOZ+xFRJsiVRKhoICwsZq0eQ9FZ4sSdGbro6fCjwOCcpW8a
        i1TcWMcAcXTaTQo0VX6oDDlU3vIjQbiSLNn9SSdi2HGfvW51EC7H5NrGQpaT28ETmxJ/TQRl8uRU0
        9lfipkv0hyLKfdznBPfdQSPznKUz2xvZJEIVF7HYoSZCwRQxCYycI0ky/dLpGyH5lKKNedneJLG+J
        yrbPqxq9PMmufQ+iObTvRfR57cU5oZci0LfDlGZtqnQxcuOL5OTpHB9ZRKnbkFKjdVpVc01Eq88lv
        H82vd/1w==;
Received: from [201.162.240.150] (port=1609 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBN0O-004KYO-Ii; Mon, 09 Mar 2020 13:19:57 -0500
Date:   Mon, 9 Mar 2020 13:23:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] jfs: Replace zero-length array with flexible-array
 member
Message-ID: <20200309182308.GA5087@embeddedor>
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
X-Source-IP: 201.162.240.150
X-Source-L: No
X-Exim-ID: 1jBN0O-004KYO-Ii
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:1609
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 27
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
 fs/jfs/jfs_dtree.c | 2 +-
 fs/jfs/jfs_xattr.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 3acc954f7c04..837d42f61464 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2964,7 +2964,7 @@ struct jfs_dirent {
 	loff_t position;
 	int ino;
 	u16 name_len;
-	char name[0];
+	char name[];
 };
 
 /*
diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index f0558b3348da..c50167a7bc50 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -17,12 +17,12 @@ struct jfs_ea {
 	u8 flag;	/* Unused? */
 	u8 namelen;	/* Length of name */
 	__le16 valuelen;	/* Length of value */
-	char name[0];	/* Attribute name (includes null-terminator) */
+	char name[];	/* Attribute name (includes null-terminator) */
 };			/* Value immediately follows name */
 
 struct jfs_ea_list {
 	__le32 size;		/* overall size */
-	struct jfs_ea ea[0];	/* Variable length list */
+	struct jfs_ea ea[];	/* Variable length list */
 };
 
 /* Macros for defining maxiumum number of bytes supported for EAs */
-- 
2.25.0

