Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0378F181520
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgCKJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 05:38:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728245AbgCKJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:38:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B9Vp4c083651;
        Wed, 11 Mar 2020 05:37:56 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypq0s4j3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 05:37:56 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02B9Z8lR026655;
        Wed, 11 Mar 2020 09:37:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 2ypjxrvqhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 09:37:56 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02B9btGM49873402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 09:37:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61DA1AC05B;
        Wed, 11 Mar 2020 09:37:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA001AC059;
        Wed, 11 Mar 2020 09:37:54 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.122.202])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Mar 2020 09:37:54 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 3D53E2E33D3; Wed, 11 Mar 2020 15:07:47 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v3 3/6] powerpc/pseries: Account for SPURR ticks on idle CPUs
Date:   Wed, 11 Mar 2020 15:07:38 +0530
Message-Id: <1583919461-27405-4-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583919461-27405-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1583919461-27405-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_02:2020-03-10,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On Pseries LPARs, to calculate utilization, we need to know the
[S]PURR ticks when the CPUs were busy or idle.

Via pseries_idle_prolog(), pseries_idle_epilog(), we track the idle
PURR ticks in the VPA variable "wait_state_cycles". This patch extends
the support to account for the idle SPURR ticks. It also provides an
accessor function to accurately reads idle SPURR ticks.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/idle.h        | 33 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/idle.h b/arch/powerpc/include/asm/idle.h
index 7552823..a375589 100644
--- a/arch/powerpc/include/asm/idle.h
+++ b/arch/powerpc/include/asm/idle.h
@@ -3,13 +3,20 @@
 #define _ASM_POWERPC_IDLE_H
 #include <asm/runlatch.h>
 
+DECLARE_PER_CPU(u64, idle_spurr_cycles);
 DECLARE_PER_CPU(u64, idle_entry_purr_snap);
+DECLARE_PER_CPU(u64, idle_entry_spurr_snap);
 
 static inline void snapshot_purr_idle_entry(void)
 {
 	*this_cpu_ptr(&idle_entry_purr_snap) = mfspr(SPRN_PURR);
 }
 
+static inline void snapshot_spurr_idle_entry(void)
+{
+	*this_cpu_ptr(&idle_entry_spurr_snap) = mfspr(SPRN_SPURR);
+}
+
 static inline void update_idle_purr_accounting(void)
 {
 	u64 wait_cycles;
@@ -20,10 +27,19 @@ static inline void update_idle_purr_accounting(void)
 	get_lppaca()->wait_state_cycles = cpu_to_be64(wait_cycles);
 }
 
+static inline void update_idle_spurr_accounting(void)
+{
+	u64 *idle_spurr_cycles_ptr = this_cpu_ptr(&idle_spurr_cycles);
+	u64 in_spurr = *this_cpu_ptr(&idle_entry_spurr_snap);
+
+	*idle_spurr_cycles_ptr += mfspr(SPRN_SPURR) - in_spurr;
+}
+
 static inline void pseries_idle_prolog(void)
 {
 	ppc64_runlatch_off();
 	snapshot_purr_idle_entry();
+	snapshot_spurr_idle_entry();
 	/*
 	 * Indicate to the HV that we are idle. Now would be
 	 * a good time to find other work to dispatch.
@@ -34,6 +50,7 @@ static inline void pseries_idle_prolog(void)
 static inline void pseries_idle_epilog(void)
 {
 	update_idle_purr_accounting();
+	update_idle_spurr_accounting();
 	get_lppaca()->idle = 0;
 	ppc64_runlatch_on();
 }
@@ -53,4 +70,20 @@ static inline u64 read_this_idle_purr(void)
 
 	return be64_to_cpu(get_lppaca()->wait_state_cycles);
 }
+
+static inline u64 read_this_idle_spurr(void)
+{
+	/*
+	 * If we are reading from an idle context, update the
+	 * idle-spurr cycles corresponding to the last idle period.
+	 * Since the idle context is not yet over, take a fresh
+	 * snapshot of the idle-spurr.
+	 */
+	if (get_lppaca()->idle == 1) {
+		update_idle_spurr_accounting();
+		snapshot_spurr_idle_entry();
+	}
+
+	return *this_cpu_ptr(&idle_spurr_cycles);
+}
 #endif
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 4905c96..1b55e80 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -318,7 +318,9 @@ static int alloc_dispatch_log_kmem_cache(void)
 }
 machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
 
+DEFINE_PER_CPU(u64, idle_spurr_cycles);
 DEFINE_PER_CPU(u64, idle_entry_purr_snap);
+DEFINE_PER_CPU(u64, idle_entry_spurr_snap);
 static void pseries_lpar_idle(void)
 {
 	/*
-- 
1.9.4

