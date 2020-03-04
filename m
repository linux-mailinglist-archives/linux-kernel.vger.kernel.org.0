Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41A317943D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgCDQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 11:01:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgCDQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:01:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024Fx563103153
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 11:01:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhhy6v1n6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:01:38 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Wed, 4 Mar 2020 16:01:35 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 16:01:31 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024G1SXh32113110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 16:01:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2085AE055;
        Wed,  4 Mar 2020 16:01:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94681AE045;
        Wed,  4 Mar 2020 16:01:26 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.81.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 16:01:26 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        vaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        skiboot@lists.ozlabs.org, oohall@gmail.com, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 1/3] Interface for an idle-stop dependency structure
Date:   Wed,  4 Mar 2020 21:31:21 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583332695.git.psampat@linux.ibm.com>
References: <cover.1583332695.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030416-4275-0000-0000-000003A85BE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030416-4276-0000-0000-000038BD6919
Message-Id: <80c7a6ae66ab25bd088beaa3bd5c69f3b1352ac2.1583332695.git.psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Design patch to introduce the idea of having a dependency structure for
idle-stop. The structure encapsulates the following:
1. Bitmask for version of idle-stop
2. Bitmask for propterties like ENABLE/DISABLE
3. Function pointer which helps handle how the stop must be invoked

The commit lays a foundation for other idle-stop versions to be added
and handled cleanly based on their specified requirments.
Currently it handles the existing "idle-stop" version by setting the
discovery bits and the function pointer.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/include/asm/processor.h  | 17 +++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c     |  5 +++++
 arch/powerpc/platforms/powernv/idle.c | 17 +++++++++++++----
 drivers/cpuidle/cpuidle-powernv.c     |  3 ++-
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eedcbfb9a6ff..da59f01a5c09 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -429,6 +429,23 @@ extern void power4_idle_nap(void);
 extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
+#define STOP_ENABLE		0x00000001
+
+#define STOP_VERSION_P9       0x1
+
+/*
+ * Classify the dependencies of the stop states
+ * @idle_stop: function handler to handle the quirk stop version
+ * @cpuidle_prop: Signify support for stop states through kernel and/or firmware
+ * @stop_version: Classify quirk versions for stop states
+ */
+typedef struct {
+	unsigned long (*idle_stop)(unsigned long, bool);
+	uint8_t cpuidle_prop;
+	uint8_t stop_version;
+}stop_deps_t;
+extern stop_deps_t stop_dep;
+
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 extern void power7_idle_type(unsigned long type);
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 182b4047c1ef..db1a525e090d 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -292,6 +292,8 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 	lpcr |=  LPCR_PECE1;
 	lpcr |=  LPCR_PECE2;
 	mtspr(SPRN_LPCR, lpcr);
+	stop_dep.cpuidle_prop |= STOP_ENABLE;
+	stop_dep.stop_version = STOP_VERSION_P9;
 
 	return 1;
 }
@@ -657,6 +659,9 @@ static void __init cpufeatures_setup_start(u32 isa)
 	}
 }
 
+stop_deps_t stop_dep = {NULL, 0x0, 0x0};
+EXPORT_SYMBOL(stop_dep);
+
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 {
 	const struct dt_cpu_feature_match *m;
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 78599bca66c2..c32cdc37acf4 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -812,7 +812,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 
 #ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 #else
 	/*
@@ -828,7 +828,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, false);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
@@ -856,7 +856,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -1353,8 +1353,17 @@ static int __init pnv_init_idle_states(void)
 	nr_pnv_idle_states = 0;
 	supported_cpuidle_states = 0;
 
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
+	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
 		goto out;
+	switch(stop_dep.stop_version) {
+	case STOP_VERSION_P9:
+		stop_dep.idle_stop = power9_idle_stop;
+		break;
+	default:
+		stop_dep.idle_stop = NULL;
+		goto out;
+	}
 	rc = pnv_parse_cpuidle_dt();
 	if (rc)
 		return rc;
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1b299e801f74..7430a8edf5c9 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -371,7 +371,8 @@ static int powernv_add_idle_states(void)
  */
 static int powernv_idle_probe(void)
 {
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
+	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_OPAL)) {
-- 
2.24.1

