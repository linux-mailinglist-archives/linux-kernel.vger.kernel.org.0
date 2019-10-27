Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64E8E6364
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfJ0OqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 10:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfJ0OqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:46:02 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 412D821850;
        Sun, 27 Oct 2019 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187561;
        bh=QqBkOBNIjEQibOWEUB5mjhbEHtaLh+Iis5MerWZP6so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNq7KNghIOwe7aCG/obAybLuPLgyykw8l1cn0DLS+0u5sLu3Ge8vhvC7XwApDntPs
         ddU4JUwozIWZkQXhC5008NU5Q5pPIgAIYzJ1zSMkP6Vecbm13SawOhqXUvMKaNdZ2f
         GchnCghwN5PwxknnBCk4VDyDJjdwWqRlHVRAAbUg=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 28/36] irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI callbacks
Date:   Sun, 27 Oct 2019 14:42:26 +0000
Message-Id: <20191027144234.8395-29-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for VLPIs, there is a number of configuration bits that cannot
be directly communicated through the normal irqchip API, and we
have to use our good old friend set_vcpu_affinity.

This is used to configure group and priority for a given vSGI.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 58dd497dc274..03ba4964a7f5 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3744,6 +3744,23 @@ static int its_sgi_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_sgi_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
+	struct its_cmd_info *info = vcpu_info;
+
+	switch (info->cmd_type) {
+	case PROP_UPDATE_SGI:
+		vpe->sgi_config[d->hwirq].priority = info->priority;
+		vpe->sgi_config[d->hwirq].group = info->group;
+		its_configure_sgi(d, false);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct irq_chip its_sgi_irq_chip = {
 	.name			= "GICv4.1-sgi",
 	.irq_mask		= its_sgi_mask_irq,
@@ -3751,6 +3768,7 @@ static struct irq_chip its_sgi_irq_chip = {
 	.irq_set_affinity	= its_sgi_set_affinity,
 	.irq_set_irqchip_state	= its_sgi_set_irqchip_state,
 	.irq_get_irqchip_state	= its_sgi_get_irqchip_state,
+	.irq_set_vcpu_affinity	= its_sgi_set_vcpu_affinity,
 };
 
 static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 03bbd0aed2e2..6185926e4582 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -96,6 +96,7 @@ enum its_vcpu_info_cmd_type {
 	SCHEDULE_VPE,
 	DESCHEDULE_VPE,
 	INVALL_VPE,
+	PROP_UPDATE_SGI,
 };
 
 struct its_cmd_info {
@@ -108,6 +109,10 @@ struct its_cmd_info {
 			bool		g0en;
 			bool		g1en;
 		};
+		struct {
+			u8		priority;
+			bool		group;
+		};
 	};
 };
 
-- 
2.20.1

