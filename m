Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F419149C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgCXPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgCXPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:13 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 220872137B;
        Tue, 24 Mar 2020 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064233;
        bh=hsEWh4lkEZJj8SgPovkPJPa8VD6fGH33UAu8+iJ0v3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sh+iGzEj3EFKgcy1Fl5LykZI4hKr6kfQvQMK1zjUj9XrGmYyiVbiPkykjJ8oa7kcv
         2hyjEQEDZo3ISlrHu8UFUARgGL47vL7/K/5qVrrBL853pxxr3ZjrYkJlSSruOY+cHe
         Eizev4Onuh72ciaMDl/jVo8Fmg9r5oEA5OiZpPPo=
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
Subject: [RFC PATCH 09/21] list: Remove unnecessary WRITE_ONCE() from hlist_bl_add_before()
Date:   Tue, 24 Mar 2020 15:36:31 +0000
Message-Id: <20200324153643.15527-10-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use WRITE_ONCE() when inserting into a non-RCU
protected list.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_bl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 1804fdb84dda..c93e7e3aa8fc 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -91,15 +91,15 @@ static inline void hlist_bl_add_before(struct hlist_bl_node *n,
 				       struct hlist_bl_node *next)
 {
 	struct hlist_bl_node **pprev = next->pprev;
+	unsigned long val;
 
 	n->pprev = pprev;
 	n->next = next;
 	next->pprev = &n->next;
 
 	/* pprev may be `first`, so be careful not to lose the lock bit */
-	WRITE_ONCE(*pprev,
-		   (struct hlist_bl_node *)
-			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
+	val = (unsigned long)n | ((unsigned long)*pprev & LIST_BL_LOCKMASK);
+	*pprev = (struct hlist_bl_node *)val;
 }
 
 static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
-- 
2.20.1

