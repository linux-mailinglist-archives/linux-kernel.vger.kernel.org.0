Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC7C967A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfJCBsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfJCBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CB8222C4;
        Thu,  3 Oct 2019 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067251;
        bh=4aOPyTJph2xYG0MK69zyCvwxb5I4yf1354D3Ac5DoPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ram4/adO9JSNrRigaxHPNB9ZBuARLCuLgvClsrX3waXCbMmiD1v8HWl5dHQk8FTUx
         yrXLXY9ZOx4CMoeGbu3FTMhU/PWCH3vPs4z20Hei/1rDVUZYVzcSU/SFxrTsOGgXjU
         qQLbWSMRhPJM/Q+0cy9QSakgnz74adwYyZJKpGkY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Chuhong Yuan <hslester96@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/9] locktorture: Replace strncmp() with str_has_prefix()
Date:   Wed,  2 Oct 2019 18:47:21 -0700
Message-Id: <20191003014728.13496-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

The strncmp() function is error-prone because it is easy to get the
length wrong, especially if the string is subject to change, especially
given the need to account for the terminating nul byte.  This commit
therefore substitutes the newly introduced str_has_prefix(), which
does not require a separately specified length.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/locking/locktorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c513031..8dd9002 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -889,16 +889,16 @@ static int __init lock_torture_init(void)
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
 #ifdef CONFIG_DEBUG_MUTEXES
-	if (strncmp(torture_type, "mutex", 5) == 0)
+	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (strncmp(torture_type, "rtmutex", 7) == 0)
+	if (str_has_prefix(torture_type, "rtmutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if ((strncmp(torture_type, "spin", 4) == 0) ||
-	    (strncmp(torture_type, "rw_lock", 7) == 0))
+	if ((str_has_prefix(torture_type, "spin")) ||
+	    (str_has_prefix(torture_type, "rw_lock")))
 		cxt.debug_lock = true;
 #endif
 
-- 
2.9.5

