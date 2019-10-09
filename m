Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66627D0B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfJIJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 05:27:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbfJIJ1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:27:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D8C028BB72C28AEADD15;
        Wed,  9 Oct 2019 17:27:06 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.188.167) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 17:27:04 +0800
From:   wangxu <wangxu72@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM/hw_breakpoint: modify dead code for breakpoint_handler()
Date:   Wed, 9 Oct 2019 17:27:00 +0800
Message-ID: <1570613220-59533-1-git-send-email-wangxu72@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.188.167]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xu <wangxu72@huawei.com>

In perf_event_alloc(), event->overflow_handler is initialized to a
non-null value, which makes enable_single_step(bp, addr) in
breakpoint_handler() never be executed.

As a matter of fact, the branch condition has been updated to
is_default_overflow_handler().

Signed-off-by: Wang Xu <wangxu72@huawei.com>
---
 arch/arm/kernel/hw_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b0c195e..586a587 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -822,7 +822,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 			info->trigger = addr;
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
-			if (!bp->overflow_handler)
+			if (is_default_overflow_handler(bp))
 				enable_single_step(bp, addr);
 			goto unlock;
 		}
-- 
1.8.5.6

