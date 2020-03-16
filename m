Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E4186801
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgCPJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 05:39:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:24746 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbgCPJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1584351565; x=1615887565;
  h=from:to:cc:subject:date:message-id;
  bh=qSfJ6u84LZu6czX0X2ef4AdDkN6oHZIFm1K2WciznEs=;
  b=pPkee8hrRNrrAAYAl6xVYc1cCKytTUJJG71Vsp4oy8uAMXlbh/Mo+eY4
   EaYpKqn0dOjPbBhepg9S2rzoNgRzB8MAP/7RPIgi74gjdsY2NlGoHilzc
   OOQwJCad2XFEcJiVYwqQFebqstxgKxPlEzVkoACvsExtpXZP4DHXJpnnh
   8=;
IronPort-SDR: xsYhxKPGjqk2aAysy+zQY9HiQRGEhcQrSC6cz8QMXDMAK4Bl9ABga5RZJdQs+98Mauhlz0Fl+1
 EnHgnQILdeOw==
X-IronPort-AV: E=Sophos;i="5.70,559,1574121600"; 
   d="scan'208";a="31381162"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 16 Mar 2020 09:39:23 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id F1E8DA175E;
        Mon, 16 Mar 2020 09:39:21 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 02G9dI8G005147;
        Mon, 16 Mar 2020 10:39:18 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id 02G9dHYs005143;
        Mon, 16 Mar 2020 10:39:17 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
Date:   Mon, 16 Mar 2020 10:39:06 +0100
Message-Id: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the physical timer object when reading the physical timer counter
instead of using the virtual timer object. This is only visible when
reading it from user-space as kvm_arm_timer_get_reg() is only executed on
the get register patch from user-space.

Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 virt/kvm/arm/arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 0d9438e..93bd59b 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -788,7 +788,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
 					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
 	case KVM_REG_ARM_PTIMER_CNT:
 		return kvm_arm_timer_read(vcpu,
-					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
+					  vcpu_ptimer(vcpu), TIMER_REG_CNT);
 	case KVM_REG_ARM_PTIMER_CVAL:
 		return kvm_arm_timer_read(vcpu,
 					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
-- 
2.7.4

