Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF79D7FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbfJOTSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:18:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbfJOTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:43 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL7-00067i-2B; Tue, 15 Oct 2019 21:18:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 14/34] nios2: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:01 +0200
Message-Id: <20191015191821.11479-15-bigeasy@linutronix.de>
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

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/nios2/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 1e515ccd698e3..3d8d1d0bcb64b 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -365,7 +365,7 @@ ENTRY(ret_from_interrupt)
 	ldw	r1, PT_ESTATUS(sp)	/* check if returning to kernel */
 	TSTBNZ	r1, r1, ESTATUS_EU, Luser_return
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	GET_THREAD_INFO	r1
 	ldw	r4, TI_PREEMPT_COUNT(r1)
 	bne	r4, r0, restore_all
--=20
2.23.0

