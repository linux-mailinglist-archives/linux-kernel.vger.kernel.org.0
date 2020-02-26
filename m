Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89A216F94C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBZIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:12:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbgBZIMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:12:02 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7D261C881805C3CF2165;
        Wed, 26 Feb 2020 16:11:46 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Feb
 2020 16:11:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [PATCH v2 3/3] erofs: handle corrupted images whose decompressed size less than it'd be
Date:   Wed, 26 Feb 2020 16:10:08 +0800
Message-ID: <20200226081008.86348-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226081008.86348-1-gaoxiang25@huawei.com>
References: <20200226081008.86348-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.160.196.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Lasse pointed out, "Looking at fs/erofs/decompress.c,
the return value from LZ4_decompress_safe_partial is only
checked for negative value to catch errors. ... So if
I understood it correctly, if there is bad data whose
uncompressed size is much less than it should be, it can
leave part of the output buffer untouched and expose the
previous data as the file content. "

Let's fix it now.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Fixes: 7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
[ Gao Xiang: v5.3+, I will manually backport this to stable later. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index cd978af6bdb9..5d2d81940679 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -166,14 +166,18 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		ret = LZ4_decompress_safe(src + inputmargin, out,
 					  inlen, rq->outputsize);
 
-	if (ret < 0) {
-		erofs_err(rq->sb, "failed to decompress, in[%u, %u] out[%u]",
-			  inlen, inputmargin, rq->outputsize);
+	if (ret != rq->outputsize) {
+		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+			  ret, inlen, inputmargin, rq->outputsize);
+
 		WARN_ON(1);
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, inlen, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, out, rq->outputsize, true);
+
+		if (ret >= 0)
+			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EIO;
 	}
 
-- 
2.17.1

