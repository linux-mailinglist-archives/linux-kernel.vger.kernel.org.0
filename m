Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 514F617AD8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCERu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 12:50:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:47062 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgCERuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:50:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 09:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352404073"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 09:50:51 -0800
Subject: [RFC][PATCH 1/2] x86: remove duplicate TSC DEADLINE MSR definitions
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        peterz@infradead.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 05 Mar 2020 09:47:06 -0800
Message-Id: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There are two definitions for the TSC deadline MSR in msr-index.h,
one with an underscore and one without.  Axe one of them and move
all the references over to the other one.

Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>

---

 b/arch/x86/include/asm/msr-index.h                       |    2 --
 b/arch/x86/kvm/x86.c                                     |    6 +++---
 b/tools/arch/x86/include/asm/msr-index.h                 |    2 --
 b/tools/perf/trace/beauty/tracepoints/x86_msr.sh         |    2 +-
 b/tools/testing/selftests/kvm/include/x86_64/processor.h |    2 --
 5 files changed, 4 insertions(+), 10 deletions(-)

diff -puN arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/include/asm/msr-index.h
--- a/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.049901042 -0800
+++ b/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.062901042 -0800
@@ -576,8 +576,6 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
diff -puN arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/kvm/x86.c
--- a/arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.051901042 -0800
+++ b/arch/x86/kvm/x86.c	2020-03-05 09:42:37.065901042 -0800
@@ -1200,7 +1200,7 @@ static const u32 emulated_msrs_all[] = {
 	MSR_KVM_PV_EOI_EN,
 
 	MSR_IA32_TSC_ADJUST,
-	MSR_IA32_TSCDEADLINE,
+	MSR_IA32_TSC_DEADLINE,
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
@@ -2688,7 +2688,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 		return kvm_set_apic_base(vcpu, msr_info);
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
 		return kvm_x2apic_msr_write(vcpu, msr, data);
-	case MSR_IA32_TSCDEADLINE:
+	case MSR_IA32_TSC_DEADLINE:
 		kvm_set_lapic_tscdeadline_msr(vcpu, data);
 		break;
 	case MSR_IA32_TSC_ADJUST:
@@ -3009,7 +3009,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
 		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
 		break;
-	case MSR_IA32_TSCDEADLINE:
+	case MSR_IA32_TSC_DEADLINE:
 		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
 		break;
 	case MSR_IA32_TSC_ADJUST:
diff -puN tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE tools/arch/x86/include/asm/msr-index.h
--- a/tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.055901042 -0800
+++ b/tools/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.066901042 -0800
@@ -576,8 +576,6 @@
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
 #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
diff -puN tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE tools/perf/trace/beauty/tracepoints/x86_msr.sh
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.057901042 -0800
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh	2020-03-05 09:42:37.066901042 -0800
@@ -15,7 +15,7 @@ x86_msr_index=${arch_x86_header_dir}/msr
 
 printf "static const char *x86_MSRs[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
-egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSCDEADLINE|IDT_FCR4)' | \
+egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSC_DEADLINE|IDT_FCR4)' | \
 	sed -r "s/$regex/\2 \1/g" | sort -n | \
 	xargs printf "\t[%s] = \"%s\",\n"
 printf "};\n\n"
diff -puN tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE tools/testing/selftests/kvm/include/x86_64/processor.h
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.058901042 -0800
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h	2020-03-05 09:42:37.067901042 -0800
@@ -813,8 +813,6 @@ void kvm_get_cpu_address_width(unsigned
 #define		APIC_VECTOR_MASK	0x000FF
 #define	APIC_ICR2	0x310
 
-#define MSR_IA32_TSCDEADLINE		0x000006e0
-
 #define MSR_IA32_UCODE_WRITE		0x00000079
 #define MSR_IA32_UCODE_REV		0x0000008b
 
_
