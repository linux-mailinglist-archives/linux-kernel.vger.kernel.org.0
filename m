Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F990E2ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409107AbfJXK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 06:28:08 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43874 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393291AbfJXK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:28:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tg31GPL_1571912867;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0Tg31GPL_1571912867)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 18:27:49 +0800
From:   Shannon Zhao <shannon.zhao@linux.alibaba.com>
To:     kvmarm@lists.cs.columbia.edu, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, christoffer.dall@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 3/7] KVM: vgic: make vgic parameters work well for module
Date:   Thu, 24 Oct 2019 18:27:46 +0800
Message-Id: <1571912870-18471-4-git-send-email-shannon.zhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
References: <1571912870-18471-1-git-send-email-shannon.zhao@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 8d69f00..228cfeb 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -548,6 +548,12 @@ int vgic_v3_map_resources(struct kvm *kvm)
 
 DEFINE_STATIC_KEY_FALSE(vgic_v3_cpuif_trap);
 
+#ifdef MODULE
+module_param_named(vgic_v3_group0_trap, group0_trap, bool, S_IRUGO);
+module_param_named(vgic_v3_group1_trap, group1_trap, bool, S_IRUGO);
+module_param_named(vgic_v3_common_trap, common_trap, bool, S_IRUGO);
+module_param_named(vgic_v4_enable, gicv4_enable, bool, S_IRUGO);
+#else
 static int __init early_group0_trap_cfg(char *buf)
 {
 	return strtobool(buf, &group0_trap);
@@ -571,6 +577,7 @@ static int __init early_gicv4_enable(char *buf)
 	return strtobool(buf, &gicv4_enable);
 }
 early_param("kvm-arm.vgic_v4_enable", early_gicv4_enable);
+#endif
 
 /**
  * vgic_v3_probe - probe for a VGICv3 compatible interrupt controller
-- 
1.8.3.1

