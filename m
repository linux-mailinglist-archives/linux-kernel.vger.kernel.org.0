Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF73D8013
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389714AbfJOTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:21:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45632 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389343AbfJOTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:38 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL5-00067i-M3; Tue, 15 Oct 2019 21:18:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Michal Simek <monstr@monstr.eu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/34] microblaze: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:58 +0200
Message-Id: <20191015191821.11479-12-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/microblaze/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 4e1b567becd6a..253f2b702b4c0 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -728,7 +728,7 @@ irq_call:rtbd	r0, do_IRQ;
 	bri	6f;
 /* MS: Return to kernel state. */
 2:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	lwi	r11, CURRENT_TASK, TS_THREAD_INFO;
 	/* MS: get preempt_count from thread info */
 	lwi	r5, r11, TI_PREEMPT_COUNT;
--=20
2.23.0

