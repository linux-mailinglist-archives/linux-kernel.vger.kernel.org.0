Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2016F5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 03:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgBZCbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 21:31:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51498 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbgBZCbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:31:46 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39D62DD8C58A4B46E2CF;
        Wed, 26 Feb 2020 10:31:45 +0800 (CST)
Received: from architecture4.huawei.com (10.160.196.180) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Feb
 2020 10:31:39 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Gao Xiang" <gaoxiang25@huawei.com>,
        Lasse Collin <lasse.collin@tukaani.org>
Subject: [PATCH 2/3] erofs: use LZ4_decompress_safe() for full decoding
Date:   Wed, 26 Feb 2020 10:30:10 +0800
Message-ID: <20200226023011.103798-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226023011.103798-1-gaoxiang25@huawei.com>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
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

So it's reasonable to use _safe in case of corrupted images and
it might have some speed gain as well although I didn't observe
much difference.

Cc: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 5779a15c2cd6..c77cec4327fa 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -157,9 +157,14 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		}
 	}
 
-	ret = LZ4_decompress_safe_partial(src + inputmargin, out,
-					  inlen, rq->outputsize,
-					  rq->outputsize);
+	if (rq->partial_decoding)
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

