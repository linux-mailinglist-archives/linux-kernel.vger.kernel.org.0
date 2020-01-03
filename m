Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78D012FA0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 16:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgACPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 10:55:39 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55347 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbgACPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:55:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TmkQCWM_1578066930;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmkQCWM_1578066930)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 23:55:35 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: improve arithmetic divisions
Date:   Fri,  3 Jan 2020 23:55:17 +0800
Message-Id: <20200103155517.21754-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_u64()
instead of do_div() if the divisor is u64,
to avoid truncation to 32-bit.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca69290..bad76c1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1007,7 +1007,7 @@ static int scale64_check_overflow(u64 mult, u64 div, u64 *base)
 	tmp *= mult;
 	rem *= mult;
 
-	do_div(rem, div);
+	rem = div64_u64(rem, div);
 	*base = tmp + rem;
 	return 0;
 }
-- 
1.8.3.1

