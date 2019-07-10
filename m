Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688CC63E94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 02:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfGJAWz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Jul 2019 20:22:55 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:8170 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGJAWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 20:22:54 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id D0A33B63676A81C54DA0;
        Wed, 10 Jul 2019 08:22:51 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6A0Mag1034399;
        Wed, 10 Jul 2019 08:22:36 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071008225384-2222331 ;
          Wed, 10 Jul 2019 08:22:53 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH v2] kvm: x86: Fix -Wmissing-prototypes warnings
Date:   Wed, 10 Jul 2019 08:20:50 +0800
Message-Id: <1562718050-45669-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-10 08:22:53,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-10 08:22:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x6A0Mag1034399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when build kernel W=1:

arch/x86/kvm/../../../virt/kvm/eventfd.c:48:1: warning: no previous prototype for ‘kvm_arch_irqfd_allowed’ [-Wmissing-prototypes]
 kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
 ^

The reason is kvm_arch_irqfd_allowed() is declared in arch/x86/kvm/irq.h,
which is not included by eventfd.c. Considering kvm_arch_irqfd_allowed()
is a weakly defined function in eventfd.c, remove the declaration to
kvm_host.h can fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
v2: add comments about the reason.
---
 arch/x86/kvm/irq.h       | 1 -
 include/linux/kvm_host.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index d6519a3..7c6233d 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -102,7 +102,6 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 	return mode != KVM_IRQCHIP_NONE;
 }
 
-bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_apic_nmi_wd_deliver(struct kvm_vcpu *vcpu);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d1ad38a..5f04005 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -990,6 +990,7 @@ void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian);
 int kvm_request_irq_source_id(struct kvm *kvm);
 void kvm_free_irq_source_id(struct kvm *kvm, int irq_source_id);
+bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args);
 
 /*
  * search_memslots() and __gfn_to_memslot() are here because they are
-- 
1.8.3.1

