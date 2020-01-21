Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B0143852
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAUIeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:34:15 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38077 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHWnxt_1579595652;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWnxt_1579595652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:12 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/xxhash: remove used macros
Date:   Tue, 21 Jan 2020 16:34:11 +0800
Message-Id: <1579595651-251348-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XXH_CPU_LITTLE_ENDIAN defined but never used, looks like it's needed. so
remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: linux-kernel@vger.kernel.org 
---
 lib/xxhash.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/xxhash.c b/lib/xxhash.c
index aa61e2a3802f..d1561828a0f1 100644
--- a/lib/xxhash.c
+++ b/lib/xxhash.c
@@ -52,12 +52,6 @@
 #define xxh_rotl32(x, r) ((x << r) | (x >> (32 - r)))
 #define xxh_rotl64(x, r) ((x << r) | (x >> (64 - r)))
 
-#ifdef __LITTLE_ENDIAN
-# define XXH_CPU_LITTLE_ENDIAN 1
-#else
-# define XXH_CPU_LITTLE_ENDIAN 0
-#endif
-
 /*-*************************************
  * Constants
  **************************************/
-- 
1.8.3.1

