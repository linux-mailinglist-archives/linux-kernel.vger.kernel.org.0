Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13395114AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 03:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLFCI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 21:08:26 -0500
Received: from foss.arm.com ([217.140.110.172]:55216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFCI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:08:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4448A31B;
        Thu,  5 Dec 2019 18:08:20 -0800 (PST)
Received: from localhost.localdomain (unknown [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 834003F718;
        Thu,  5 Dec 2019 18:08:16 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] KVM: arm: remove excessive permission check in kvm_arch_prepare_memory_region
Date:   Fri,  6 Dec 2019 10:08:02 +0800
Message-Id: <20191206020802.196108-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kvm_arch_prepare_memory_region, arm kvm regards the memory region as
writable if the flag has no KVM_MEM_READONLY, and the vm is readonly if
!VM_WRITE.

But there is common usage for setting kvm memory region as follows:
e.g. qemu side (see the PROT_NONE flag)
1. mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
   memory_region_init_ram_ptr()
2. re mmap the above area with read/write authority.

Such example is used in virtio-fs qemu codes which hasn't been upstreamed
[1]. But seems we can't forbid this example.

Without this patch, it will cause an EPERM during kvm_set_memory_region()
and cause qemu boot crash.

As told by Ard, "the underlying assumption is incorrect, i.e., that the
value of vm_flags at this point in time defines how the VMA is used
during its lifetime. There may be other cases where a VMA is created
with VM_READ vm_flags that are changed to VM_READ|VM_WRITE later, and
we are currently rejecting this use case as well."

[1] https://gitlab.com/virtio-fs/qemu/blob/5a356e/hw/virtio/vhost-user-fs.c#L488

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jia He <justin.he@arm.com>
---
 virt/kvm/arm/mmu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 38b4c910b6c3..a48994af70b8 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2301,15 +2301,6 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		if (!vma || vma->vm_start >= reg_end)
 			break;
 
-		/*
-		 * Mapping a read-only VMA is only allowed if the
-		 * memory region is configured as read-only.
-		 */
-		if (writable && !(vma->vm_flags & VM_WRITE)) {
-			ret = -EPERM;
-			break;
-		}
-
 		/*
 		 * Take the intersection of this VMA with the memory region
 		 */
-- 
2.17.1

