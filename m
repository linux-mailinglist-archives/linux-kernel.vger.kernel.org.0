Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2CD800C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbfJOTVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:21:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45644 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389372AbfJOTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:40 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSL4-00067i-Dd; Tue, 15 Oct 2019 21:18:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/34] hexagon: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:17:55 +0200
Message-Id: <20191015191821.11479-9-bigeasy@linutronix.de>
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

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/hexagon/kernel/vm_entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/vm_entry.S b/arch/hexagon/kernel/vm_entry.S
index 12242c27e2df5..65a1ea0eed2fa 100644
--- a/arch/hexagon/kernel/vm_entry.S
+++ b/arch/hexagon/kernel/vm_entry.S
@@ -265,12 +265,12 @@
 	 * should be in the designated register (usually R19)
 	 *
 	 * If we were in kernel mode, we don't need to check scheduler
-	 * or signals if CONFIG_PREEMPT is not set.  If set, then it has
+	 * or signals if CONFIG_PREEMPTION is not set.  If set, then it has
 	 * to jump to a need_resched kind of block.
-	 * BTW, CONFIG_PREEMPT is not supported yet.
+	 * BTW, CONFIG_PREEMPTION is not supported yet.
 	 */
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	R0 =3D #VM_INT_DISABLE
 	trap1(#HVM_TRAP1_VMSETIE)
 #endif
--=20
2.23.0

