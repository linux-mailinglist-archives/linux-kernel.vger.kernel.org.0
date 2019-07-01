Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88322FEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfE3PAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 11:00:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbfE3PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:00:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEpo2W074685
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:00:26 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stgfkavwc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:00:26 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 16:00:21 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 16:00:16 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UF0FfR23331128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:00:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D16AB206B;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18C8BB2085;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 15:00:15 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D523E16C5D84; Thu, 30 May 2019 08:00:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/9] rcu: Make kfree_rcu() ignore NULL pointers
Date:   Thu, 30 May 2019 08:00:09 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145942.GA30318@linux.ibm.com>
References: <20190530145942.GA30318@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053015-0040-0000-0000-000004F68291
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210785; UDB=6.00636158; IPR=6.00991820;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 15:00:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053015-0041-0000-0000-000009029CDE
Message-Id: <20190530150015.30995-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the kfree_rcu() macro's semantics be consistent
with the likes of kfree() by adding a check for NULL pointers, so
that kfree_rcu(NULL, ...) is a no-op.

Reported-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/rcupdate.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 922bb6848813..915460ec0872 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -805,7 +805,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr:	pointer to kfree
- * @rcu_head:	the name of the struct rcu_head within the type of @ptr.
+ * @rhf:	the name of the struct rcu_head within the type of @ptr.
  *
  * Many rcu callbacks functions just call kfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
@@ -828,9 +828,13 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rcu_head)					\
-	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
-
+#define kfree_rcu(ptr, rhf)						\
+do {									\
+	typeof (ptr) ___p = (ptr);					\
+									\
+	if (___p)							\
+		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+} while (0)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
-- 
2.17.1

