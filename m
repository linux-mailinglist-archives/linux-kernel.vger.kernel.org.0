Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391D3F683D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfKJJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 04:46:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbfKJJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 04:46:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D834BE5C0CCD03CF479;
        Sun, 10 Nov 2019 17:46:09 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Sun, 10 Nov 2019 17:46:01 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] arch/x86/amd: Remove set but not used variable 'active'
Date:   Sun, 10 Nov 2019 17:44:53 +0800
Message-ID: <20191110094453.113001-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/x86/events/amd/core.c: In function amd_pmu_handle_irq:
arch/x86/events/amd/core.c:656:6: warning: variable active set but not used [-Wunused-but-set-variable]

active is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/x86/events/amd/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 64c3e70b0556..1ff652a167db 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -653,14 +653,7 @@ static void amd_pmu_disable_event(struct perf_event *event)
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int active, handled;
-
-	/*
-	 * Obtain the active count before calling x86_pmu_handle_irq() since
-	 * it is possible that x86_pmu_handle_irq() may make a counter
-	 * inactive (through x86_pmu_stop).
-	 */
-	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+	int handled;
 
 	/* Process any counter overflows */
 	handled = x86_pmu_handle_irq(regs);
-- 
2.23.0

