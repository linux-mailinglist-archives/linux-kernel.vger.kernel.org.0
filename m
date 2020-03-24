Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EDB1914AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgCXPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgCXPhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:40 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0501920714;
        Tue, 24 Mar 2020 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064260;
        bh=XWqetTA32I53c5P8S/oKOfl+VkXjOX16eJWZLMzOkxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2t5R6HqMQbGBFIPAA+m6IOSLwhb7FStDZ8NFam625QSOCw14mFlTiBsnuvoca/Wy
         F9ymQwGi3yTJSwaDwLbIRHrePiqOWHxe3LDUbMKaJuAIGjTipAHROumUZNcee+9+XJ
         1kvxdazNh14ZQQAwicQRBhJkCu/JdSz+UnWDb78U=
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
Subject: [RFC PATCH 20/21] list: Format CHECK_DATA_CORRUPTION error messages consistently
Date:   Tue, 24 Mar 2020 15:36:42 +0000
Message-Id: <20200324153643.15527-21-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error strings printed when list data corruption is detected are
formatted inconsistently.

Satisfy my inner-pedant by consistently using ':' to limit the message
from its prefix and drop the terminating full stops where they exist.

Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/list_debug.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/list_debug.c b/lib/list_debug.c
index 3be50b5c8014..00e414508f93 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -23,10 +23,10 @@ bool __list_add_valid(struct list_head *new, struct list_head *prev,
 		      struct list_head *next)
 {
 	if (CHECK_DATA_CORRUPTION(next->prev != prev,
-			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
+			"list_add corruption: next->prev should be prev (%px), but was %px (next=%px)\n",
 			prev, next->prev, next) ||
 	    CHECK_DATA_CORRUPTION(prev->next != next,
-			"list_add corruption. prev->next should be next (%px), but was %px. (prev=%px).\n",
+			"list_add corruption: prev->next should be next (%px), but was %px (prev=%px)\n",
 			next, prev->next, prev) ||
 	    CHECK_DATA_CORRUPTION(new == prev || new == next,
 			"list_add double add: new=%px, prev=%px, next=%px.\n",
@@ -45,16 +45,16 @@ bool __list_del_entry_valid(struct list_head *entry)
 	next = entry->next;
 
 	if (CHECK_DATA_CORRUPTION(next == LIST_POISON1,
-			"list_del corruption, %px->next is LIST_POISON1 (%px)\n",
+			"list_del corruption: %px->next is LIST_POISON1 (%px)\n",
 			entry, LIST_POISON1) ||
 	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2,
-			"list_del corruption, %px->prev is LIST_POISON2 (%px)\n",
+			"list_del corruption: %px->prev is LIST_POISON2 (%px)\n",
 			entry, LIST_POISON2) ||
 	    CHECK_DATA_CORRUPTION(prev->next != entry,
-			"list_del corruption. prev->next should be %px, but was %px\n",
+			"list_del corruption: prev->next should be %px, but was %px\n",
 			entry, prev->next) ||
 	    CHECK_DATA_CORRUPTION(next->prev != entry,
-			"list_del corruption. next->prev should be %px, but was %px\n",
+			"list_del corruption: next->prev should be %px, but was %px\n",
 			entry, next->prev))
 		return false;
 
@@ -196,7 +196,7 @@ bool __hlist_bl_add_head_valid(struct hlist_bl_node *new,
 	unsigned long nlock = (unsigned long)new & LIST_BL_LOCKMASK;
 
 	if (CHECK_DATA_CORRUPTION(nlock,
-			"hlist_bl_add_head: node is locked\n") ||
+			"hlist_bl_add_head corruption: node is locked\n") ||
 	    CHECK_DATA_CORRUPTION(hlock != LIST_BL_LOCKMASK,
 			"hlist_bl_add_head: head is unlocked\n"))
 		return false;
@@ -222,10 +222,10 @@ bool __hlist_bl_del_valid(struct hlist_bl_node *node)
 	if (CHECK_DATA_CORRUPTION(nlock,
 			"hlist_bl_del corruption: node is locked") ||
 	    CHECK_DATA_CORRUPTION(next == LIST_POISON1,
-			"hlist_bl_del corruption, %px->next is LIST_POISON1 (%px)\n",
+			"hlist_bl_del corruption: %px->next is LIST_POISON1 (%px)\n",
 			node, LIST_POISON1) ||
 	    CHECK_DATA_CORRUPTION(node->pprev == LIST_POISON2,
-			"hlist_bl_del corruption, %px->pprev is LIST_POISON2 (%px)\n",
+			"hlist_bl_del corruption: %px->pprev is LIST_POISON2 (%px)\n",
 			node, LIST_POISON2))
 		return false;
 
-- 
2.20.1

