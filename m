Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E05E636B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 15:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfJ0OqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 10:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfJ0OqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:46:14 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489A921D7F;
        Sun, 27 Oct 2019 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187573;
        bh=bweGBvr/zsul0PBw/CUXnoQwKxpUkbBX2bXnI2WiT6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDk1e6T2TaUYx96VA3aU1x69aKWDFf4Zx41KfJ33BKv29uzfisn9NYmEg2A7KZJyh
         loizo7D7LSTEaE1BP+9W//bNK5TSXUXof3+O1AZcBeUTgPlX5520narm/gXtLh6cbx
         pKlpEzft8VjQoV0BGmfQAZSOgWgOfmbHJSLnj+IU=
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
Subject: [PATCH v2 30/36] irqchip/gic-v4.1: Add VSGI allocation/teardown
Date:   Sun, 27 Oct 2019 14:42:28 +0000
Message-Id: <20191027144234.8395-31-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate per-VPE SGIs when initializing the GIC-specific part of the
VPE data structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v4.c       | 68 +++++++++++++++++++++++++++++-
 include/linux/irqchip/arm-gic-v4.h |  2 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 60b51d6683aa..a29a063861bc 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -92,6 +92,47 @@ static bool has_v4_1(void)
 	return !!sgi_domain_ops;
 }
 
+static int its_alloc_vcpu_sgis(struct its_vpe *vpe, int idx)
+{
+	char *name;
+	int sgi_base;
+
+	if (!has_v4_1())
+		return 0;
+
+	name = kasprintf(GFP_KERNEL, "GICv4-sgi-%d", task_pid_nr(current));
+	if (!name)
+		goto err;
+
+	vpe->fwnode = irq_domain_alloc_named_id_fwnode(name, idx);
+	if (!vpe->fwnode)
+		goto err;
+
+	kfree(name);
+	name = NULL;
+
+	vpe->sgi_domain = irq_domain_create_linear(vpe->fwnode, 16,
+						   sgi_domain_ops, vpe);
+	if (!vpe->sgi_domain)
+		goto err;
+
+	sgi_base = __irq_domain_alloc_irqs(vpe->sgi_domain, -1, 16,
+					       NUMA_NO_NODE, vpe,
+					       false, NULL);
+	if (sgi_base <= 0)
+		goto err;
+
+	return 0;
+
+err:
+	if (vpe->sgi_domain)
+		irq_domain_remove(vpe->sgi_domain);
+	if (vpe->fwnode)
+		irq_domain_free_fwnode(vpe->fwnode);
+	kfree(name);
+	return -ENOMEM;
+}
+
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
 	int vpe_base_irq, i;
@@ -118,8 +159,13 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	if (vpe_base_irq <= 0)
 		goto err;
 
-	for (i = 0; i < vm->nr_vpes; i++)
+	for (i = 0; i < vm->nr_vpes; i++) {
+		int ret;
 		vm->vpes[i]->irq = vpe_base_irq + i;
+		ret = its_alloc_vcpu_sgis(vm->vpes[i], i);
+		if (ret)
+			goto err;
+	}
 
 	return 0;
 
@@ -132,8 +178,28 @@ int its_alloc_vcpu_irqs(struct its_vm *vm)
 	return -ENOMEM;
 }
 
+static void its_free_sgi_irqs(struct its_vm *vm)
+{
+	int i;
+
+	if (!has_v4_1())
+		return;
+
+	for (i = 0; i < vm->nr_vpes; i++) {
+		unsigned int irq = irq_find_mapping(vm->vpes[i]->sgi_domain, 0);
+
+		if (WARN_ON(!irq))
+			continue;
+
+		irq_domain_free_irqs(irq, 16);
+		irq_domain_remove(vm->vpes[i]->sgi_domain);
+		irq_domain_free_fwnode(vm->vpes[i]->fwnode);
+	}
+}
+
 void its_free_vcpu_irqs(struct its_vm *vm)
 {
+	its_free_sgi_irqs(vm);
 	irq_domain_free_irqs(vm->vpes[0]->irq, vm->nr_vpes);
 	irq_domain_remove(vm->domain);
 	irq_domain_free_fwnode(vm->fwnode);
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 084890a5c2bf..5578cbe7430b 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -47,6 +47,8 @@ struct its_vpe {
 		};
 		/* GICv4.1 implementations */
 		struct {
+			struct fwnode_handle	*fwnode;
+			struct irq_domain	*sgi_domain;
 			struct {
 				u8	priority;
 				bool	enabled;
-- 
2.20.1

