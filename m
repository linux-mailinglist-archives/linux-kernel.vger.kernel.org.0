Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E45991C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfF1LVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 07:21:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF1LVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:21:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgows-00021v-35; Fri, 28 Jun 2019 13:21:46 +0200
Message-Id: <20190628111440.189241552@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 13:11:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [patch V2 2/6] genirq: Fix misleading synchronize_irq() documentation
References: <20190628111148.828731433@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function might sleep, so it cannot be called from interrupt
context. Not even with care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/manage.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -96,7 +96,8 @@ EXPORT_SYMBOL(synchronize_hardirq);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
  */
 void synchronize_irq(unsigned int irq)
 {


