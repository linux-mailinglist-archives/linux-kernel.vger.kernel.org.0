Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EF90578
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfHPQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:09:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHPQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:09:29 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyen9-0004Lu-Jn; Fri, 16 Aug 2019 18:09:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] genirq: Force interrupt thread on RT
Date:   Fri, 16 Aug 2019 18:09:23 +0200
Message-Id: <20190816160923.12855-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Force threaded_irqs and optimize the code (force_irqthreads) in regard
to this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h |    4 ++++
 kernel/irq/manage.c       |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -473,7 +473,11 @@ extern int irq_set_irqchip_state(unsigne
 				 bool state);
=20
 #ifdef CONFIG_IRQ_FORCED_THREADING
+# ifdef CONFIG_PREEMPT_RT
+#  define force_irqthreads	(true)
+# else
 extern bool force_irqthreads;
+# endif
 #else
 #define force_irqthreads	(0)
 #endif
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -23,7 +23,7 @@
=20
 #include "internals.h"
=20
-#ifdef CONFIG_IRQ_FORCED_THREADING
+#if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
 __read_mostly bool force_irqthreads;
 EXPORT_SYMBOL_GPL(force_irqthreads);
=20
