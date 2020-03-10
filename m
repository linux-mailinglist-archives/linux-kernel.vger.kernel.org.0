Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE4180324
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 17:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCJQXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 12:23:36 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50224 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbgCJQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:23:36 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 20512003-1500050 
        for multiple; Tue, 10 Mar 2020 16:23:20 +0000
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Mark up unlocked access to wq->first_flusher
Date:   Tue, 10 Mar 2020 16:23:19 +0000
Message-Id: <20200310162319.10138-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ 7329.671518] BUG: KCSAN: data-race in flush_workqueue / flush_workqueue
[ 7329.671549]
[ 7329.671572] write to 0xffff8881f65fb250 of 8 bytes by task 37173 on cpu 2:
[ 7329.671607]  flush_workqueue+0x3bc/0x9b0 (kernel/workqueue.c:2844)
[ 7329.672527]
[ 7329.672540] read to 0xffff8881f65fb250 of 8 bytes by task 37175 on cpu 0:
[ 7329.672571]  flush_workqueue+0x28d/0x9b0 (kernel/workqueue.c:2835)

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 301db4406bc3..2dbf94c873d7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2832,7 +2832,7 @@ void flush_workqueue(struct workqueue_struct *wq)
 	 * First flushers are responsible for cascading flushes and
 	 * handling overflow.  Non-first flushers can simply return.
 	 */
-	if (wq->first_flusher != &this_flusher)
+	if (READ_ONCE(wq->first_flusher) != &this_flusher)
 		return;
 
 	mutex_lock(&wq->mutex);
@@ -2841,7 +2841,7 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (wq->first_flusher != &this_flusher)
 		goto out_unlock;
 
-	wq->first_flusher = NULL;
+	WRITE_ONCE(wq->first_flusher, NULL);
 
 	WARN_ON_ONCE(!list_empty(&this_flusher.list));
 	WARN_ON_ONCE(wq->flush_color != this_flusher.flush_color);
-- 
2.20.1

