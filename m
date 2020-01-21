Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1060E143856
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAUIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:34:51 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45833 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgAUIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHW1uS_1579595687;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHW1uS_1579595687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:48 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rtmutex: remove unused cmpxchg_relaxed
Date:   Tue, 21 Jan 2020 16:34:46 +0800
Message-Id: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one use this macro after it was introduced. Better to remove it?

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Will Deacon <will@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/locking/rtmutex.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 851bbb10819d..a849964a348d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,7 +141,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
 
-- 
1.8.3.1

