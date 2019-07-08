Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC01761B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 09:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfGHHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 03:49:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbfGHHtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:49:35 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DAE34D9C0EAD6C991DD0;
        Mon,  8 Jul 2019 15:49:32 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 15:49:22 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <zhangxiaoxu5@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] time: Validate the usec before covert to nsec in do_adjtimex
Date:   Mon, 8 Jul 2019 15:55:04 +0800
Message-ID: <1562572504-142115-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When covert the usec to nsec, it will multiple 1000, it maybe
overflow and lead an undefined behavior.

For example, users may input an negative tv_usec values when
call adjtimex syscall, then multiple 1000 maybe overflow it
to a positive and legal number.

So, we should validate the usec before coverted it to nsec.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 kernel/time/timekeeping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 44b726b..e5c1d00 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1272,9 +1272,6 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	struct timespec64 tmp;
 	int ret = 0;
 
-	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
@@ -2321,6 +2318,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 	if (txc->modes & ADJ_SETOFFSET) {
 		struct timespec64 delta;
+
+		if (txc->time.tv_usec < 0 || txc->time.tv_usec >= USEC_PER_SEC)
+			return -EINVAL;
 		delta.tv_sec  = txc->time.tv_sec;
 		delta.tv_nsec = txc->time.tv_usec;
 		if (!(txc->modes & ADJ_NANO))
-- 
2.7.4

