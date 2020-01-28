Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640FC14BE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgA1RUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 12:20:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36325 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:20:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so7318278pgc.3;
        Tue, 28 Jan 2020 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jf3QvTBtLBXkEUTUJ6dEyaixgm7RPtLRLhyBEDMajRM=;
        b=CPLLbufURDm6a2I+e5yqSQa31hPHb6Z6iVXHANzSfE6mwte4IcdDCHSoosA5y38tdR
         v6SDkrLCTZYuTLqBEIIjkkn0C0ceHnHn3y4ka6znW+EKcqQXl5n5UpHwUzbTilqxmcAz
         Kn2oh6Q6nbOIAfsu4r6VBt0Dh0nKM7AU7O8ztAHxWZEWSXhoMW+UPnybyI+FMY4pam+Z
         2yho40MOQJTkU6xmY+Xk/SezwWKZ8yubPpYr/WoDjeudSjqhPAXli6Tsxx1F0kuN5JOf
         1EyHzLtRepzLVujQUWopEYqCDY6Eu6hKM+c4Fe6ZH47XDTFESizWTmG/BFGjTRumYhG5
         Kqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jf3QvTBtLBXkEUTUJ6dEyaixgm7RPtLRLhyBEDMajRM=;
        b=pBZ7oLRfm/6gr8YN65/U3C/5ewMcdSrABegqDpirBOeccekymRxBswFL0uuhhXQ91Q
         hpPfToEisC6rhm+0k8f9LcJvAQUX/hzJeabigFbuOFL7dj5FektBBu5ZwKP5UqahgFKZ
         NkqfyfrgwmUKe1Z0/CuewfGn63YRF/ABNoffdMq8ewywFYtRqf9pQGxVK9uRYBp8gGT7
         r1P+xHlTgpqJ+YrhiB1gk2UA/2kgp1wlOb2BpTPL9/qk0UrBQ9mDkXbSJKMt/nWo3uSw
         qZ4d4an/pCBtTVlY0DpK47ahLRaQ/f54QkWQLiKSUODu7BTGXAvtuGrbB5JlNv0G15RD
         5fmQ==
X-Gm-Message-State: APjAAAVeiu/Y/DquPxb6YgrY7BPdAqN0SLGxDqYMqkKnYndUQ9qbu5QO
        NEm36rC+J5hO5+ket9Lt4A==
X-Google-Smtp-Source: APXvYqze9wR3ZSNvjNvbxyEc55dGBVFLhZEOOt3MVtGqsOWYO0pXeFv5/z2zgpaWXrdU3bkJWUqghw==
X-Received: by 2002:a65:4b85:: with SMTP id t5mr20864227pgq.404.1580232017665;
        Tue, 28 Jan 2020 09:20:17 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee4:f372:cc5e:c7d9:2a24:390])
        by smtp.gmail.com with ESMTPSA id w26sm12959417pfj.119.2020.01.28.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:20:17 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        christian.brauner@ubuntu.com, paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] exit.c: Fix Sparse errors and warnings
Date:   Tue, 28 Jan 2020 22:50:08 +0530
Message-Id: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse error:
kernel/exit.c:627:25: error: incompatible types in comparison expression
caused due to accessing rcu protected pointer without using rcu primitives.

And the following warning:

kernel/exit.c:626:40: warning: incorrect type in assignment

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/exit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd59888e67..c5a9d6360440 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -623,8 +623,8 @@ static void forget_original_parent(struct task_struct *father,
 	reaper = find_new_reaper(father, reaper);
 	list_for_each_entry(p, &father->children, sibling) {
 		for_each_thread(p, t) {
-			t->real_parent = reaper;
-			BUG_ON((!t->ptrace) != (t->parent == father));
+			rcu_assign_pointer(t->real_parent, reaper);
+			BUG_ON((!t->ptrace) != (rcu_access_pointer(t->parent) == father));
 			if (likely(!t->ptrace))
 				t->parent = t->real_parent;
 			if (t->pdeath_signal)
-- 
2.17.1

