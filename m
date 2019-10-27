Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF9E6377
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 15:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfJ0Oqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 10:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbfJ0Oqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:46:49 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C805214AF;
        Sun, 27 Oct 2019 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187608;
        bh=pp8mEgomz0M/3Mf8slxkJgXWUFwfKKHtSYQ1KzRKA6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBhhm3h/XE4J3cnUJr7pE+fWIbdhvo4F5nJWn71/TxZizW3wQGEAtCS1iUPDNY6Jd
         LCZlkagoWh87hwoViVTP9V+qVVvpDslC2AsKf/XhlI3qpL5VpXZKLKfZ8ANLjNlmZi
         mfSCnruSN2kVJfwaUI4AQrCjMRkvzd5J2VAu6S+A=
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
Subject: [PATCH v2 36/36] KVM: arm64: GICv4.1: Expose HW-based SGIs in debugfs
Date:   Sun, 27 Oct 2019 14:42:34 +0000
Message-Id: <20191027144234.8395-37-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vgic-state debugfs file could do with showing the pending state
of the HW-backed SGIs. Plug it into the low-level code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-debug.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-debug.c b/virt/kvm/arm/vgic/vgic-debug.c
index cc12fe9b2df3..98f3242a34a6 100644
--- a/virt/kvm/arm/vgic/vgic-debug.c
+++ b/virt/kvm/arm/vgic/vgic-debug.c
@@ -178,6 +178,8 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 			    struct kvm_vcpu *vcpu)
 {
 	char *type;
+	bool pending;
+
 	if (irq->intid < VGIC_NR_SGIS)
 		type = "SGI";
 	else if (irq->intid < VGIC_NR_PRIVATE_IRQS)
@@ -190,6 +192,16 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 	if (irq->intid ==0 || irq->intid == VGIC_NR_PRIVATE_IRQS)
 		print_header(s, irq, vcpu);
 
+	pending = irq->pending_latch;
+	if (irq->hw && vgic_irq_is_sgi(irq->intid)) {
+		int err;
+
+		err = irq_get_irqchip_state(irq->host_irq,
+					    IRQCHIP_STATE_PENDING,
+					    &pending);
+		WARN_ON_ONCE(err);
+	}
+		
 	seq_printf(s, "       %s %4d "
 		      "    %2d "
 		      "%d%d%d%d%d%d%d "
@@ -201,7 +213,7 @@ static void print_irq_state(struct seq_file *s, struct vgic_irq *irq,
 		      "\n",
 			type, irq->intid,
 			(irq->target_vcpu) ? irq->target_vcpu->vcpu_id : -1,
-			irq->pending_latch,
+		   	pending,
 			irq->line_level,
 			irq->active,
 			irq->enabled,
-- 
2.20.1

