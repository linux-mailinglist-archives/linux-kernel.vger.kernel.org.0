Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4FA9E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfIEJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 05:22:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfIEJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5AE91576;
        Thu,  5 Sep 2019 02:22:25 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394383F67D;
        Thu,  5 Sep 2019 02:22:25 -0700 (PDT)
Date:   Thu, 5 Sep 2019 11:22:23 +0200
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
Message-ID: <20190905092223.GC4320@e113682-lin.lund.arm.com>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org>
 <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:56:44AM +0100, Peter Maydell wrote:
> On Thu, 5 Sep 2019 at 09:52, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Thu, 05 Sep 2019 09:16:54 +0100,
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > > This is true, but the problem is that barfing out to userspace
> > > makes it harder to debug the guest because it means that
> > > the VM is immediately destroyed, whereas AIUI if we
> > > inject some kind of exception then (assuming you're set up
> > > to do kernel-debug via gdbstub) you can actually examine
> > > the offending guest code with a debugger because at least
> > > your VM is still around to inspect...
> >
> > To Christoffer's point, I find the benefit a bit dubious. Yes, you get
> > an exception, but the instruction that caused it may be completely
> > legal (store with post-increment, for example), leading to an even
> > more puzzled developer (that exception should never have been
> > delivered the first place).
> 
> Right, but the combination of "host kernel prints a message
> about an unsupported load/store insn" and "within-guest debug
> dump/stack trace/etc" is much more useful than just having
> "host kernel prints message" and "QEMU exits"; and it requires
> about 3 lines of code change...
> 
> > I'm far more in favour of dumping the state of the access in the run
> > structure (much like we do for a MMIO access) and let userspace do
> > something about it (such as dumping information on the console or
> > breaking). It could even inject an exception *if* the user has asked
> > for it.
> 
> ...whereas this requires agreement on a kernel-userspace API,
> larger changes in the kernel, somebody to implement the userspace
> side of things, and the user to update both the kernel and QEMU.
> It's hard for me to see that the benefit here over the 3-line
> approach really outweighs the extra effort needed. In practice
> saying "we should do this" is saying "we're going to do nothing",
> based on the historical record.
> 

How about something like the following (completely untested, liable for
ABI discussions etc. etc., but for illustration purposes).

I think it raises the question (and likely many other) of whether we can
break the existing 'ABI' and change behavior for missing ISV
retrospectively for legacy user space when the issue has occurred?
   
Someone might have written code that reacts to the -ENOSYS, so I've
taken the conservative approach for this for the time being.


diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8a37c8e89777..19a92c49039c 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -76,6 +76,14 @@ struct kvm_arch {
 
 	/* Mandated version of PSCI */
 	u32 psci_version;
+
+	/*
+	 * If we encounter a data abort without valid instruction syndrome
+	 * information, report this to user space.  User space can (and
+	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
+	 * supported.
+	 */
+	bool return_nisv_io_abort_to_user;
 };
 
 #define KVM_NR_MEM_OBJS     40
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f656169db8c3..019bc560edc1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -83,6 +83,14 @@ struct kvm_arch {
 
 	/* Mandated version of PSCI */
 	u32 psci_version;
+
+	/*
+	 * If we encounter a data abort without valid instruction syndrome
+	 * information, report this to user space.  User space can (and
+	 * should) opt in to this feature if KVM_CAP_ARM_NISV_TO_USER is
+	 * supported.
+	 */
+	bool return_nisv_io_abort_to_user;
 };
 
 #define KVM_NR_MEM_OBJS     40
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5e3f12d5359e..a4dd004d0db9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -235,6 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
+#define KVM_EXIT_ARM_NISV         28
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -996,6 +997,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
 #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
 #define KVM_CAP_PMU_EVENT_FILTER 173
+#define KVM_CAP_ARM_NISV_TO_USER 174
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 35a069815baf..2ce94bd9d4a9 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -98,6 +98,26 @@ int kvm_arch_check_processor_compat(void)
 	return 0;
 }
 
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap)
+{
+	int r;
+
+	if (cap->flags)
+		return -EINVAL;
+
+	switch (cap->cap) {
+	case KVM_CAP_ARM_NISV_TO_USER:
+		r = 0;
+		kvm->arch.return_nisv_io_abort_to_user = true;
+		break;
+	default:
+		r = -EINVAL;
+		break;
+	}
+
+	return r;
+}
 
 /**
  * kvm_arch_init_vm - initializes a VM data structure
@@ -196,6 +216,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MP_STATE:
 	case KVM_CAP_IMMEDIATE_EXIT:
 	case KVM_CAP_VCPU_EVENTS:
+	case KVM_CAP_ARM_NISV_TO_USER:
 		r = 1;
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
@@ -673,6 +694,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		ret = kvm_handle_mmio_return(vcpu, vcpu->run);
 		if (ret)
 			return ret;
+	} else if (run->exit_reason == KVM_EXIT_ARM_NISV) {
+		kvm_inject_undefined(vcpu);
 	}
 
 	if (run->immediate_exit)
diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
index 6af5c91337f2..62e6ef47a6de 100644
--- a/virt/kvm/arm/mmio.c
+++ b/virt/kvm/arm/mmio.c
@@ -167,8 +167,15 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		if (ret)
 			return ret;
 	} else {
-		kvm_err("load/store instruction decoding not implemented\n");
-		return -ENOSYS;
+		if (vcpu->kvm->arch.return_nisv_io_abort_to_user) {
+			run->exit_reason = KVM_EXIT_ARM_NISV;
+			run->mmio.phys_addr = fault_ipa;
+			vcpu->stat.mmio_exit_user++;
+			return 0;
+		} else {
+			kvm_info("encountered data abort without syndrome info\n");
+			return -ENOSYS;
+		}
 	}
 
 	rt = vcpu->arch.mmio_decode.rt;


Thanks,

    Christoffer
