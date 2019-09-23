Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4884BBB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 20:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502276AbfIWS1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 14:27:03 -0400
Received: from foss.arm.com ([217.140.110.172]:46788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502244AbfIWS1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BD45168F;
        Mon, 23 Sep 2019 11:27:01 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84ABA3F694;
        Mon, 23 Sep 2019 11:26:57 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 09/35] irqchip/gic-v3-its: Add get_vlpi_map() helper
Date:   Mon, 23 Sep 2019 19:25:40 +0100
Message-Id: <20190923182606.32100-10-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obtaining the mapping information for a VLPI is something quite common,
and the GICv4.1 code is going to make even more use of it. Expose it as
a separate helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fbe7b0c14b9e..9bad3887f6ce 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1054,20 +1054,26 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
 /*
  * irqchip functions - assumes MSI, mostly.
  */
+static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	u32 event = its_get_event_id(d);
+
+	if (!irqd_is_forwarded_to_vcpu(d))
+		return NULL;
+
+	return &its_dev->event_map.vlpi_maps[event];
+}
 
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	irq_hw_number_t hwirq;
 	void *va;
 	u8 *cfg;
 
-	if (irqd_is_forwarded_to_vcpu(d)) {
-		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-		u32 event = its_get_event_id(d);
-		struct its_vlpi_map *map;
-
-		va = page_address(its_dev->event_map.vm->vprop_page);
-		map = &its_dev->event_map.vlpi_maps[event];
+	if (map) {
+		va = page_address(map->vm->vprop_page);
 		hwirq = map->vintid;
 
 		/* Remember the updated property */
@@ -1360,19 +1366,18 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	int ret = 0;
 
 	mutex_lock(&its_dev->event_map.vlpi_lock);
 
-	if (!its_dev->event_map.vm ||
-	    !its_dev->event_map.vlpi_maps[event].vm) {
+	if (!its_dev->event_map.vm || !map->vm) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* Copy our mapping information to the incoming request */
-	*info->map = its_dev->event_map.vlpi_maps[event];
+	*info->map = *map;
 
 out:
 	mutex_unlock(&its_dev->event_map.vlpi_lock);
-- 
2.20.1

