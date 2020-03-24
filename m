Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7D1D19149F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgCXPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgCXPhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:24 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144C620714;
        Tue, 24 Mar 2020 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064243;
        bh=IuBp/xaFr7ZgC7YM6R2iieq975HLH8RBRdBRFZApg8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qs5aP9nlEw42QteOwo5uHGgWaCB9jXQ+POKR/d5+1ybu9PSL4TbUOBhTqDTALLGm+
         zk2IaxLeINs+m4fwCpIxAI0jpcdDX9udzRb/aAr3L3Owlzm2ln11r8qHBGIkMB0RjB
         HOLvPVeAOIdvDyDcFqSQpVTf7Nxa4Gk2tMAUsXHI=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 13/21] list: Add integrity checking to hlist_nulls implementation
Date:   Tue, 24 Mar 2020 15:36:35 +0000
Message-Id: <20200324153643.15527-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the 'hlist_nulls' implementation so that it can optionally
perform integrity checking in a similar fashion to the standard 'list'
code when CONFIG_CHECK_INTEGRITY_LIST=y.

On architectures without a trap value for ILLEGAL_POINTER_VALUE (i.e.
all 32-bit architectures), explicit pointer/poison checks can help to
mitigate UAF vulnerabilities such as the one exploited by "pingpongroot"
(CVE-2015-3636).

Cc: Kees Cook <keescook@chromium.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_nulls.h | 23 +++++++++++++++++++
 lib/list_debug.c           | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 48f33ae16381..379e097e92b0 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -35,6 +35,23 @@ struct hlist_nulls_node {
 	({ typeof(ptr) ____ptr = (ptr); \
 	   !is_a_nulls(____ptr) ? hlist_nulls_entry(____ptr, type, member) : NULL; \
 	})
+
+#ifdef CONFIG_CHECK_INTEGRITY_LIST
+extern bool __hlist_nulls_add_head_valid(struct hlist_nulls_node *new,
+					 struct hlist_nulls_head *head);
+extern bool __hlist_nulls_del_valid(struct hlist_nulls_node *node);
+#else
+static inline bool __hlist_nulls_add_head_valid(struct hlist_nulls_node *new,
+						struct hlist_nulls_head *head)
+{
+	return true;
+}
+static inline bool __hlist_nulls_del_valid(struct hlist_nulls_node *node)
+{
+	return true;
+}
+#endif
+
 /**
  * ptr_is_a_nulls - Test if a ptr is a nulls
  * @ptr: ptr to be tested
@@ -79,6 +96,9 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
 {
 	struct hlist_nulls_node *first = h->first;
 
+	if (!__hlist_nulls_add_head_valid(n, h))
+		return;
+
 	n->next = first;
 	n->pprev = &h->first;
 	h->first = n;
@@ -91,6 +111,9 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 	struct hlist_nulls_node *next = n->next;
 	struct hlist_nulls_node **pprev = n->pprev;
 
+	if (!__hlist_nulls_del_valid(n))
+		return;
+
 	WRITE_ONCE(*pprev, next);
 	if (!is_a_nulls(next))
 		WRITE_ONCE(next->pprev, pprev);
diff --git a/lib/list_debug.c b/lib/list_debug.c
index 03234ebd18c9..b3560de4accc 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -10,6 +10,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/rculist.h>
+#include <linux/rculist_nulls.h>
 
 /*
  * Check that the data structures for the list manipulations are reasonably
@@ -139,3 +140,49 @@ bool __hlist_del_valid(struct hlist_node *node)
 	return true;
 }
 EXPORT_SYMBOL(__hlist_del_valid);
+
+bool __hlist_nulls_add_head_valid(struct hlist_nulls_node *new,
+				  struct hlist_nulls_head *head)
+{
+	struct hlist_nulls_node *first = head->first;
+
+	if (CHECK_DATA_CORRUPTION(!is_a_nulls(first) &&
+				  first->pprev != &head->first,
+			"hlist_nulls_add_head corruption: first->pprev should be &head->first (%px), but was %px (first=%px)",
+			&head->first, first->pprev, first) ||
+	    CHECK_DATA_CORRUPTION(new == first,
+			"hlist_nulls_add_head double add: new (%px) == first (%px)",
+			new, first))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(__hlist_nulls_add_head_valid);
+
+bool __hlist_nulls_del_valid(struct hlist_nulls_node *node)
+{
+	struct hlist_nulls_node *prev, *next = node->next;
+
+	if (CHECK_DATA_CORRUPTION(next == LIST_POISON1,
+			"hlist_nulls_del corruption: %px->next is LIST_POISON1 (%px)\n",
+			node, LIST_POISON1) ||
+	    CHECK_DATA_CORRUPTION(node->pprev == LIST_POISON2,
+			"hlist_nulls_del corruption: %px->pprev is LIST_POISON2 (%px)\n",
+			node, LIST_POISON2))
+		return false;
+
+	BUILD_BUG_ON(offsetof(struct hlist_nulls_node, next) !=
+		     offsetof(struct hlist_nulls_head, first));
+	prev = container_of(node->pprev, struct hlist_nulls_node, next);
+	if (CHECK_DATA_CORRUPTION(prev->next != node,
+			"hlist_nulls_del corruption: prev->next should be %px, but was %px\n",
+			node, prev->next) ||
+	    CHECK_DATA_CORRUPTION(!is_a_nulls(next) &&
+				  next->pprev != &node->next,
+			"hlist_nulls_del corruption: next->pprev should be %px, but was %px\n",
+			&node->next, next->pprev))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(__hlist_nulls_del_valid);
-- 
2.20.1

