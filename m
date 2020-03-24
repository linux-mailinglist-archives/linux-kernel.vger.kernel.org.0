Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE188191505
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgCXPjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:06 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F75208CA;
        Tue, 24 Mar 2020 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064225;
        bh=HtIRk6SgACDcRR+T26oZFJ9RbFoiC+0T7/ZIAIszoac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFTF6dbidKK8bNsgiuQ0YzqiFJ+943Y1octiEX2ks522jykL3FeaoEC3/EpDpuGxK
         iSRCdwylEHOAzHH1M8Ru71ywTMdX5d3vcvYKSCwuwDdqH30UHL4KfqwkSoefwChV6R
         R1D6o74rD1071XZ6dlZnno/5DtUel35g3aexpV9w=
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
Subject: [RFC PATCH 06/21] list: Remove superfluous WRITE_ONCE() from hlist_nulls implementation
Date:   Tue, 24 Mar 2020 15:36:28 +0000
Message-Id: <20200324153643.15527-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev
for hlist_nulls") added WRITE_ONCE() invocations to hlist_nulls_add_head()
and hlist_nulls_del().

Since these functions should not ordinarily run concurrently with other
list accessors, restore the plain C assignments so that KCSAN can yell
if a data race occurs.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_nulls.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa51a801bf32..fd154ceb5b0d 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -80,10 +80,10 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
 	struct hlist_nulls_node *first = h->first;
 
 	n->next = first;
-	WRITE_ONCE(n->pprev, &h->first);
+	n->pprev = &h->first;
 	h->first = n;
 	if (!is_a_nulls(first))
-		WRITE_ONCE(first->pprev, &n->next);
+		first->pprev = &n->next;
 }
 
 static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
@@ -99,7 +99,7 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	WRITE_ONCE(n->pprev, LIST_POISON2);
+	n->pprev = LIST_POISON2;
 }
 
 /**
-- 
2.20.1

