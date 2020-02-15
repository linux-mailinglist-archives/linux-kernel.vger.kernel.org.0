Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50C15FB8C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBOAlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:36 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD3A2082F;
        Sat, 15 Feb 2020 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727295;
        bh=N1Aak56BohJjQ1J0OxXRukRjP6wUOprgC/m9UHl76Bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7Ymzx5O4OFspEmZkvzxP6UHoh1xU5tWmutYSNMFCnjtoC9SSKoufJ+kDq7PdNErX
         sqr8QVIhzI9y7ypqpwpwxcFyPrZhLDYnecdqBCJAAddx1H5odnNIHe4vkRXk0wfxPB
         HVhMN2S/BaixbnrYIt/ipaAfEO1pGD3aLG7OEIcw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/18] rcutorture: Add 100-CPU configuration
Date:   Fri, 14 Feb 2020 16:41:15 -0800
Message-Id: <20200215004125.16953-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The small-system rcutorture configurations have served us well for a great
many years, but it is now time to add a larger one.  This commit does
just that, but does not add it to the defaults in CFLIST.  This allows
the kvm.sh argument '--configs "4*CFLIST TREE10" to run four instances
of each of the default configurations concurrently with one instance of
the large configuration.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE10 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE10 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
new file mode 100644
index 0000000..2debe78
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE10
@@ -0,0 +1,18 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=100
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TREE_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_TRACE=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_OBJECTS=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=n
-- 
2.9.5

