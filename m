Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510E2A3D47
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfH3Rz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 13:55:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34208 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfH3Rzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:55:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHt6tF088742;
        Fri, 30 Aug 2019 17:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=6TBcR3z4xqJM0wmVaFettciFd952rvhR5dlqXaUUv48=;
 b=fYPRu+zTGJ1MuIYtr3IP9HHd/y+sL77rcRmIEjdZYMC/ykGbXKLTiTwcfl/wOC2prheE
 B55JjDXKYRtfBKaeMmakP3xNXm1AbLmcDyxvsDx+PIZ6CJpq2O5H2KdHylfTbzHMsVom
 kiGRCBrrOGx3mAv46rTtuSP3XEgbWDmsZqRgHrEr2w9mLR4baCsSw+UK5r8a05WUXMsl
 xmPdhUriKDJ2Cg0oPbe755VURCkZSyhj39853j/AtGNSwIj2F8BCizvL5ZtgoH/wsO30
 MdZtlsSWVd/MuA9qu+N9NIRP8InO8rDcum0S1kD0sBtRh7rcwFHD8sBa5z3hjsJSJVRs Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uq8fsg22t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:55:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrdbw017994;
        Fri, 30 Aug 2019 17:54:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2upxabkvum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7UHscpH014866;
        Fri, 30 Aug 2019 17:54:38 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:38 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 9/9] sched: rotate the cpu search window for better spread
Date:   Fri, 30 Aug 2019 10:49:44 -0700
Message-Id: <20190830174944.21741-10-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=970 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rotate the cpu search window for better spread of threads. This will ensure
an idle cpu will quickly be found if one exists.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 94dd4a32..7419b47 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	u64 avg_cost, avg_idle;
 	u64 time, cost;
 	s64 delta;
-	int cpu, floor, nr = INT_MAX;
+	int cpu, floor, target_tmp, nr = INT_MAX;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6213,9 +6213,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			nr = floor;
 	}
 
+	if (per_cpu(next_cpu, target) != -1)
+		target_tmp = per_cpu(next_cpu, target);
+	else
+		target_tmp = target;
+
 	time = local_clock();
 
-	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
+	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
+		per_cpu(next_cpu, target) = cpu;
 		if (!--nr)
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-- 
2.9.3

