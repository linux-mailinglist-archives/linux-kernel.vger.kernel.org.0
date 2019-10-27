Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87963E6374
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfJ0Oqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 10:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbfJ0Oqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:46:43 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961B921D80;
        Sun, 27 Oct 2019 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187602;
        bh=rT1g/raMHC8EmgZx/1zwUJDNQKU4ZVLYts5C3N9/83M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQhwT4AR7f2090hNfLKqJlUsiIsfpQRCd40xkcZSaB3bJBV427cJtyNquoOKaxEzq
         hFsLf+UcVT+psA3ZsmE0Ppm2qHRfDqPmoOMHiWju6v015jraLjA/5X1mnbO1M3i45S
         ZLttOiS719NNFRPABihNMM8x+WjH2IEmEMu+Ja6I=
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
Subject: [PATCH v2 35/36] KVM: arm64: GICv4.1: Configure SGIs as HW interrupts
Date:   Sun, 27 Oct 2019 14:42:33 +0000
Message-Id: <20191027144234.8395-36-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable HW delivery of SGIs, set their hw flag to true, link them
to the corresponding Linux interrupt, which is then activated.

This configures the SGIs at the ITS level, and put the show
on the road!

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-v4.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index e61c7a149515..0ff6dac16cba 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -97,6 +97,46 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	return IRQ_HANDLED;
 }
 
+static void vgic_v4_sync_sgi_config(struct its_vpe *vpe, struct vgic_irq *irq)
+{
+	vpe->sgi_config[irq->intid].enabled	= irq->enabled;
+	vpe->sgi_config[irq->intid].group 	= irq->group;
+	vpe->sgi_config[irq->intid].priority	= irq->priority;
+}
+
+static void vgic_v4_init_vsgis(struct kvm_vcpu *vcpu)
+{
+	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+	int i;
+
+	if (!kvm_vgic_global_state.has_gicv4_1)
+		return;
+
+	/*
+	 * With GICv4.1, every virtual SGI can be directly injected. So
+	 * let's pretend that they are HW interrupts, tied to a host
+	 * IRQ. The SGI code will do its magic.
+	 */
+	for (i = 0; i < VGIC_NR_SGIS; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
+		struct irq_desc *desc;
+		int ret;
+
+		irq->hw = true;
+		irq->host_irq = irq_find_mapping(vpe->sgi_domain, i);
+		vgic_v4_sync_sgi_config(vpe, irq);
+		/*
+		 * SGIs are initialised as disabled. Enable them if
+		 * required by the rest of the VGIC init code.
+		 */
+		desc = irq_to_desc(irq->host_irq);
+		ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
+					      false);
+		WARN_ON(ret);
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+}
+
 /**
  * vgic_v4_init - Initialize the GICv4 data structures
  * @kvm:	Pointer to the VM being initialized
@@ -168,6 +208,8 @@ int vgic_v4_init(struct kvm *kvm)
 			dist->its_vm.nr_vpes = i;
 			break;
 		}
+
+		vgic_v4_init_vsgis(vcpu);
 	}
 
 	if (ret)
-- 
2.20.1

