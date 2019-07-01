Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9112459736
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfF1JR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:17:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37158 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF1JR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so2673166pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/Oi7+gcXE4vGhyVtvahQ7NvsegeiMHvE0eTA3m0fis=;
        b=NQObfoJyE6ZFX860JtlLpJX2VjoKudHCXHILAS3bawxQttn8vDhXi5AxefPppi+Qlt
         NucbVh/PhT33F3ELt42eD2RLXZRdP0jy9oGN7zMKijR/J3xzE5D7+f2pI5wjwYDVOUUw
         Dgby5fhXN17SpBbb/L+kVXCMCpMma1S1HREk2T5xn52UJOQtMlwwlXeUXqZCgl5yaHCe
         a0yQ6zgrlVK9x6Yqt7zwFPJf/bWctx1LojW1PAaHiEZz+JSnl/UIS25EMURktSXyyCuL
         SneopPHHdzWDfHWgETUKxIMPhd6pI9B8ghN2RVNCgtTKQ8j7h/aeJWbsHh46QvlVkbEg
         UlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/Oi7+gcXE4vGhyVtvahQ7NvsegeiMHvE0eTA3m0fis=;
        b=KpgC8v5BgFaTDNbEoLm1kgPwOM015Wi5NDPUNHCRFVJqaIOzxReUlCyxOeKxOQvetb
         p/cTdOiaGXwC+bhf6ONYD6GyzxXwTWccoe3h/bCjLnMDuqOeSDVetay/yK01MzWRe0om
         mH+cZ5Vhh4a9KwsLOpRlcMgqq4tmrlWWuns45Q6NWIWUgfPW+JGIcd+39zSrdsAdDvs7
         nmXL/mmOJBm3le1t06zKMHkGFrNSBvpVMg29niKI5BfJEbsFRM9rPGQ1TODysAUpiVN9
         Y9N47oCJ9CVAB4xmo8kSXoGzQdgahp0hotjbQVXxBH0wIf1wnV1EvSbryp9o+3zdX5K3
         0k6Q==
X-Gm-Message-State: APjAAAWe835lfvFfLtFV2ldI2DzB8AG6ZOUd9N0VSrSlAbgFqnB4v7sK
        Cx7EBWDgsRr3nGmzPil8YFA=
X-Google-Smtp-Source: APXvYqwbO9++6IxLqku/FcAfjWigmcRvgFAqNKSsDz/FWs3Wm+9FEbHRxG1BLSehPedAoQoqAKyeJw==
X-Received: by 2002:a63:f95d:: with SMTP id q29mr8231072pgk.368.1561713446623;
        Fri, 28 Jun 2019 02:17:26 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:26 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 23/30] locking/lockdep: Define the two task model for lockdep checks formally
Date:   Fri, 28 Jun 2019 17:15:21 +0800
Message-Id: <20190628091528.17059-24-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep effectively uses a two-task model to track workload's locking
behavior and do the checking to find inversion deadlock scenarios based
on such model. Lets explain it in detail.

When there is a new lock dependency L1 -> L2 (i.e., the current task
attempts to acquire L2 while holding L1), which is from a new lock
chain's latest two locks, lockdep's view of the world is composed of two
virtual tasks:

 - Task1: the entire previous locking behavior depicted by the forward
   lock dependency graph.

 - Task2: the current new locking behavior, the L1 -> L2 dependency.

For these two tasks, lockdep tries to find whether there exists the
inverse locking order of L1 -> L2, namely L2 -> L1. If this inverse
locking order exists, then lockdep finds the typical inversion deadlock
scenario, a.k.a, ABBA deadlock. And if not, Task2 will be merged into
Task1 to become a new bigger Task1 with a bigger graph. Then this track
and check cycle goes on and on.

There is some nuances between this two-task model and the real workload
locking behavior in terms of equivalency which affects lockdep finding
true (not false positive) deadlock scenarios. Some examples:

(The following Tx denotes concrete tasks)

    T1
    --

    L1
    L2

    (L1 and L2 released)

    L2
    L3

    T2
    --

    L1
    L2
    L3

Both T1 and T2 will produce the same Task1 from the perspective of
lockdep's two-task model. However, this model does not actually reflect
the reality in full length. In T1, L1 -> L3 actually has no "real"
dependency while in T2 it is "real". A real X -> Y lock dependency is
defined as a task is attempting to acquire Y while holding X. This may
result in false positive deadlock scenarios. For example:

Case #1.1:

    T1        T2
    --        --

    L1
    L2        L3
    L3        L1   [Deadlock]

Case #1.2 (T1 is a singular task):

    T1        T2
    --        --

    L1
    L2

    (L1 L2 released)

    L2        L3
    L3        L1   [No deadlock]

Case #1.3:

    T1a       T1b       T2
    ---       ---       --

    L1        L1
    L2        L2

    (L1 L2 released
     in T1a and T1b)

    L2        L2        L3
    L3        L3        L1   [Deadlock]

From Case #1.2 (no deadlock) to Case #1.3 (deadlock), we can see that
lockdep is also assuming there can be multiple Task1's on top of the
two-task model, and from pragmatic point of view, this assumption is not
unrealistic to make.

However, with read locks that can be fully concurrent with read locks
and not be blocked by write locks (such as the rwlock). Lockdep's such
model is flawed. For example (the following read locks, denoted as RR,
and write locks are of type rwlock):

Case #2.1:

    T1        T2
    --        --

    W1
    RR2       W3
    W3        W1   [Deadlock]

Case #2.2:

    T1a       T1b       T2
    ---       ---       --

    W1        RR2       W3
    RR2       W3        W1   [No deadlock]

Case #2.3:

    T1a       T1b       T2
    ---       ---       --

    W1        W1
    RR2       RR2

    (W1 RR2 released
     in T1a and T1b)

    RR2       RR2       W3
    W3        W3        W1   [No deadlock]

Lockdep cannot differentiate Case #2.1 from Case #2.2 and Case #2.3 or
vice versa. This is because when modeling Task1, it cannot tell whether
two neighboring direct dependencies in the graph are in the same real
task and hence create a "real" dependency.

To make up for this, the two-task model needs to be strengthened. We
previously mapped lock chains to lock dependency graph and added
read-write lock types into dependencies. This patch finally modifies the
graph traversing algorithm (__bfs()) to stop when two neighboring direct
dependencies are not in the same lock chain and the middle lock is a
recursive-read lock (rwlock).

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7d02b94..444eb62 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1545,6 +1545,71 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 }
 
 /*
+ * A lock stopper in the dependency graph is a read lock that stops the
+ * graph traversal passing through it even if the two dependencies are
+ * linked in a path. A stopper sits in such two lock dependencies:
+ *
+ *     X -> RR (stopper) -> X (where RR is recursive-read lock)
+ *
+ * and these two dependencies are NOT from one lock chain.
+ */
+static inline bool
+read_lock_stopper(struct lock_list *parent, struct lock_list *child, int forward)
+{
+	struct lock_chain *chain1, *chain2;
+	struct lock_list *list[2] = { child, parent };
+	u64 key1, key2;
+	int distance, other = 1 - forward;
+
+	/* This is the source entry */
+	if (!get_lock_parent(parent))
+		return false;
+
+	if (!(get_lock_type1(list[other]) == LOCK_TYPE_RECURSIVE &&
+	      get_lock_type2(list[forward]) == LOCK_TYPE_RECURSIVE))
+		return false;
+
+	distance = list[forward]->distance;
+
+	list_for_each_entry_rcu(chain1, &list[forward]->chains, chain_entry) {
+		key1 = chain1->chain_key;
+
+		list_for_each_entry_rcu(chain2, &list[other]->chains, chain_entry) {
+			/*
+			 * If the two chains are in the same task lock stack,
+			 * we should be able to calculate key2 from key1 if
+			 * distance is 1, or calculate key1 from key2 if
+			 * distance is larger than 1.
+			 */
+			if (distance == 1) {
+				int class_idx = fw_dep_class(list[other]) - lock_classes;
+				key1 = iterate_chain_key(key1, class_idx,
+							 get_lock_type2(list[other]));
+				key2 = chain2->chain_key;
+
+				if (key1 == key2)
+					return false;
+			}
+			else {
+				int i = chain1->base, j = chain2->base;
+
+				if (chain1->depth != chain2->depth - distance)
+					continue;
+
+				for (; i < chain1->depth - 1; i++, j++)
+					if (chain_hlocks[i] != chain_hlocks[j] ||
+					    chain_hlocks_type[i] != chain_hlocks_type[i])
+						continue;
+
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+/*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
@@ -1584,6 +1649,9 @@ static int __bfs(struct lock_list *source_entry,
 			if (!lock_accessed(entry, forward)) {
 				unsigned int cq_depth;
 
+				if (read_lock_stopper(lock, entry, forward))
+					continue;
+
 				mark_lock_accessed(entry, lock, forward);
 
 				if (__cq_enqueue(cq, entry)) {
-- 
1.8.3.1

