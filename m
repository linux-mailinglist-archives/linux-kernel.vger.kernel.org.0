Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABCCC9655
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 03:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJCBjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 21:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfJCBjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:39:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDA6222CC;
        Thu,  3 Oct 2019 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066747;
        bh=zQRLMMhHggox8g9yxGynM6uMIk2UKwfjbpNUD5J5KZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mjcv7tTtNDAFN8lFN0l1E0SbekHG0/7ZmQeUWPfFpMaySk40u9ZwufH4ln5g2d0q/
         KGKOs2Swplh9B3X1G9WZ8WMGUiNIs8Gvi0zgmyWaMJit5q9DcxiYMzLjVs/fNQ19sK
         Nwu5upRrXjn2jaraHAoErqMISjcCqVme7ZbsEsy4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 07/12] stop_machine: Use {READ,WRITE)_ONCE() for multi_cpu_stop() ->state
Date:   Wed,  2 Oct 2019 18:38:58 -0700
Message-Id: <20191003013903.13079-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013834.GA12927@paulmck-ThinkPad-P72>
References: <20191003013834.GA12927@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The multi_stop_data structure's ->state field is updated and read
concurrently, so this commit replaces the current C-language accesses
with READ_ONCE() and WRITE_ONCE().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/stop_machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 34c4f11..c02c56e 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -167,7 +167,7 @@ static void set_state(struct multi_stop_data *msdata,
 	/* Reset ack counter. */
 	atomic_set(&msdata->thread_ack, msdata->num_threads);
 	smp_wmb();
-	msdata->state = newstate;
+	WRITE_ONCE(msdata->state, newstate);
 }
 
 /* Last one to ack a state moves to the next state. */
@@ -210,8 +210,8 @@ static int multi_cpu_stop(void *data)
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
 		stop_machine_yield(cpumask);
-		if (msdata->state != curstate) {
-			curstate = msdata->state;
+		if (READ_ONCE(msdata->state) != curstate) {
+			curstate = READ_ONCE(msdata->state);
 			switch (curstate) {
 			case MULTI_STOP_DISABLE_IRQ:
 				local_irq_disable();
-- 
2.9.5

