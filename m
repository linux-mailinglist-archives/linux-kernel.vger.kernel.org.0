Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08EF15DA75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBNPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 10:17:58 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58961 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729434AbgBNPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:17:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TpyfkW2_1581693462;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TpyfkW2_1581693462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 23:17:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] locking/rtmutex: optimize rt_mutex_cmpxchgs
Date:   Fri, 14 Feb 2020 23:17:19 +0800
Message-Id: <1581693439-33092-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581693439-33092-1-git-send-email-alex.shi@linux.alibaba.com>
References: <87c1cdbc-6af0-3f56-e986-b9df894fe4da@linux.alibaba.com>
 <1581693439-33092-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking l->owner first to skip time cost cmpxchgs.

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/locking/rtmutex.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7ad22eade1cc..e8df466af8ab 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,8 +141,10 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
+# define rt_mutex_cmpxchg_acquire(l, c, n)	\
+			(l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
+# define rt_mutex_cmpxchg_release(l, c, n)	\
+			(l->owner == c && cmpxchg_release(&l->owner, c, n) == c)
 
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we force
-- 
1.8.3.1

