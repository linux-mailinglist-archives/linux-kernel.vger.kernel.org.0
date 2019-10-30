Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA6FE9F51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfJ3PmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 11:42:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfJ3PmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:42:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2034F5;
        Wed, 30 Oct 2019 08:42:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AF103F6C4;
        Wed, 30 Oct 2019 08:42:17 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] ia64: Replace cpu_down with freeze_secondary_cpus
Date:   Wed, 30 Oct 2019 15:38:29 +0000
Message-Id: <20191030153837.18107-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030153837.18107-1-qais.yousef@arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use freeze_secondary_cpus() instead of open coding using cpu_down()
directly.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/ia64/kernel/process.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 968b5f33e725..70b433eafa5c 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -647,12 +647,8 @@ cpu_halt (void)
 void machine_shutdown(void)
 {
 #ifdef CONFIG_HOTPLUG_CPU
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		if (cpu != smp_processor_id())
-			cpu_down(cpu);
-	}
+	/* TODO: Can we use disable_nonboot_cpus()? */
+	freeze_secondary_cpus(smp_processor_id());
 #endif
 #ifdef CONFIG_KEXEC
 	kexec_disable_iosapic();
-- 
2.17.1

