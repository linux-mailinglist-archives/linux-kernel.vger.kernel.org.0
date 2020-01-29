Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD59B14D05C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgA2SUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 13:20:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgA2SUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:20:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97357B2A4;
        Wed, 29 Jan 2020 18:20:46 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] bluetooth: optimize barrier usage for Rmw atomics
Date:   Wed, 29 Jan 2020 10:10:41 -0800
Message-Id: <20200129181041.24853-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use smp_mb__before_atomic() instead of smp_mb() and avoid the
unnecessary barrier for non LL/SC architectures, such as x86.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index bef84b95e2c4..3b4fa27a44e6 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -1279,7 +1279,7 @@ static int hidp_session_thread(void *arg)
 	add_wait_queue(sk_sleep(session->intr_sock->sk), &intr_wait);
 	/* This memory barrier is paired with wq_has_sleeper(). See
 	 * sock_poll_wait() for more information why this is needed. */
-	smp_mb();
+	smp_mb__before_atomic();
 
 	/* notify synchronous startup that we're ready */
 	atomic_inc(&session->state);
-- 
2.16.4

