Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509AD15FAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBNXjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgBNXjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:39:19 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745B024673;
        Fri, 14 Feb 2020 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581723558;
        bh=Qp97dYZv0V8DJDuNUWv5M4dQNx+u3lirpGz1bG3dsO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxY7OCjtYlOTPlwtP627oO0otjjB4dxwWwxbt0BmBxM/QZl4lLc97jsbhy53jOwBc
         /tqzCgX8o5AHqUhWvxIRgrMKtLvXGvz2u7393hHbrAAfuh4LmUGxWGrlGoGCXOSJeq
         xIZEVjxIcT1A1s6GFkQ5PjKg2bfIJRfeDiIXIY8c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/9] doc/RCU/listRCU: Fix typos in a example code snippets
Date:   Fri, 14 Feb 2020 15:38:57 -0800
Message-Id: <20200214233903.12916-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/listRCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 55d2b30..e768f56 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -226,7 +226,7 @@ need to be filled in)::
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				e->rule.action = newaction;
-				e->rule.file_count = newfield_count;
+				e->rule.field_count = newfield_count;
 				write_unlock(&auditsc_lock);
 				return 0;
 			}
@@ -255,7 +255,7 @@ RCU (*read-copy update*) its name.  The RCU code is as follows::
 					return -ENOMEM;
 				audit_copy_rule(&ne->rule, &e->rule);
 				ne->rule.action = newaction;
-				ne->rule.file_count = newfield_count;
+				ne->rule.field_count = newfield_count;
 				list_replace_rcu(&e->list, &ne->list);
 				call_rcu(&e->rcu, audit_free_rule);
 				return 0;
-- 
2.9.5

