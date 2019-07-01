Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC412E737
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfE2VPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 17:15:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29079 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2VPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559164519; x=1590700519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqjDPtV6Zf3pMnR6DN493sv4YyMwoLXfQFAmSMsNMjE=;
  b=TcEb5eYIvzMmbKWWwosFQiOigIfNIGzMUUUbbuDHiqCpTgZXYVVizUpe
   mifK7//5DMQ5n/7ehWg5VPUdkTcRsssP1Gol3/wnsAFL186d547REBriK
   bqc3LoCBLgsW+zrKG+Uw7Z54kT0CDLpJ07Xi+NXVMNuNhNz0I35wCdSwv
   O7oKiiW6d5bF8p/sysX8ujftNdOkETjFl7C7VYHj+M0jWes+f2rGFGyM6
   /YrZ5ZKNuX0Q74X/5Ukn0vi6+qHv1uSSqTVrbRAKjtrnuzjK6wk8DKkWq
   as0BNSpJVtO4q4qHNCWSmVmAk9xXXY6QWUkSLQlr0Wc1P6avXsW2IIAG8
   A==;
X-IronPort-AV: E=Sophos;i="5.60,527,1549900800"; 
   d="scan'208";a="114298983"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2019 05:15:18 +0800
IronPort-SDR: wNdYs48zK/tkKQQ2DT6p1ooEkczEBz/QY2juL/H2V4vKo8bbKyveOPvdlLvyUDjLBQ4Luae4Na
 gXP93WP+LIP+KyFUBUkhajzCIYjBhzyyFiwPbcn40b0FQfEL5EfKbAoyytdsqa1VSMT9tF3oyh
 SHqxtvR5n8I5rdNl8ZA7ub4IiWWge42z6dvZ+d4Zb2RmkhugdO/plirDoCTOIi7EWQHjVIKsEA
 D0hzEW64qDP40aZrFmUOB/ZrsEAjThiXTCYRvQXUc+kA2vyOfOouJy6uESNs9ll0Hp8UUe4kcR
 e3/VtzZF5jJNGfLLH9X926wW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 May 2019 13:52:49 -0700
IronPort-SDR: xjIBzpXZIzA4TBDXmsECmaGzzAJZKBqIH7TEFiIItUELTO2K9dPvB1tZxIlhIL2QxQdjpGbqEF
 U+nltZ5mR+F3yYxY7pkoOydWBwQLnpCVvegYQUF4WhNgqy2ghj74S90bYxvign1CydIeQ3A1os
 ToS2pkvnAQxHJ3PFu2Sp2jcI+J3uB1hndTepr+ibQG+bXw26tLKlqbBMwodI2k2OqEtzrcYia2
 19IiDhKvAYySWuNGhkzZXU99fJPv2KFvSG7+y/G8LCbk1P2ezUwJ54yepE0dBKpnrJG5Fc6wdx
 30U=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 May 2019 14:15:17 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/7] arm: Use common cpu_topology structure and functions.
Date:   Wed, 29 May 2019 14:13:37 -0700
Message-Id: <20190529211340.17087-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529211340.17087-1-atish.patra@wdc.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ARM32 and ARM64 uses different data structures to represent
their cpu topologies. Since, we are moving the ARM64 topology to common
code to be used by other architectures, we can reuse that for ARM32 as
well.

Take this opprtunity to remove the redundant functions from ARM32 and
reuse the common code instead.

To: Russell King <linux@armlinux.org.uk>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com> (on TC2)
Reviewed-by : Sudeep Holla <sudeep.holla@arm.com>

---
Hi Russell,
Can we get a ACK for this patch ? We are hoping that the entire
series can be merged at one go.
---
 arch/arm/include/asm/topology.h | 20 -----------
 arch/arm/kernel/topology.c      | 60 ++++-----------------------------
 drivers/base/arch_topology.c    |  4 ++-
 include/linux/arch_topology.h   |  6 ++--
 4 files changed, 11 insertions(+), 79 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 2a786f54d8b8..8a0fae94d45e 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -5,26 +5,6 @@
 #ifdef CONFIG_ARM_CPU_TOPOLOGY
 
 #include <linux/cpumask.h>
-
-struct cputopo_arm {
-	int thread_id;
-	int core_id;
-	int socket_id;
-	cpumask_t thread_sibling;
-	cpumask_t core_sibling;
-};
-
-extern struct cputopo_arm cpu_topology[NR_CPUS];
-
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
-#define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
-#define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
-#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
-
-void init_cpu_topology(void);
-void store_cpu_topology(unsigned int cpuid);
-const struct cpumask *cpu_coregroup_mask(int cpu);
-
 #include <linux/arch_topology.h>
 
 /* Replace task scheduler's default frequency-invariant accounting */
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 60e375ce1ab2..238f1da0219c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -177,17 +177,6 @@ static inline void parse_dt_topology(void) {}
 static inline void update_cpu_capacity(unsigned int cpuid) {}
 #endif
 
- /*
- * cpu topology table
- */
-struct cputopo_arm cpu_topology[NR_CPUS];
-EXPORT_SYMBOL_GPL(cpu_topology);
-
-const struct cpumask *cpu_coregroup_mask(int cpu)
-{
-	return &cpu_topology[cpu].core_sibling;
-}
-
 /*
  * The current assumption is that we can power gate each core independently.
  * This will be superseded by DT binding once available.
@@ -197,32 +186,6 @@ const struct cpumask *cpu_corepower_mask(int cpu)
 	return &cpu_topology[cpu].thread_sibling;
 }
 
-static void update_siblings_masks(unsigned int cpuid)
-{
-	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
-	int cpu;
-
-	/* update core and thread sibling masks */
-	for_each_possible_cpu(cpu) {
-		cpu_topo = &cpu_topology[cpu];
-
-		if (cpuid_topo->socket_id != cpu_topo->socket_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
-
-		if (cpuid_topo->core_id != cpu_topo->core_id)
-			continue;
-
-		cpumask_set_cpu(cpuid, &cpu_topo->thread_sibling);
-		if (cpu != cpuid)
-			cpumask_set_cpu(cpu, &cpuid_topo->thread_sibling);
-	}
-	smp_wmb();
-}
-
 /*
  * store_cpu_topology is called at boot when only one cpu is running
  * and with the mutex cpu_hotplug.lock locked, when several cpus have booted,
@@ -230,7 +193,7 @@ static void update_siblings_masks(unsigned int cpuid)
  */
 void store_cpu_topology(unsigned int cpuid)
 {
-	struct cputopo_arm *cpuid_topo = &cpu_topology[cpuid];
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
 	unsigned int mpidr;
 
 	/* If the cpu topology has been already set, just return */
@@ -250,12 +213,12 @@ void store_cpu_topology(unsigned int cpuid)
 			/* core performance interdependency */
 			cpuid_topo->thread_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 		} else {
 			/* largely independent cores */
 			cpuid_topo->thread_id = -1;
 			cpuid_topo->core_id = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-			cpuid_topo->socket_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+			cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 		}
 	} else {
 		/*
@@ -265,7 +228,7 @@ void store_cpu_topology(unsigned int cpuid)
 		 */
 		cpuid_topo->thread_id = -1;
 		cpuid_topo->core_id = 0;
-		cpuid_topo->socket_id = -1;
+		cpuid_topo->package_id = -1;
 	}
 
 	update_siblings_masks(cpuid);
@@ -275,7 +238,7 @@ void store_cpu_topology(unsigned int cpuid)
 	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
 		cpu_topology[cpuid].core_id,
-		cpu_topology[cpuid].socket_id, mpidr);
+		cpu_topology[cpuid].package_id, mpidr);
 }
 
 static inline int cpu_corepower_flags(void)
@@ -298,18 +261,7 @@ static struct sched_domain_topology_level arm_topology[] = {
  */
 void __init init_cpu_topology(void)
 {
-	unsigned int cpu;
-
-	/* init core mask and capacity */
-	for_each_possible_cpu(cpu) {
-		struct cputopo_arm *cpu_topo = &(cpu_topology[cpu]);
-
-		cpu_topo->thread_id = -1;
-		cpu_topo->core_id =  -1;
-		cpu_topo->socket_id = -1;
-		cpumask_clear(&cpu_topo->core_sibling);
-		cpumask_clear(&cpu_topo->thread_sibling);
-	}
+	reset_cpu_topology();
 	smp_wmb();
 
 	parse_dt_topology();
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5781bb4c457c..797e3cd71bea 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -426,6 +426,7 @@ static int __init parse_dt_topology(void)
 	of_node_put(cn);
 	return ret;
 }
+#endif
 
 /*
  * cpu topology table
@@ -491,7 +492,7 @@ static void clear_cpu_topology(int cpu)
 	cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
 }
 
-static void __init reset_cpu_topology(void)
+void __init reset_cpu_topology(void)
 {
 	unsigned int cpu;
 
@@ -526,6 +527,7 @@ __weak int __init parse_acpi_topology(void)
 	return 0;
 }
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d4e76e0a283f..d4311127970d 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -54,11 +54,9 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
-#endif
-
-#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void update_siblings_masks(unsigned int cpu);
-#endif
 void remove_cpu_topology(unsigned int cpuid);
+void reset_cpu_topology(void);
+#endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.21.0

