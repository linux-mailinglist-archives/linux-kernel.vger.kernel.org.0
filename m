Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61F11437D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 08:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgAUHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 02:44:54 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60307 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgAUHoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:44:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHBzO4_1579592692;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHBzO4_1579592692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 15:44:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/zstd: remove unused macros
Date:   Tue, 21 Jan 2020 15:44:50 +0800
Message-Id: <1579592690-3047-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSE_TYPE_NAME/FSE_FUNCTION_NAME/FSE_CAT are never used from introduced
commit 73f3d1b48f506 ("lib: Add zstd modules"). Better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-kernel@vger.kernel.org 
---
 lib/zstd/fse_compress.c   | 5 -----
 lib/zstd/fse_decompress.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
index ef3d1741d532..20367cd2eaa0 100644
--- a/lib/zstd/fse_compress.c
+++ b/lib/zstd/fse_compress.c
@@ -77,11 +77,6 @@
 #error "FSE_FUNCTION_TYPE must be defined"
 #endif
 
-/* Function names */
-#define FSE_CAT(X, Y) X##Y
-#define FSE_FUNCTION_NAME(X, Y) FSE_CAT(X, Y)
-#define FSE_TYPE_NAME(X, Y) FSE_CAT(X, Y)
-
 /* Function templates */
 
 /* FSE_buildCTable_wksp() :
diff --git a/lib/zstd/fse_decompress.c b/lib/zstd/fse_decompress.c
index a84300e5a013..7fcafe5f2615 100644
--- a/lib/zstd/fse_decompress.c
+++ b/lib/zstd/fse_decompress.c
@@ -85,11 +85,6 @@
 #error "FSE_FUNCTION_TYPE must be defined"
 #endif
 
-/* Function names */
-#define FSE_CAT(X, Y) X##Y
-#define FSE_FUNCTION_NAME(X, Y) FSE_CAT(X, Y)
-#define FSE_TYPE_NAME(X, Y) FSE_CAT(X, Y)
-
 /* Function templates */
 
 size_t FSE_buildDTable_wksp(FSE_DTable *dt, const short *normalizedCounter, unsigned maxSymbolValue, unsigned tableLog, void *workspace, size_t workspaceSize)
-- 
1.8.3.1

