Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32D14DB44
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgA3NJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 08:09:03 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8274 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbgA3NJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:09:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TomMfq-_1580389734;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TomMfq-_1580389734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jan 2020 21:09:00 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] hrtimer: fix an explicit cast in __ktime_divns()
Date:   Thu, 30 Jan 2020 21:08:51 +0800
Message-Id: <20200130130851.29204-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division, while the divisor 'div' is
explicitly casted to unsigned long, thus 64-bit on 64-bit platforms.
In addition, the above lines also ensures that the divisor is less
than 2^32. Hence the proper cast type is u32.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d8b62f93fc8d..57e543860660 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -311,7 +311,7 @@ s64 __ktime_divns(const ktime_t kt, s64 div)
 		div >>= 1;
 	}
 	tmp >>= sft;
-	do_div(tmp, (unsigned long) div);
+	do_div(tmp, (u32) div);
 	return dclc < 0 ? -tmp : tmp;
 }
 EXPORT_SYMBOL_GPL(__ktime_divns);
-- 
2.23.0

