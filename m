Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1E199E82
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgCaTA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:00:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgCaTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3MwMaAcbeVrTpYtUDAY4tu26s2H/OuHsu7M7PH3POY=;
        b=I8kpr+Rj62cFWzIHrRBxueQjBQsUQQsrUgXo24GGWseJv4rEZPJuZdzPEok5w7QI9aVg3L
        YENEcA97EzdAoaejQ8zJptLbrTpz+upulPXVHhcNaKywWOrA0JqUDHP0/V+htFCY/OFNQZ
        uTLtynHLAnPptsHVnfjfCoakm+qcQ7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-0opyHBPYNoWRq-YvtyT8Ag-1; Tue, 31 Mar 2020 15:00:24 -0400
X-MC-Unique: 0opyHBPYNoWRq-YvtyT8Ag-1
Received: by mail-wr1-f71.google.com with SMTP id e10so13366270wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3MwMaAcbeVrTpYtUDAY4tu26s2H/OuHsu7M7PH3POY=;
        b=GRn7L0eESfVhiM8cKchMIpHVmDcf8UqNibuWmUGQlsdT0vTT6X1Wc57lML7Nb/bfRd
         ewWV6eJx1zgD36gjQndDD53b9VFb1FamaXxtNYZ7blF02gbcDPqIkdsBUogzaXj9n8q+
         YIhdDiURB825Clw1QtjzZohPqdoivbskdFpMU6PAdHjm7acNzL30u0U3FGmh0iNMIPmz
         APmN6Ut3DzyyMdhktDYPwamtfKb+n3MQP2pdcZdWwgfBpLxjz+2IYkD5lopvLcSoPYLi
         PIhZg8pUhN8OKWY0T8SSzYcMdX6Y7pz4QAKxkQCRj83XkcSr7jXEmnVaWAqxYy3SO6Q/
         dpNQ==
X-Gm-Message-State: ANhLgQ3BnZbD1X2uRDlY81r2kQio3OiQIDsuu7wgdGzBvYzQbrCvxfDh
        zo1+92OzhJCMP9fBqaf1vr7Le6zxH0E1KfguUV0u6/28gTKuVZ3lIXP0nxO9mvoU1T0ROXapMpn
        RjZR4eE7Kw0V9g0P0RWr2JI8b
X-Received: by 2002:adf:fc08:: with SMTP id i8mr22270018wrr.109.1585681222958;
        Tue, 31 Mar 2020 12:00:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGQ4owG0ZJqRauYX4MBPuawFfENn9lwauZfu79U6X8338lkJyQA34TvhNt/oX8GDgLmQExow==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr22269995wrr.109.1585681222660;
        Tue, 31 Mar 2020 12:00:22 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r15sm29479563wra.19.2020.03.31.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v8 03/14] KVM: X86: Don't track dirty for KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Date:   Tue, 31 Mar 2020 14:59:49 -0400
Message-Id: <20200331190000.659614-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, we have three code paths that can dirty a page without
vcpu context for X86:

  - init_rmode_identity_map
  - init_rmode_tss
  - kvmgt_rw_gpa

init_rmode_identity_map and init_rmode_tss will be setup on
destination VM no matter what (and the guest cannot even see them), so
it does not make sense to track them at all.

To do this, allow __x86_set_memory_region() to return the userspace
address that just allocated to the caller.  Then in both of the
functions we directly write to the userspace address instead of
calling kvm_write_*() APIs.

Another trivial change is that we don't need to explicitly clear the
identity page table root in init_rmode_identity_map() because no
matter what we'll write to the whole page with 4M huge page entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +-
 arch/x86/kvm/svm.c              |  9 ++--
 arch/x86/kvm/vmx/vmx.c          | 82 ++++++++++++++++-----------------
 arch/x86/kvm/x86.c              | 39 +++++++++++++---
 4 files changed, 81 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9a183e9d4cb1..a8c68f626fb5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1645,7 +1645,8 @@ void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu);
 
 int kvm_is_in_guest(void);
 
-int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size);
+void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+				     u32 size);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 05cb45bc0e08..140bff1946b1 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1785,7 +1785,8 @@ static u64 *avic_get_physical_id_entry(struct kvm_vcpu *vcpu,
  */
 static int avic_update_access_page(struct kvm *kvm, bool activate)
 {
-	int ret = 0;
+	void __user *ret;
+	int r = 0;
 
 	mutex_lock(&kvm->slots_lock);
 	/*
@@ -1801,13 +1802,15 @@ static int avic_update_access_page(struct kvm *kvm, bool activate)
 				      APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
 				      APIC_DEFAULT_PHYS_BASE,
 				      activate ? PAGE_SIZE : 0);
-	if (ret)
+	if (IS_ERR(ret)) {
+		r = PTR_ERR(ret);
 		goto out;
+	}
 
 	kvm->arch.apic_access_page_done = activate;
 out:
 	mutex_unlock(&kvm->slots_lock);
-	return ret;
+	return r;
 }
 
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a7dd67859bd4..529b04ca0ac8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3432,34 +3432,26 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static int init_rmode_tss(struct kvm *kvm)
+static int init_rmode_tss(struct kvm *kvm, void __user *ua)
 {
-	gfn_t fn;
-	u16 data = 0;
-	int idx, r;
+	const void *zero_page = (const void *) __va(page_to_phys(ZERO_PAGE(0)));
+	u16 data;
+	int i, r;
+
+	for (i = 0; i < 3; i++) {
+		r = __copy_to_user(ua + PAGE_SIZE * i, zero_page, PAGE_SIZE);
+		if (r)
+			return -EFAULT;
+	}
 
-	idx = srcu_read_lock(&kvm->srcu);
-	fn = to_kvm_vmx(kvm)->tss_addr >> PAGE_SHIFT;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
 	data = TSS_BASE_SIZE + TSS_REDIRECTION_SIZE;
-	r = kvm_write_guest_page(kvm, fn++, &data,
-			TSS_IOPB_BASE_OFFSET, sizeof(u16));
-	if (r < 0)
-		goto out;
-	r = kvm_clear_guest_page(kvm, fn++, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
-	r = kvm_clear_guest_page(kvm, fn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
+	r = __copy_to_user(ua + TSS_IOPB_BASE_OFFSET, &data, sizeof(u16));
+	if (r)
+		return -EFAULT;
+
 	data = ~0;
-	r = kvm_write_guest_page(kvm, fn, &data,
-				 RMODE_TSS_SIZE - 2 * PAGE_SIZE - 1,
-				 sizeof(u8));
-out:
-	srcu_read_unlock(&kvm->srcu, idx);
+	r = __copy_to_user(ua + RMODE_TSS_SIZE - 1, &data, sizeof(u8));
+
 	return r;
 }
 
@@ -3468,6 +3460,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
 	int i, r = 0;
 	kvm_pfn_t identity_map_pfn;
+	void __user *uaddr;
 	u32 tmp;
 
 	/* Protect kvm_vmx->ept_identity_pagetable_done. */
@@ -3480,22 +3473,24 @@ static int init_rmode_identity_map(struct kvm *kvm)
 		kvm_vmx->ept_identity_map_addr = VMX_EPT_IDENTITY_PAGETABLE_ADDR;
 	identity_map_pfn = kvm_vmx->ept_identity_map_addr >> PAGE_SHIFT;
 
-	r = __x86_set_memory_region(kvm, IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
-				    kvm_vmx->ept_identity_map_addr, PAGE_SIZE);
-	if (r < 0)
+	uaddr = __x86_set_memory_region(kvm,
+					IDENTITY_PAGETABLE_PRIVATE_MEMSLOT,
+					kvm_vmx->ept_identity_map_addr,
+					PAGE_SIZE);
+	if (IS_ERR(uaddr)) {
+		r = PTR_ERR(uaddr);
 		goto out;
+	}
 
-	r = kvm_clear_guest_page(kvm, identity_map_pfn, 0, PAGE_SIZE);
-	if (r < 0)
-		goto out;
 	/* Set up identity-mapping pagetable for EPT in real mode */
 	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
-		r = kvm_write_guest_page(kvm, identity_map_pfn,
-				&tmp, i * sizeof(tmp), sizeof(tmp));
-		if (r < 0)
+		r = __copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp));
+		if (r) {
+			r = -EFAULT;
 			goto out;
+		}
 	}
 	kvm_vmx->ept_identity_pagetable_done = true;
 
@@ -3522,19 +3517,22 @@ static void seg_setup(int seg)
 static int alloc_apic_access_page(struct kvm *kvm)
 {
 	struct page *page;
-	int r = 0;
+	void __user *r;
+	int ret = 0;
 
 	mutex_lock(&kvm->slots_lock);
 	if (kvm->arch.apic_access_page_done)
 		goto out;
 	r = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT,
 				    APIC_DEFAULT_PHYS_BASE, PAGE_SIZE);
-	if (r)
+	if (IS_ERR(r)) {
+		ret = PTR_ERR(r);
 		goto out;
+	}
 
 	page = gfn_to_page(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
 	if (is_error_page(page)) {
-		r = -EFAULT;
+		ret = -EFAULT;
 		goto out;
 	}
 
@@ -3546,7 +3544,7 @@ static int alloc_apic_access_page(struct kvm *kvm)
 	kvm->arch.apic_access_page_done = true;
 out:
 	mutex_unlock(&kvm->slots_lock);
-	return r;
+	return ret;
 }
 
 int allocate_vpid(void)
@@ -4473,7 +4471,7 @@ static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
 
 static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 {
-	int ret;
+	void __user *ret;
 
 	if (enable_unrestricted_guest)
 		return 0;
@@ -4483,10 +4481,12 @@ static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
 				      PAGE_SIZE * 3);
 	mutex_unlock(&kvm->slots_lock);
 
-	if (ret)
-		return ret;
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
 	to_kvm_vmx(kvm)->tss_addr = addr;
-	return init_rmode_tss(kvm);
+
+	return init_rmode_tss(kvm, ret);
 }
 
 static int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b6d9ac9533c..faa702c4d37b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9791,7 +9791,32 @@ void kvm_arch_sync_events(struct kvm *kvm)
 	kvm_free_pit(kvm);
 }
 
-int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
+#define  ERR_PTR_USR(e)  ((void __user *)ERR_PTR(e))
+
+/**
+ * __x86_set_memory_region: Setup KVM internal memory slot
+ *
+ * @kvm: the kvm pointer to the VM.
+ * @id: the slot ID to setup.
+ * @gpa: the GPA to install the slot (unused when @size == 0).
+ * @size: the size of the slot. Set to zero to uninstall a slot.
+ *
+ * This function helps to setup a KVM internal memory slot.  Specify
+ * @size > 0 to install a new slot, while @size == 0 to uninstall a
+ * slot.  The return code can be one of the following:
+ *
+ *   HVA:           on success (uninstall will return a bogus HVA)
+ *   -errno:        on error
+ *
+ * The caller should always use IS_ERR() to check the return value
+ * before use.  Note, the KVM internal memory slots are guaranteed to
+ * remain valid and unchanged until the VM is destroyed, i.e., the
+ * GPA->HVA translation will not change.  However, the HVA is a user
+ * address, i.e. its accessibility is not guaranteed, and must be
+ * accessed via __copy_{to,from}_user().
+ */
+void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+				      u32 size)
 {
 	int i, r;
 	unsigned long hva, uninitialized_var(old_npages);
@@ -9800,12 +9825,12 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 
 	/* Called with kvm->slots_lock held.  */
 	if (WARN_ON(id >= KVM_MEM_SLOTS_NUM))
-		return -EINVAL;
+		return ERR_PTR_USR(-EINVAL);
 
 	slot = id_to_memslot(slots, id);
 	if (size) {
 		if (slot && slot->npages)
-			return -EEXIST;
+			return ERR_PTR_USR(-EEXIST);
 
 		/*
 		 * MAP_SHARED to prevent internal slot pages from being moved
@@ -9814,10 +9839,10 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 		hva = vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
 			      MAP_SHARED | MAP_ANONYMOUS, 0);
 		if (IS_ERR((void *)hva))
-			return PTR_ERR((void *)hva);
+			return (void __user *)hva;
 	} else {
 		if (!slot || !slot->npages)
-			return 0;
+			return ERR_PTR_USR(0);
 
 		/*
 		 * Stuff a non-canonical value to catch use-after-delete.  This
@@ -9838,13 +9863,13 @@ int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size)
 		m.memory_size = size;
 		r = __kvm_set_memory_region(kvm, &m);
 		if (r < 0)
-			return r;
+			return ERR_PTR_USR(r);
 	}
 
 	if (!size)
 		vm_munmap(hva, old_npages * PAGE_SIZE);
 
-	return 0;
+	return (void __user *)hva;
 }
 EXPORT_SYMBOL_GPL(__x86_set_memory_region);
 
-- 
2.24.1

