Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A461D7FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfJOTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:18:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389468AbfJOTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:51 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLF-00067i-SH; Tue, 15 Oct 2019 21:18:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 34/34] workqueue: Use PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:21 +0200
Message-Id: <20191015191821.11479-35-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Update the comment to use PREEMPTION because it is true for both
preemption models.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bc2e09a8ea61d..a668b2118539c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2285,7 +2285,7 @@ __acquires(&pool->lock)
 	}
=20
 	/*
-	 * The following prevents a kworker from hogging CPU on !PREEMPT
+	 * The following prevents a kworker from hogging CPU on !PREEMPTION
 	 * kernels, where a requeueing work item waiting for something to
 	 * happen could deadlock with stop_machine as such work item could
 	 * indefinitely requeue itself while all other CPUs are trapped in
--=20
2.23.0

