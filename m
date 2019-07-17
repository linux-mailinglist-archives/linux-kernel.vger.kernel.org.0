Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0286BDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGQOK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 10:10:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbfGQOK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:10:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1954BA62BC597510B337;
        Wed, 17 Jul 2019 22:10:22 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 22:10:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <keescook@chromium.org>, <gustavo@embeddedor.com>,
        <terrelln@fb.com>, <clm@fb.com>, <yamada.masahiro@socionext.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] lib: zstd: Make ZSTD_compressBlock_greedy_extDict static
Date:   Wed, 17 Jul 2019 17:18:52 +0800
Message-ID: <20190717091852.50808-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

lib/zstd/compress.c:2252:6: warning:
 symbol 'ZSTD_compressBlock_greedy_extDict' was not declared. Should it be static?
lib/zstd/compress.c:2982:14: warning:
 symbol 'ZSTD_createCStream_advanced' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/zstd/compress.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index 5e0b67003e55..651d686c00b6 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -2249,7 +2249,11 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
 	}
 }
 
-void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize) { ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0); }
+static void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src,
+					      size_t srcSize)
+{
+	ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0);
+}
 
 static void ZSTD_compressBlock_lazy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
 {
@@ -2979,7 +2983,7 @@ size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters cParams)
 	return ZSTD_CCtxWorkspaceBound(cParams) + ZSTD_ALIGN(sizeof(ZSTD_CStream)) + ZSTD_ALIGN(inBuffSize) + ZSTD_ALIGN(outBuffSize);
 }
 
-ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
+static ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
 {
 	ZSTD_CStream *zcs;
 
-- 
2.20.1


