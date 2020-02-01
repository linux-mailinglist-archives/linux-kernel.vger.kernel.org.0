Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAB814F7D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 13:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBAM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 07:58:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42057 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgBAM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 07:58:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so5097778pgb.9;
        Sat, 01 Feb 2020 04:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sg2eOI3lpxVLDcDQYQkxI8yUvrkJbYXCIF4uNleTtLs=;
        b=VzPZwDZTiS0OoC9iJdqoQZ1rJQirI983lgb8kIAJifeN7iI9AFpWSkW3lfGLH/Wqny
         9SPjmGclSfOzm0g88K0e38IsOKwyGaexWV6Er/Ua0KH43NACA+d4KQQkN7ig5POv38+M
         YturwSNZ1zWY+IpsyBi5TWxl3a9tp9tJEQH4KuG5IBwYJK2KryuioiFI/o+DDsViZP/I
         JaucO0AUmY/47JkO3fIw7Ch4v5pPPLE+6CWVMKIYfugruQT8AR+1XkDXiL6j8HTGplAW
         cP9PMZvYhP8K+ibnghXfauWD7g1oCGNOR17tbzDyTbaKXAVHH+LK0580wn3RirUXrLsb
         QYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sg2eOI3lpxVLDcDQYQkxI8yUvrkJbYXCIF4uNleTtLs=;
        b=eztKJX1avs0jMKGvB+nAJL/k7Az8457KlPZyL4reoD5mdO+T7xChwXTX8vTqeiyowc
         ox1/ZeEFVzuXSubyZDsRxXEIpmCLH+3oAIuK7nbFCnN6e3eyItXWUXOH5vmlqVhkNAug
         YOXoG9ZRpqZMXPNjeYy0aZH8vNrViy/U8MS973CaNzUuD7eUwx2vAONTk6NF05JFtohi
         i3XUjVyAD4OgedjYSRzpirp/3MnH+9aAEh69QAm1LcwhPOtYM08Wy4mYDHA9iPlC86z/
         PzZJklus41Q5Dr8dLUvXfmcjzHd77p/Qp7Im2a2w25IjgEJypyRQwWU7WDVFIC9lk3IG
         2s1Q==
X-Gm-Message-State: APjAAAWlM3d7V5Lpo4oVi7HWrBijrcHmYA+wGYEnRSke/HgefkLWuicZ
        9omgV6YB/q+UOqcSwbPjbw==
X-Google-Smtp-Source: APXvYqworotb8yqMSLn48khNRtGO3KrwLk+wNzdBnnKoVNx2LbrYoU5BvXU8otqmX/6laJRxkocHmg==
X-Received: by 2002:a63:1a08:: with SMTP id a8mr15444283pga.425.1580561921051;
        Sat, 01 Feb 2020 04:58:41 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:cd2:8ab5:f87d:af67:e1a2:1634])
        by smtp.gmail.com with ESMTPSA id g22sm13607889pgk.85.2020.02.01.04.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 04:58:40 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, joel@joelfernandes.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] sched.h: Annotate curr pointer in rq with __rcu
Date:   Sat,  1 Feb 2020 18:28:03 +0530
Message-Id: <20200201125803.20245-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors in sched/core.c
and sched/membarrier.c
:
kernel/sched/core.c:2372:27: error: incompatible types in comparison expression
kernel/sched/core.c:4061:17: error: incompatible types in comparison expression
kernel/sched/core.c:6067:9: error: incompatible types in comparison expression
kernel/sched/membarrier.c:108:21: error: incompatible types in comparison expression
kernel/sched/membarrier.c:177:21: error: incompatible types in comparison expression
kernel/sched/membarrier.c:243:21: error: incompatible types in comparison expression

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..97b1396b6008 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -896,7 +896,7 @@ struct rq {
 	 */
 	unsigned long		nr_uninterruptible;
 
-	struct task_struct	*curr;
+	struct task_struct __rcu	*curr;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-- 
2.17.1

