Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2ADEAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJULbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 07:31:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbfJULbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:31:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC82232381C44C0CE0B9;
        Mon, 21 Oct 2019 19:31:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 19:31:32 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <kstewart@linuxfoundation.org>, <", sudeep.holla"@arm.com>,
        <gregkh@linuxfoundation.org>, <yeyunfeng@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <tglx@linutronix.de>,
        <David.Laight@ACULAB.COM>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <wuyun.wu@huawei.com>,
        <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v6] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
Message-ID: <0842431c-fa15-2ba1-ae6d-c1fea157941f@huawei.com>
Date:   Mon, 21 Oct 2019 19:31:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases like suspend-to-disk and suspend-to-ram, a large number of CPU
cores need to be shut down. At present, the CPU hotplug operation is
serialised, and the CPU cores can only be shut down one by one. In this
process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
need to be shut down, it will take a long time.

Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
change the wait interval from 10 ms to max 1 ms and use usleep_range()
instead of msleep() for more accurate timer.

In addition, reducing the time interval will increase the messages
output, so remove the "Retry ..." message, instead, track time and
output to the the sucessful message.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
v5 -> v6:
 - add "Reviewed-by:"

v4 -> v5:
 - track time instead of loop counter

v3 -> v4:
 - using time_before(jiffies, timeout) to check
 - update the comment as review suggest

v2 -> v3:
 - update the comment
 - remove the busy-wait logic, modify the loop logic and output message

v1 -> v2:
 - use usleep_range() instead of udelay() after waiting for a while

 arch/arm64/kernel/psci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index c9f72b2665f1..43ae4e0c968f 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -81,7 +81,8 @@ static void cpu_psci_cpu_die(unsigned int cpu)

 static int cpu_psci_cpu_kill(unsigned int cpu)
 {
-	int err, i;
+	int err;
+	unsigned long start, end;

 	if (!psci_ops.affinity_info)
 		return 0;
@@ -91,16 +92,18 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	 * while it is dying. So, try again a few times.
 	 */

-	for (i = 0; i < 10; i++) {
+	start = jiffies;
+	end = start + msecs_to_jiffies(100);
+	do {
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
-			pr_info("CPU%d killed.\n", cpu);
+			pr_info("CPU%d killed (polled %d ms)\n", cpu,
+				jiffies_to_msecs(jiffies - start));
 			return 0;
 		}

-		msleep(10);
-		pr_info("Retrying again to check for CPU kill\n");
-	}
+		usleep_range(100, 1000);
+	} while (time_before(jiffies, end));

 	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
 			cpu, err);
-- 
2.7.4.3

