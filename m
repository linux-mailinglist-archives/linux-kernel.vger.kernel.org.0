Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F1D7FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbfJOTSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:18:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731857AbfJOTSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:36 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL3-00067i-Iw; Tue, 15 Oct 2019 21:18:33 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Guo Ren <guoren@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/34] csky: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:53 +0200
Message-Id: <20191015191821.11479-7-bigeasy@linutronix.de>
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

Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/csky/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a7a5b67df8989..0077063280000 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -277,7 +277,7 @@ ENTRY(csky_irq)
 	zero_fp
 	psrset	ee
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	mov	r9, sp			/* Get current stack  pointer */
 	bmaski	r10, THREAD_SHIFT
 	andn	r9, r10			/* Get thread_info */
@@ -294,7 +294,7 @@ ENTRY(csky_irq)
 	mov	a0, sp
 	jbsr	csky_do_IRQ
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	subi	r12, 1
 	stw	r12, (r9, TINFO_PREEMPT)
 	cmpnei	r12, 0
--=20
2.23.0

