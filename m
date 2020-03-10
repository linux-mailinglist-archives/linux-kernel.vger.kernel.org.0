Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9A180761
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCJStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbgCJSta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E4121D7E;
        Tue, 10 Mar 2020 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866170;
        bh=4pO3JK2jXSScdbkZFncD1ql1G4cDVeObsH3uqQ8Prsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfs4Mn1Cv7DVPTxRwrWzfeq3oK1m/4rOktxSf0yyixzDaxdimT65u2SarH41xeGGA
         NKJYZ+XQgmwMC1W7sKfSNQDmu+9xgLF6SqXf9tC5LVkzyoyNcY91wOHP3FabfElCdP
         nSRzW8t3p9BTEtaMtp2MDdww7WQFjjAOUGHhzQdc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwW-00Bi6k-9i; Tue, 10 Mar 2020 18:49:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 1/4] irqchip/atmel-aic: Fix irq_retrigger callback return value
Date:   Tue, 10 Mar 2020 18:49:18 +0000
Message-Id: <20200310184921.23552-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310184921.23552-1-maz@kernel.org>
References: <20200310184921.23552-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, linux@arm.linux.org.uk, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_retrigger callback is supposed to return 0 when retrigger
has failed, and a non-zero value otherwise. Tell the core code
that the driver has succedded in using the HW to retrigger the
interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-atmel-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index bb1ad451392f..2c999dc310c1 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -83,7 +83,7 @@ static int aic_retrigger(struct irq_data *d)
 	irq_reg_writel(gc, d->mask, AT91_AIC_ISCR);
 	irq_gc_unlock(gc);
 
-	return 0;
+	return 1;
 }
 
 static int aic_set_type(struct irq_data *d, unsigned type)
-- 
2.20.1

