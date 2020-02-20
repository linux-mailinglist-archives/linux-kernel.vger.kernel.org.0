Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3576E165582
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 04:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgBTDRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 22:17:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbgBTDRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:17:01 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 254FA61EE444AE7C7B70;
        Thu, 20 Feb 2020 11:16:59 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 11:16:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <john.stultz@linaro.org>, <sboyd@kernel.org>
Subject: [PATCH] timer_list: avoid other cpu soft lockup when printing timer list
Date:   Thu, 20 Feb 2020 11:42:32 +0800
Message-ID: <1582170152-69418-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If system has many cpus (e.g. 128), it will spend a lot of time to
print message to the console when execute echo q > /proc/sysrq-trigger.

When /proc/sys/kernel/numa_balancing is enabled, if the migration threads
are woke up, the migration thread that on print mesasage cpu can't run
until the print finish, another migration thread may trigger soft lockup.

PID: 619    TASK: ffffa02fdd8bec80  CPU: 121  COMMAND: "migration/121"
  #0 [ffff00000a103b10] __crash_kexec at ffff0000081bf200
  #1 [ffff00000a103ca0] panic at ffff0000080ec93c
  #2 [ffff00000a103d80] watchdog_timer_fn at ffff0000081f8a14
  #3 [ffff00000a103e00] __run_hrtimer at ffff00000819701c
  #4 [ffff00000a103e40] __hrtimer_run_queues at ffff000008197420
  #5 [ffff00000a103ea0] hrtimer_interrupt at ffff00000819831c
  #6 [ffff00000a103f10] arch_timer_dying_cpu at ffff000008b53144
  #7 [ffff00000a103f30] handle_percpu_devid_irq at ffff000008174e34
  #8 [ffff00000a103f70] generic_handle_irq at ffff00000816c5e8
  #9 [ffff00000a103f90] __handle_domain_irq at ffff00000816d1f4
 #10 [ffff00000a103fd0] gic_handle_irq at ffff000008081860
 --- <IRQ stack> ---
 #11 [ffff00000d6e3d50] el1_irq at ffff0000080834c8
 #12 [ffff00000d6e3d60] multi_cpu_stop at ffff0000081d9964
 #13 [ffff00000d6e3db0] cpu_stopper_thread at ffff0000081d9cfc
 #14 [ffff00000d6e3e10] smpboot_thread_fn at ffff00000811e0a8
 #15 [ffff00000d6e3e70] kthread at ffff000008118988

To avoid this soft lockup, add touch_all_softlockup_watchdogs()
in sysrq_timer_list_show()

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/time/timer_list.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index acb326f..4cb0e6f 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -289,13 +289,17 @@ void sysrq_timer_list_show(void)
 
 	timer_list_header(NULL, now);
 
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		touch_all_softlockup_watchdogs();
 		print_cpu(NULL, cpu, now);
+	}
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 	timer_list_show_tickdevices_header(NULL);
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		touch_all_softlockup_watchdogs();
 		print_tickdevice(NULL, tick_get_device(cpu), cpu);
+	}
 #endif
 	return;
 }
-- 
1.8.3

