Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95515DE16A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfJUAOG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Oct 2019 20:14:06 -0400
Received: from mxszcu.zte.com.cn ([210.21.236.131]:30260 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfJUAOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:14:06 -0400
X-Greylist: delayed 949 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Oct 2019 20:14:05 EDT
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id DA3A3E7E4B382DB64841;
        Mon, 21 Oct 2019 07:58:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9KNvpgJ066673;
        Mon, 21 Oct 2019 07:57:51 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102107473211-44142 ;
          Mon, 21 Oct 2019 07:47:32 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: [PATCH] rcu/rcu_segcblist: fix -Wmissing-prototypes warnings
Date:   Mon, 21 Oct 2019 07:49:55 +0800
Message-Id: <1571615395-3657-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-21 07:47:32,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-21 07:57:52
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x9KNvpgJ066673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get these warnings when build kernel W=1:
kernel/rcu/rcu_segcblist.c:91:6: warning: no previous prototype for ‘rcu_segcblist_set_len’ [-Wmissing-prototypes]
kernel/rcu/rcu_segcblist.c:107:6: warning: no previous prototype for ‘rcu_segcblist_add_len’ [-Wmissing-prototypes]
kernel/rcu/rcu_segcblist.c:137:6: warning: no previous prototype for ‘rcu_segcblist_xchg_len’ [-Wmissing-prototypes]

Commit eda669a6a2c5 ("rcu/nocb: Atomic ->len field in rcu_segcblist
structure") introduced this, and make the functions static to fix
them.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/rcu/rcu_segcblist.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 495c58c..cbc87b8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -88,7 +88,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 }
 
 /* Set the length of an rcu_segcblist structure. */
-void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_set(&rsclp->len, v);
@@ -104,7 +104,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
@@ -134,7 +134,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
  * with the actual number of callbacks on the structure.  This exchange is
  * fully ordered with respect to the callers accesses both before and after.
  */
-long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
+static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	return atomic_long_xchg(&rsclp->len, v);
-- 
1.8.3.1

