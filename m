Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA816F949
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBZILt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:11:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbgBZILs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:11:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A634F2CE09A151771A07;
        Wed, 26 Feb 2020 16:11:46 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Feb
 2020 16:11:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [PATCH v2 2/3] erofs: use LZ4_decompress_safe() for full decoding
Date:   Wed, 26 Feb 2020 16:10:07 +0800
Message-ID: <20200226081008.86348-2-gaoxiang25@huawei.com>
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

As Lasse pointed out, "EROFS uses LZ4_decompress_safe_partial
for both partial and full blocks. Thus when it is decoding a
full block, it doesn't know if the LZ4 decoder actually decoded
all the input. The real uncompressed size could be bigger than
the value stored in the file system metadata.

Using LZ4_decompress_safe instead of _safe_partial when
decompressing a full block would help to detect errors."

So it's reasonable to use _safe in case of potential corrupted
images and it might have some speed gain as well although
I didn't observe much difference.

Note that legacy compressor (< 5.3, no LZ4_0PADDING) could
encode extra data in a pcluster, which is excluded as well.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
[ Gao Xiang: v5.3+, I will manually backport this to stable later. ]
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5779a15c2cd6..cd978af6bdb9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -157,9 +157,15 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		}
 	}
 
-	ret = LZ4_decompress_safe_partial(src + inputmargin, out,
-					  inlen, rq->outputsize,
-					  rq->outputsize);
+	/* legacy format could compress extra data in a pcluster. */
+	if (rq->partial_decoding || !support_0padding)
+		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
+						  inlen, rq->outputsize,
+						  rq->outputsize);
+	else
+		ret = LZ4_decompress_safe(src + inputmargin, out,
+					  inlen, rq->outputsize);
+
 	if (ret < 0) {
 		erofs_err(rq->sb, "failed to decompress, in[%u, %u] out[%u]",
 			  inlen, inputmargin, rq->outputsize);
-- 
2.17.1

