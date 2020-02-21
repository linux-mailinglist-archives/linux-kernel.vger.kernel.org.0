Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78C166EED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 06:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgBUFS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 00:18:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgBUFS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:18:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L5FKED146178;
        Fri, 21 Feb 2020 00:18:49 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubua5aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 00:18:48 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01L5FKsL014060;
        Fri, 21 Feb 2020 05:18:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 2y6897admj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 05:18:48 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L5Il0o36438322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 05:18:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98ECF112064;
        Fri, 21 Feb 2020 05:18:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59F94112063;
        Fri, 21 Feb 2020 05:18:47 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.31.110])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 05:18:47 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 0E4582E2DC4; Fri, 21 Feb 2020 10:48:44 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v2 1/5] powerpc: Move idle_loop_prolog()/epilog() functions to header file
Date:   Fri, 21 Feb 2020 10:48:30 +0530
Message-Id: <1582262314-8319-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582262314-8319-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1582262314-8319-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002210035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently prior to entering an idle state on a Linux Guest, the
pseries cpuidle driver implement an idle_loop_prolog() and
idle_loop_epilog() functions which ensure that idle_purr is correctly
computed, and the hypervisor is informed that the CPU cycles have been
donated.

These prolog and epilog functions are also required in the default
idle call, i.e pseries_lpar_idle(). Hence move these accessor
functions to a common header file and call them from
pseries_lpar_idle(). Since the existing header files such as
asm/processor.h have enough clutter, create a new header file
asm/idle.h.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/idle.h        | 27 +++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  7 +++++--
 drivers/cpuidle/cpuidle-pseries.c      | 24 +-----------------------
 3 files changed, 33 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/include/asm/idle.h

diff --git a/arch/powerpc/include/asm/idle.h b/arch/powerpc/include/asm/idle.h
new file mode 100644
index 0000000..f32a7d8
--- /dev/null
+++ b/arch/powerpc/include/asm/idle.h
@@ -0,0 +1,27 @@
+#ifndef _ASM_POWERPC_IDLE_H
+#define _ASM_POWERPC_IDLE_H
+#include <asm/runlatch.h>
+
+static inline void idle_loop_prolog(unsigned long *in_purr)
+{
+	ppc64_runlatch_off();
+	*in_purr = mfspr(SPRN_PURR);
+	/*
+	 * Indicate to the HV that we are idle. Now would be
+	 * a good time to find other work to dispatch.
+	 */
+	get_lppaca()->idle = 1;
+}
+
+static inline void idle_loop_epilog(unsigned long in_purr)
+{
+	u64 wait_cycles;
+
+	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
+	wait_cycles += mfspr(SPRN_PURR) - in_purr;
+	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
+	get_lppaca()->idle = 0;
+
+	ppc64_runlatch_on();
+}
+#endif
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0c8421d..ffd4d59 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -68,6 +68,7 @@
 #include <asm/isa-bridge.h>
 #include <asm/security_features.h>
 #include <asm/asm-const.h>
+#include <asm/idle.h>
 #include <asm/swiotlb.h>
 #include <asm/svm.h>
 
@@ -319,6 +320,8 @@ static int alloc_dispatch_log_kmem_cache(void)
 
 static void pseries_lpar_idle(void)
 {
+	unsigned long in_purr;
+
 	/*
 	 * Default handler to go into low thread priority and possibly
 	 * low power mode by ceding processor to hypervisor
@@ -328,7 +331,7 @@ static void pseries_lpar_idle(void)
 		return;
 
 	/* Indicate to hypervisor that we are idle. */
-	get_lppaca()->idle = 1;
+	idle_loop_prolog(&in_purr);
 
 	/*
 	 * Yield the processor to the hypervisor.  We return if
@@ -339,7 +342,7 @@ static void pseries_lpar_idle(void)
 	 */
 	cede_processor();
 
-	get_lppaca()->idle = 0;
+	idle_loop_epilog(in_purr);
 }
 
 /*
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 74c2479..fc9dee9c 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -19,6 +19,7 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 #include <asm/runlatch.h>
+#include <asm/idle.h>
 #include <asm/plpar_wrappers.h>
 
 struct cpuidle_driver pseries_idle_driver = {
@@ -31,29 +32,6 @@ struct cpuidle_driver pseries_idle_driver = {
 static u64 snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
-static inline void idle_loop_prolog(unsigned long *in_purr)
-{
-	ppc64_runlatch_off();
-	*in_purr = mfspr(SPRN_PURR);
-	/*
-	 * Indicate to the HV that we are idle. Now would be
-	 * a good time to find other work to dispatch.
-	 */
-	get_lppaca()->idle = 1;
-}
-
-static inline void idle_loop_epilog(unsigned long in_purr)
-{
-	u64 wait_cycles;
-
-	wait_cycles = be64_to_cpu(get_lppaca()->wait_state_cycles);
-	wait_cycles += mfspr(SPRN_PURR) - in_purr;
-	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
-	get_lppaca()->idle = 0;
-
-	ppc64_runlatch_on();
-}
-
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
-- 
1.9.4

