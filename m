Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF5F50B46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbfFXM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 08:59:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfFXM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:59:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCsDLG045435;
        Mon, 24 Jun 2019 12:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=jaU83NGwOLr2N5PgdllXKvjXli4sJG6LWT0iy1ceckk=;
 b=u2EbgL0wQ/sxUpIXjyu0/YRWxY5ZDzQBH+C5Uem8QNSMKIdefClAU0Ka8+85IuZPsp4X
 cFolgzn6zHWzwhF1k57OSatC7u1UuuQ/6iE1zgvvgIy/hUsxrCcjIrvmJiVTVmy/wNvv
 5Xi9I18dKwBSVKA4tENFF52KOuLg0zgj3W/k0zx1ojN+6q/WZACYRs+owzOFyk17eW7F
 3T9Ehu5dPywxF5uyp5FmsZheF1cFZfz5F6IlNdCaKdffBhKjkAE/zZ2U6Nhy6qf+xm7q
 Y4b0BtY6f+6CkxEgb4BBxD4PvxD3JMWu08MclFQf7qxpCOK3kr9kFd2xB5AtuOB0pIuL /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9pe7es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCw9wv042158;
        Mon, 24 Jun 2019 12:58:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acbg5s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:58:27 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OCwQo7028159;
        Mon, 24 Jun 2019 12:58:26 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:58:25 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 6/6] Revert "x86/paravirt: Set up the virt_spin_lock_key after static keys get initialized"
Date:   Sun, 23 Jun 2019 21:01:43 +0800
Message-Id: <1561294903-6166-6-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ca5d376e17072c1b60c3fee66f3be58ef018952d.

Commit 8990cac6e5ea ("x86/jump_label: Initialize static branching
early") adds jump_label_init() call in setup_arch() to make static
keys initialized early, so we could use the original simpler code
again.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/smpboot.c | 3 +--
 arch/x86/xen/spinlock.c   | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 362dd89..44472ca 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1308,8 +1308,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	pr_info("CPU0: ");
 	print_cpu_info(&cpu_data(0));
 
-	native_pv_lock_init();
-
 	uv_system_init();
 
 	set_mtrr_aps_delayed_init();
@@ -1339,6 +1337,7 @@ void __init native_smp_prepare_boot_cpu(void)
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
+	native_pv_lock_init();
 }
 
 void __init calculate_max_logical_packages(void)
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3776122..6deb490 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -68,11 +68,8 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin) {
-		if (cpu == 0)
-			static_branch_disable(&virt_spin_lock_key);
+	if (!xen_pvspin)
 		return;
-	}
 
 	WARN(per_cpu(lock_kicker_irq, cpu) >= 0, "spinlock on CPU%d exists on IRQ%d!\n",
 	     cpu, per_cpu(lock_kicker_irq, cpu));
@@ -124,6 +121,7 @@ void __init xen_init_spinlocks(void)
 
 	if (!xen_pvspin) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
+		static_branch_disable(&virt_spin_lock_key);
 		return;
 	}
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
-- 
1.8.3.1

