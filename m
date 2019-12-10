Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7159117E99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLJD4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfLJD4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0B5208C3;
        Tue, 10 Dec 2019 03:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950207;
        bh=GAwpCMjHj5zOD5ZADZVB7AaWi8L+kOa1fve5gphakhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7wO3N18BBv9tNklnF6ugGUkqo0TUBzv6+VUhfUIv0xEw91SVPK9eSrO2383wJj/O
         8HxhggsULAOtwslXAjcRkQ5jDMsOWn8Pnn/02dBFwIOGvA3LU5OvOKOdXVVL48piQD
         vtRoaQPEuVc5QhGokFztTjg5Lx0kpg7Rq7aLu3Xk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/7] doc: Updated full list of RCU API in whatisRCU.rst
Date:   Mon,  9 Dec 2019 19:56:40 -0800
Message-Id: <20191210035641.2226-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch updates the list of RCU API in whatisRCU.rst.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Tested-by: Amol Grover <frextrite@gmail.com>
Tested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 2f6f6eb..c7f147b 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
 RCU list traversal::
 
 	list_entry_rcu
+	list_entry_lockless
 	list_first_entry_rcu
 	list_next_rcu
 	list_for_each_entry_rcu
 	list_for_each_entry_continue_rcu
 	list_for_each_entry_from_rcu
+	list_first_or_null_rcu
+	list_next_or_null_rcu
 	hlist_first_rcu
 	hlist_next_rcu
 	hlist_pprev_rcu
@@ -902,7 +905,7 @@ RCU list traversal::
 	hlist_bl_first_rcu
 	hlist_bl_for_each_entry_rcu
 
-RCU pointer/list udate::
+RCU pointer/list update::
 
 	rcu_assign_pointer
 	list_add_rcu
@@ -912,10 +915,12 @@ RCU pointer/list udate::
 	hlist_add_behind_rcu
 	hlist_add_before_rcu
 	hlist_add_head_rcu
+	hlist_add_tail_rcu
 	hlist_del_rcu
 	hlist_del_init_rcu
 	hlist_replace_rcu
-	list_splice_init_rcu()
+	list_splice_init_rcu
+	list_splice_tail_init_rcu
 	hlist_nulls_del_init_rcu
 	hlist_nulls_del_rcu
 	hlist_nulls_add_head_rcu
-- 
2.9.5

