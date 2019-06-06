Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA9636D6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfFFHiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 03:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfFFHiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:38:16 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138492089E;
        Thu,  6 Jun 2019 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559806696;
        bh=c4RvbCOvzAZwo+JHxwzn6l9TERUZJXcjP8N8zi+spgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI3WcSBCqbnqEZawPZOnj8m2qZSaTZmcMlUZ93Ak87D4LT/w0hSxS68WrA7YGhF/d
         KNO4DzeBiwQWWRCcyQEJb7l6dK3dB//eZ/iCalmYW4gjFUug1NL5dbazzX8WvG8BJy
         22BQPRfJTGujsLm3sGy5oHY5bqNBblZhtwaqe7rE=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 3/3] irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler
Date:   Thu,  6 Jun 2019 15:37:33 +0800
Message-Id: <1559806653-11249-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559806653-11249-1-git-send-email-guoren@kernel.org>
References: <1559806653-11249-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

csky_mpintc_handler()
  ->handle_domain_irq()
    ->irq_exit()
      ->invoke_softirq()
        ->__do_softirq()
          ->local_irq_enable()

If new interrupt coming, it'll get into interrupt trap before return to
csky_mpintc_handler(). So there is no need loop in csky_mpintc_handler.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index 4457722..806ba0e 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -34,7 +34,6 @@ static void __iomem *INTCL_base;
 #define INTCL_PICTLR	0x0
 #define INTCL_CFGR	0x14
 #define INTCL_SIGR	0x60
-#define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
 #define INTCL_SENR	0xa0
 #define INTCL_CENR	0xa4
@@ -75,11 +74,8 @@ static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
-	do {
-		handle_domain_irq(root_domain,
-				  readl_relaxed(reg_base + INTCL_RDYIR),
-				  regs);
-	} while (readl_relaxed(reg_base + INTCL_HPPIR) & BIT(31));
+	handle_domain_irq(root_domain,
+		readl_relaxed(reg_base + INTCL_RDYIR), regs);
 }
 
 static void csky_mpintc_enable(struct irq_data *d)
-- 
2.7.4

