Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB3117EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 05:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfLJEUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 23:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfLJEUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:10 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205AC24653;
        Tue, 10 Dec 2019 04:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951609;
        bh=s8MWRwAjm8mlj+5cwYZV3e60JuvOkWNE1NL5PFrhIj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOT5nHF6fij6kGsDrw8INuOjmQMvHns/r5jegSPTZgKdpVpr14ujAb714XManbNd2
         RG8+8d9W43HMZaOMnV8aD6epkG0I9D043RVD1Wj/q1p14M9XNrOYCe0PUiUBlA+V11
         EiQ6JAtb+vFuruvthPraFMfrK+yacL9TeZu8fNpw=
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
Subject: [PATCH tip/core/rcu 8/9] rculist_nulls: Change docbook comment headers
Date:   Mon,  9 Dec 2019 20:20:01 -0800
Message-Id: <20191210042002.3490-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch changes the docbook comment "head for your list"
to "head of the list".

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 25952c4..409a86b 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -112,7 +112,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
@@ -132,7 +132,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  *   iterate over list of given type safe against removal of list entry
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  */
 #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)		\
-- 
2.9.5

