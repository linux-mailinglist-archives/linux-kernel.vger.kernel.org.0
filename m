Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9A1699AC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBWTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:30:00 -0500
Received: from foss.arm.com ([217.140.110.172]:51312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbgBWT36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:29:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B67A12FC;
        Sun, 23 Feb 2020 11:29:58 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CDB53F6CF;
        Sun, 23 Feb 2020 11:29:57 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] ia64: Replace cpu_down with smp_shutdown_nonboot_cpus()
Date:   Sun, 23 Feb 2020 19:29:30 +0000
Message-Id: <20200223192942.18420-4-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223192942.18420-1-qais.yousef@arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new smp_shutdown_nonboot_cpus() instead of open coding using
cpu_down() directly.

Use reboot_cpu instead of hardcoding the boot CPU to 0.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/ia64/kernel/process.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f33e725..bf4c0cdb7a25 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -646,14 +646,8 @@ cpu_halt (void)
 
 void machine_shutdown(void)
 {
-#ifdef CONFIG_HOTPLUG_CPU
-	int cpu;
+	smp_shutdown_nonboot_cpus(reboot_cpu);
 
-	for_each_online_cpu(cpu) {
-		if (cpu != smp_processor_id())
-			cpu_down(cpu);
-	}
-#endif
 #ifdef CONFIG_KEXEC
 	kexec_disable_iosapic();
 #endif
-- 
2.17.1

