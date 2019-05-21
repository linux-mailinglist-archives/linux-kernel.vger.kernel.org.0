Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA825BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 04:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfEVC34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 22:29:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfEVC34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 22:29:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M2T0FR038593;
        Wed, 22 May 2019 02:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZXUeQYgZB3O0V7HnlxDvOw49BMFt48EfbIn16aNTl/g=;
 b=pzLjNCWji1W1SDF9Bw9C/ZEezK9tc+A83lNgJZbqCd02orKUVbRCZ6qlapXr3wUJEjWW
 yLGMlFypDraEnHBeGQ9uzFJpoLUMciJGWWBWytfD26rCDCEcH8OtgPkLg0im6fI+cWt3
 BqvzhIaHlvsiXoPR/KNtJt/gJM/M5STmS02611bN5GjX6Hv1LQV2EW3iIZMRQHL2irDk
 WLTKbu8N2tA/IOBxz44m/x7nNsoV0lGg4Oe5Rs83FF9aYup0Z8N0NR0QmTUNlDDo5InV
 +f0mDTzN3f6jUNTmvXopZ2NJCKyUsy9y39NETflGe5gjn9l1Se6pqsc/++3Mc0ZI66xL BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2smsk58rtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 02:29:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M2SDh1017840;
        Wed, 22 May 2019 02:28:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2smsgsawm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 02:28:59 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4M2SphF018805;
        Wed, 22 May 2019 02:28:51 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 02:28:50 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v3] doc: kernel-parameters.txt: fix documentation of nmi_watchdog parameter
Date:   Tue, 21 May 2019 10:32:08 +0800
Message-Id: <1558405928-29449-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behavior of hardlockup depends on the config of
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.

Fix the description of nmi_watchdog to make it clear.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org
---
 v3: add Suggested-by and Acked-by
 v2: fix description using words suggested by Steven Rostedt

 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 08df588..b9d4358 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2805,8 +2805,9 @@
 			0 - turn hardlockup detector in nmi_watchdog off
 			1 - turn hardlockup detector in nmi_watchdog on
 			When panic is specified, panic when an NMI watchdog
-			timeout occurs (or 'nopanic' to override the opposite
-			default). To disable both hard and soft lockup detectors,
+			timeout occurs (or 'nopanic' to not panic on an NMI
+			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
+			To disable both hard and soft lockup detectors,
 			please see 'nowatchdog'.
 			This is useful when you use a panic=... timeout and
 			need the box quickly up again.
-- 
1.8.3.1

