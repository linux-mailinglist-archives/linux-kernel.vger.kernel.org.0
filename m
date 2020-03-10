Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D09180763
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgCJSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgCJStb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDF5222C4;
        Tue, 10 Mar 2020 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866171;
        bh=tw0gB/ovTVcwrhtwprojKzwKigF0zMWLOBTxhTgjsuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nDcTjMpNX02c3ckluYK+vNdLFT/Tl7iG4Z2tiCzUMyp16ctrkTgRf5C2IGs6TPnSI
         lEmhUSqmKR9t2oufMCrzHgH2FWJTe4j4rl3ROUyUfmgBpmTBx335O75xN8tFB/sOTC
         fHlOhxbEJ+cOagJXpGC0R+zkPUh/pmDAfdjlNa5w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwX-00Bi6k-G6; Tue, 10 Mar 2020 18:49:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 3/4] ARM: sa1111: Fix irq_retrigger callback return value
Date:   Tue, 10 Mar 2020 18:49:20 +0000
Message-Id: <20200310184921.23552-4-maz@kernel.org>
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
interrupt (if ever).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/common/sa1111.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 947ef7981d92..c98ebae1aeac 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -302,10 +302,13 @@ static int sa1111_retrigger_irq(struct irq_data *d)
 			break;
 	}
 
-	if (i == 8)
+	if (i == 8) {
 		pr_err("Danger Will Robinson: failed to re-trigger IRQ%d\n",
 		       d->irq);
-	return i == 8 ? -1 : 0;
+		return 0;
+	}
+
+	return 1;
 }
 
 static int sa1111_type_irq(struct irq_data *d, unsigned int flags)
-- 
2.20.1

