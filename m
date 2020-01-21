Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C614384E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAUIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:34:07 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52894 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbgAUIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ToHWnuY_1579595643;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHWnuY_1579595643)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:03 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/bitmap: remove unused macro BASEDEC
Date:   Tue, 21 Jan 2020 16:34:01 +0800
Message-Id: <1579595641-251181-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't used after commit 4b060420a596 ("bitmap, irq: add
smp_affinity_list interface to /proc/irq"). better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk> 
Cc: Yury Norov <yury.norov@gmail.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 4250519d7d1c..1b2546b81c95 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -367,7 +367,6 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
 
 #define CHUNKSZ				32
 #define nbits_to_hold_value(val)	fls(val)
-#define BASEDEC 10		/* fancier cpuset lists input in decimal */
 
 /**
  * __bitmap_parse - convert an ASCII hex string into a bitmap.
-- 
1.8.3.1

