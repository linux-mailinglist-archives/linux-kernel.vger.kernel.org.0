Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6683486
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfHFO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 10:57:36 -0400
Received: from foss.arm.com ([217.140.110.172]:34714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733146AbfHFO5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3822F15AB;
        Tue,  6 Aug 2019 07:57:33 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F483F706;
        Tue,  6 Aug 2019 07:57:31 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] irqchip/gic: Register the distributor's PA instead of its VA in fwnode
Date:   Tue,  6 Aug 2019 15:57:11 +0100
Message-Id: <20190806145716.125421-4-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806145716.125421-1-maz@kernel.org>
References: <20190806145716.125421-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose the distributor's VA (it appears in debugfs). Instead,
record the PA, which at least can be used to precisely identify
the associated irqchip and domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e45f45e68720..b6b857377763 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1627,7 +1627,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	domain_handle = irq_domain_alloc_fwnode(gic->raw_dist_base);
+	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		gic_teardown(gic);
-- 
2.20.1

