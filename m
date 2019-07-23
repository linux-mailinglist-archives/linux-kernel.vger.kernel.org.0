Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7374971670
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389229AbfGWKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733066AbfGWKoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C0F515BF;
        Tue, 23 Jul 2019 03:44:55 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32B3E3F71A;
        Tue, 23 Jul 2019 03:44:54 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] irqchip/gic-v3: Dynamically allocate PPI partition descriptors
Date:   Tue, 23 Jul 2019 11:44:35 +0100
Message-Id: <20190723104437.154403-8-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, PPIs are becoming a variable set. Let's hack the PPI partition
code to make the top-level array dynamically allocated.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ec0f885fa373..b85acab4a6a1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -52,7 +52,7 @@ struct gic_chip_data {
 	u64			flags;
 	bool			has_rss;
 	unsigned int		ppi_nr;
-	struct partition_desc	*ppi_descs[16];
+	struct partition_desc	**ppi_descs;
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -1350,7 +1350,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	 * then we need to match the partition domain.
 	 */
 	if (fwspec->param_count >= 4 &&
-	    fwspec->param[0] == 1 && fwspec->param[3] != 0)
+	    fwspec->param[0] == 1 && fwspec->param[3] != 0 &&
+	    gic_data.ppi_descs)
 		return d == partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
 
 	return d == gic_data.domain;
@@ -1371,6 +1372,9 @@ static int partition_domain_translate(struct irq_domain *d,
 	struct device_node *np;
 	int ret;
 
+	if (!gic_data.ppi_descs)
+		return -ENOMEM;
+
 	np = of_find_node_by_phandle(fwspec->param[3]);
 	if (WARN_ON(!np))
 		return -EINVAL;
@@ -1527,6 +1531,10 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	if (!parts_node)
 		return;
 
+	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
+	if (!gic_data.ppi_descs)
+		return;
+
 	nr_parts = of_get_child_count(parts_node);
 
 	if (!nr_parts)
@@ -1578,7 +1586,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		part_idx++;
 	}
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < gic_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;
 		struct irq_fwspec ppi_fwspec = {
-- 
2.20.1

