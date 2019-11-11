Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DACCF70BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKKJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:31:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfKKJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:31:00 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F824C5D51E46681689C;
        Mon, 11 Nov 2019 17:30:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 17:30:51 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] nds32: Use static const, not const static
Date:   Mon, 11 Nov 2019 17:38:16 +0800
Message-ID: <1573465096-39896-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declarations.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 arch/nds32/kernel/perf_event_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index 334c2a6..0ce6f9f 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1119,7 +1119,7 @@ static void cpu_pmu_init(struct nds32_pmu *cpu_pmu)
 		on_each_cpu(cpu_pmu->reset, cpu_pmu, 1);
 }

-const static struct of_device_id cpu_pmu_of_device_ids[] = {
+static const struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "andestech,nds32v3-pmu",
 	 .data = device_pmu_init},
 	{},
--
2.7.4

