Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6393014384F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgAUIeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:34:10 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41239 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ToHWnva_1579595645;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWnva_1579595645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:06 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Armijn Hemel <armijn@tjaldur.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/ida: remove abandoned macros
Date:   Tue, 21 Jan 2020 16:34:05 +0800
Message-Id: <1579595645-251250-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 IDA_ started macros aren't used from commit f32f004cddf8 ("ida: Convert
to XArray"). so better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Richard Fontana <rfontana@redhat.com> 
Cc: Armijn Hemel <armijn@tjaldur.nl> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/radix-tree.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index c8fa1d274530..2ee6ae3b0ade 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -56,14 +56,6 @@
 #define IDR_PRELOAD_SIZE	(IDR_MAX_PATH * 2 - 1)
 
 /*
- * The IDA is even shorter since it uses a bitmap at the last level.
- */
-#define IDA_INDEX_BITS		(8 * sizeof(int) - 1 - ilog2(IDA_BITMAP_BITS))
-#define IDA_MAX_PATH		(DIV_ROUND_UP(IDA_INDEX_BITS, \
-						RADIX_TREE_MAP_SHIFT))
-#define IDA_PRELOAD_SIZE	(IDA_MAX_PATH * 2 - 1)
-
-/*
  * Per-cpu pool of preloaded nodes
  */
 struct radix_tree_preload {
-- 
1.8.3.1

