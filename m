Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87181E9542
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 04:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfJ3DYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 23:24:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45620 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfJ3DYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:24:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id y24so286084plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=El42Y0XtiI+o9O978XwDgCnNFlXF0pvLOTIJT8A8LpQ=;
        b=PPnotDkw8xhuli7tHUxeUaV7VDi30OZQZ0OQXY3L9YmBxe3Z8KR+LIWeIR/kEg2iS6
         J/BYzmyEJMB8ARXgD6iCkCz2VzEEqHM4oGEtN0awcB/b2CAt3w4J44I6Nf7TUfZzukjt
         GTJnO/GSZosf7gyQo11LY1FU65qYdqbdcwyJERHrLYwpt63n5r66JCPIg7EPB+iKeNSH
         fp1pkK+g9u+p/exBl0e3pJv7CR00TrPfrfLJG/kWdGnAK3+YcC6NWIC7CKcdk2RKrkSz
         +eTg0qI9L9EG8jft/+4A8aKk7kmRaM449mynTHKQ/A5/sbf8ehnSN+aSM8MLVJeZAX4c
         Owxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=El42Y0XtiI+o9O978XwDgCnNFlXF0pvLOTIJT8A8LpQ=;
        b=r60ZG5yMnimO2ed/eKpTTFq7gHWLqITdHbndfb8e4XvIREkPwnrJ4mi7XzCKBx/3nY
         nOE8NP8INTFpqu33/FljO+pwPft7Jqdc6alpcA0JGO1PQ77CN3AdGn42QSl5pPR6qR4Z
         8EaU/1k0dCjpj275zo4OjidIqTdFxQGcaaJ+zp0xCOLyLL7meB6Mh/XOaLeYU/wA5WOa
         wIyGIC8p0sMMlXjLoDp6+7Rlkh5D9Gqv+54mRJyW1aKqn8USro+IGMS7M1IoVcsSb7vz
         6LCxyR+SDPsQBR+1C0pO4vzDbujLKAzTXG+EOjb9Y8/lhw+7TTiRosmQLcjcz5WrdoM0
         Cezw==
X-Gm-Message-State: APjAAAXdZdTCCQxMvWnYqcXlbXmN724h+pl56+5y8uykSBJGJm6XiyeM
        roisF8VwagZFjivHOVhkpG4iDuiddes=
X-Google-Smtp-Source: APXvYqwfAecs0cQjB3BULuTSJfaphx+9J4Y0vW2E1krxC0eROt5aGr7rzl7CU7+eJXQwzN7Y1WCmCQ==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr2203329plr.24.1572405841058;
        Tue, 29 Oct 2019 20:24:01 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-103-217.windriver.com. [147.11.103.217])
        by smtp.gmail.com with ESMTPSA id j22sm556020pff.42.2019.10.29.20.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 20:24:00 -0700 (PDT)
From:   Kevin Hao <haokexin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] dump_stack: Avoid the livelock of the dump_lock
Date:   Wed, 30 Oct 2019 11:16:37 +0800
Message-Id: <20191030031637.6025-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, we use the atomic_cmpxchg() to serialize the
output of the dump_stack(), but this implementation suffers the
thundering herd problem. We have observed such kind of livelock on a
Marvell cn96xx board(24 cpus) when heavily using the dump_stack() in
a kprobe handler. Actually we can let the competitors to wait for
the releasing of the lock before jumping to atomic_cmpxchg(). This
will definitely mitigate the thundering herd problem. Thanks Linus
for the suggestion.

Fixes: b58d977432c8 ("dump_stack: serialize the output from dump_stack()")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
 1. Use the method suggested by Linus.
 2. Since this fix seems pretty simple, maybe it deserve to be
    backported to stable kernel. So CC the stable.

 lib/dump_stack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..0062dfcafd63 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -106,7 +106,11 @@ asmlinkage __visible void dump_stack(void)
 		was_locked = 1;
 	} else {
 		local_irq_restore(flags);
-		cpu_relax();
+		/*
+		 * Wait the lock to release before jumping to atomic_cmpxchg()
+		 * in order to mitigate the thundering herd problem.
+		 */
+		do { cpu_relax(); } while (atomic_read(&dump_lock) != -1);
 		goto retry;
 	}
 
-- 
2.14.4

