Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31501699B4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 20:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgBWTaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 14:30:20 -0500
Received: from foss.arm.com ([217.140.110.172]:51490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgBWTaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 14:30:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B20631B;
        Sun, 23 Feb 2020 11:30:15 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B8A53F6CF;
        Sun, 23 Feb 2020 11:30:13 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] smp: Create a new function to bringup nonboot cpus online
Date:   Sun, 23 Feb 2020 19:29:41 +0000
Message-Id: <20200223192942.18420-15-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223192942.18420-1-qais.yousef@arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last direct user of cpu_up() before we can hide it now as
internal implementation detail of the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Jiri Kosina <jkosina@suse.cz>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Eiichi Tsukata <devel@etsukata.com>
CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC: Nadav Amit <namit@vmware.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: linux-kernel@vger.kernel.org
---
 include/linux/cpu.h |  1 +
 kernel/cpu.c        | 12 ++++++++++++
 kernel/smp.c        |  9 +--------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index aebe8186cb07..3d3caecef395 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -94,6 +94,7 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 extern int bringup_hibernate_cpu(unsigned int sleep_cpu);
+extern void smp_bringup_nonboot_cpus(unsigned int setup_max_cpus);
 
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/kernel/cpu.c b/kernel/cpu.c
index bf39c5bfb6d9..7c6aa427a3a3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1299,6 +1299,18 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 	return 0;
 }
 
+void smp_bringup_nonboot_cpus(unsigned int setup_max_cpus)
+{
+	unsigned int cpu;
+
+	for_each_present_cpu(cpu) {
+		if (num_online_cpus() >= setup_max_cpus)
+			break;
+		if (!cpu_online(cpu))
+			cpu_up(cpu);
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
 
diff --git a/kernel/smp.c b/kernel/smp.c
index d0ada39eb4d4..9e793cfd6128 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -589,20 +589,13 @@ void __init setup_nr_cpu_ids(void)
 void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
-	unsigned int cpu;
 
 	idle_threads_init();
 	cpuhp_threads_init();
 
 	pr_info("Bringing up secondary CPUs ...\n");
 
-	/* FIXME: This should be done in userspace --RR */
-	for_each_present_cpu(cpu) {
-		if (num_online_cpus() >= setup_max_cpus)
-			break;
-		if (!cpu_online(cpu))
-			cpu_up(cpu);
-	}
+	smp_bringup_nonboot_cpus(setup_max_cpus);
 
 	num_nodes = num_online_nodes();
 	num_cpus  = num_online_cpus();
-- 
2.17.1

