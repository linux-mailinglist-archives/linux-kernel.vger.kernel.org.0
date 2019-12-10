Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58B3117EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLJEUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfLJEUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:09 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF17721556;
        Tue, 10 Dec 2019 04:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951608;
        bh=3j+nyDWKXqIsqOHBFtLIdJnOJK5V2lrF9xMWdZQgmXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lsk91IgUVBkujM97Mcza/CQD+FgNCi0BsnzV+NREI2n29V8VgkM/iXLtKmOA9fSSm
         zzpXSTymdGBEviMXrt0qfhpqrBUmSVhZlm9e2fJBFX++by8bfsn7GWII9KnmUKnhym
         B3kF8dyoCltRJod+/YLbCAS7mBkg+gh1xsG8KnWA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/9] rcu: Add a hlist_nulls_unhashed_lockless() function
Date:   Mon,  9 Dec 2019 20:19:59 -0800
Message-Id: <20191210042002.3490-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an hlist_nulls_unhashed_lockless() to allow lockless
checking for whether or note an hlist_nulls_node is hashed or not.
While in the area, this commit also adds a docbook comment to the existing
hlist_nulls_unhashed() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list_nulls.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 1ecd356..fa6e847 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -56,11 +56,33 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
 	return ((unsigned long)ptr) >> 1;
 }
 
+/**
+ * hlist_nulls_unhashed - Has node been removed and reinitialized?
+ * @h: Node to be checked
+ *
+ * Not that not all removal functions will leave a node in unhashed state.
+ * For example, hlist_del_init_rcu() leaves the node in unhashed state,
+ * but hlist_nulls_del() does not.
+ */
 static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
 {
 	return !h->pprev;
 }
 
+/**
+ * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
+ * @h: Node to be checked
+ *
+ * Not that not all removal functions will leave a node in unhashed state.
+ * For example, hlist_del_init_rcu() leaves the node in unhashed state,
+ * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
+ * function may be used locklessly.
+ */
+static inline int hlist_nulls_unhashed_lockless(const struct hlist_nulls_node *h)
+{
+	return !READ_ONCE(h->pprev);
+}
+
 static inline int hlist_nulls_empty(const struct hlist_nulls_head *h)
 {
 	return is_a_nulls(READ_ONCE(h->first));
-- 
2.9.5

