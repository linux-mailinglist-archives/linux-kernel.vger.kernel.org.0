Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9169F687C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2019 11:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfKJKYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Nov 2019 05:24:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54400 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfKJKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 05:24:03 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTkO1-0004XX-8g; Sun, 10 Nov 2019 11:24:01 +0100
Date:   Sun, 10 Nov 2019 10:21:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.4-rc7
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
Message-ID: <157338131324.14789.9839203234808482110.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  0ed9ca25894e: irq/irqdomain: Update __irq_domain_alloc_fwnode() function documentation

A trivial fix for a kernel doc regression where an argument change was not
reflected in the documentation.

Thanks,

	tglx

------------------>
Yi Wang (1):
      irq/irqdomain: Update __irq_domain_alloc_fwnode() function documentation


 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 132672b74e4b..dd822fd8a7d5 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * @type:	Type of irqchip_fwnode. See linux/irqdomain.h
  * @name:	Optional user provided domain name
  * @id:		Optional user provided id if name != NULL
- * @data:	Optional user-provided data
+ * @pa:		Optional user-provided physical address
  *
  * Allocate a struct irqchip_fwid, and return a poiner to the embedded
  * fwnode_handle (or NULL on failure).


