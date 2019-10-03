Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CFC963A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfJCBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfJCBdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34023222C9;
        Thu,  3 Oct 2019 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066389;
        bh=pfrPy9qoyUeN3QT0f/Gn3pelNr8ySknyukYPaJanal8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oY7RSDYub+9H5xBxhaItvT//qysQe+42CsMbLcyQk2I2tWbEri1QJprTFVSkYFpVD
         0/0u+GFEBIpkbzBD56Oduu+m3tscTo85VXvDabuRt7EYjRkCmRUyFk6sDa6+gWjTGr
         VUe7ocITTsg40lCYUTBZ98na2dl0Vt7ucYidNdXA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 7/8] rcu: Update descriptions for rcu_future_grace_period tracepoint
Date:   Wed,  2 Oct 2019 18:33:04 -0700
Message-Id: <20191003013305.12854-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/trace/events/rcu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 4609f2e..6612260 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -93,16 +93,16 @@ TRACE_EVENT_RCU(rcu_grace_period,
  * the data from the rcu_node structure, other than rcuname, which comes
  * from the rcu_state structure, and event, which is one of the following:
  *
- * "Startleaf": Request a grace period based on leaf-node data.
+ * "Cleanup": Clean up rcu_node structure after previous GP.
+ * "CleanupMore": Clean up, and another GP is needed.
+ * "EndWait": Complete wait.
+ * "NoGPkthread": The RCU grace-period kthread has not yet started.
  * "Prestarted": Someone beat us to the request
  * "Startedleaf": Leaf node marked for future GP.
  * "Startedleafroot": All nodes from leaf to root marked for future GP.
  * "Startedroot": Requested a nocb grace period based on root-node data.
- * "NoGPkthread": The RCU grace-period kthread has not yet started.
+ * "Startleaf": Request a grace period based on leaf-node data.
  * "StartWait": Start waiting for the requested grace period.
- * "EndWait": Complete wait.
- * "Cleanup": Clean up rcu_node structure after previous GP.
- * "CleanupMore": Clean up, and another GP is needed.
  */
 TRACE_EVENT_RCU(rcu_future_grace_period,
 
-- 
2.9.5

