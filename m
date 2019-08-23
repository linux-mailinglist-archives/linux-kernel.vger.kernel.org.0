Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0BF9A850
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392824AbfHWHLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:11:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392797AbfHWHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:11:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N777cq073483
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:11:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uj9p2kt1u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:11:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 23 Aug 2019 08:11:48 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 23 Aug 2019 08:11:44 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7N7Bi9Z38797672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 07:11:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E820252050;
        Fri, 23 Aug 2019 07:11:43 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 323E45204F;
        Fri, 23 Aug 2019 07:11:42 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, paulus@samba.org
Cc:     npiggin@gmail.com, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, mikey@neuling.org, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC 3/3] cpuidle/powernv : Add flags to identify stop state type
Date:   Fri, 23 Aug 2019 02:09:40 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823070940.43220-1-huntbag@linux.vnet.ibm.com>
References: <20190823070940.43220-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19082307-4275-0000-0000-0000035C72A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082307-4276-0000-0000-0000386E9ADB
Message-Id: <20190823070940.43220-4-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed threshold latency which was being used to decide if a state
is cpuidle type or not. This decision can be taken using flags, as this
information has been encapsulated in the state->flags and being read
from idle device-tree.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h |  7 +++++++
 drivers/cpuidle/cpuidle-powernv.c   | 16 +++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 383242eb0dea..b9068fee21d8 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -233,6 +233,13 @@
 #define OPAL_PM_STOP_INST_FAST		0x00100000
 #define OPAL_PM_STOP_INST_DEEP		0x00200000
 
+/*
+ * Flags for stop states to distinguish between cpuidle and
+ * cpuoffline type of states.
+ */
+#define OPAL_PM_STOP_CPUIDLE		0x01000000
+#define OPAL_PM_STOP_CPUHOTPLUG		0x02000000
+
 /*
  * OPAL_CONFIG_CPU_IDLE_STATE parameters
  */
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1b6c84d4ac77..1a33a548b769 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -270,8 +270,13 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
-	/* TODO: Count only states which are eligible for cpuidle */
-	dt_idle_states = nr_pnv_idle_states;
+	/* Count only cpuidle states*/
+	for (i = 0; i < nr_pnv_idle_states; i++) {
+		if (pnv_idle_states[i].flags & OPAL_PM_STOP_CPUIDLE)
+			dt_idle_states++;
+	}
+	pr_info("idle states in dt = %d , states with idle flag = %d",
+				nr_pnv_idle_states, dt_idle_states);
 
 	/*
 	 * Since snooze is used as first idle state, max idle states allowed is
@@ -300,11 +305,8 @@ static int powernv_add_idle_states(void)
 			continue;
 		}
 
-		/*
-		 * If an idle state has exit latency beyond
-		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it in cpu-idle.
-		 */
-		if (state->latency_ns > POWERNV_THRESHOLD_LATENCY_NS) {
+		/* Check whether a state is of cpuidle type */
+		if ((state->flags & OPAL_PM_STOP_CPUIDLE) != state->flags) {
 			pr_info("State %d is not idletype\n", i);
 			continue;
 		}
-- 
2.17.1

