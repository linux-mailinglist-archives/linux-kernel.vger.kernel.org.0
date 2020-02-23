Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB51699BA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBWTaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:30:05 -0500
Received: from foss.arm.com ([217.140.110.172]:51348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgBWTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:30:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D69A30E;
        Sun, 23 Feb 2020 11:30:03 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E333F6CF;
        Sun, 23 Feb 2020 11:30:00 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Richard Fontana <rfontana@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/15] arm64: hibernate.c: Create a new function to handle cpu_up(sleep_cpu)
Date:   Sun, 23 Feb 2020 19:29:33 +0000
Message-Id: <20200223192942.18420-7-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223192942.18420-1-qais.yousef@arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to make cpu_up/down private - move the user in arm64
hibernate.c to use a new generic function that provides what arm64
needs.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: Steve Capper <steve.capper@arm.com>
CC: Richard Fontana <rfontana@redhat.com>
CC: James Morse <james.morse@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Jiri Kosina <jkosina@suse.cz>
CC: Pavankumar Kondeti <pkondeti@codeaurora.org>
CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/arm64/kernel/hibernate.c | 13 +++++--------
 include/linux/cpu.h           |  1 +
 kernel/cpu.c                  | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 590963c9c609..5b73e92c99e3 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -166,14 +166,11 @@ int arch_hibernation_header_restore(void *addr)
 		sleep_cpu = -EINVAL;
 		return -EINVAL;
 	}
-	if (!cpu_online(sleep_cpu)) {
-		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
-		ret = cpu_up(sleep_cpu);
-		if (ret) {
-			pr_err("Failed to bring hibernate-CPU up!\n");
-			sleep_cpu = -EINVAL;
-			return ret;
-		}
+
+	ret = bringup_hibernate_cpu(sleep_cpu);
+	if (ret) {
+		sleep_cpu = -EINVAL;
+		return ret;
 	}
 
 	resume_hdr = *hdr;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 64a246e9c8db..aebe8186cb07 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -93,6 +93,7 @@ int add_cpu(unsigned int cpu);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
+extern int bringup_hibernate_cpu(unsigned int sleep_cpu);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 03c727195b65..bf39c5bfb6d9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,6 +1275,30 @@ int add_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(add_cpu);
 
+/**
+ * bringup_hibernate_cpu - Bring up the CPU that we hibernated on
+ * @sleep_cpu: The cpu we hibernated on and should be brought up.
+ *
+ * On some archs like arm64, we can hibernate on any CPU, but on wake up the
+ * CPU we hibernated on might be offline as a side effect of using maxcpus= for
+ * example.
+ */
+int bringup_hibernate_cpu(unsigned int sleep_cpu)
+{
+	int ret;
+
+	if (!cpu_online(sleep_cpu)) {
+		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
+		ret = cpu_up(sleep_cpu);
+		if (ret) {
+			pr_err("Failed to bring hibernate-CPU up!\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
-- 
2.17.1

