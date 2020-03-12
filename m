Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD211838DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCLSpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 14:45:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:23434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCLSpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:45:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="416041228"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 11:45:23 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 02/10] KVM: nVMX: Drop a superfluous WARN on reflecting EXTERNAL_INTERRUPT
Date:   Thu, 12 Mar 2020 11:45:13 -0700
Message-Id: <20200312184521.24579-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312184521.24579-1-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the WARN in nested_vmx_reflect_vmexit() that fires if KVM attempts
to reflect an external interrupt.  nested_vmx_exit_reflected() is now
called from nested_vmx_reflect_vmexit() and unconditionally returns
false for EXTERNAL_INTERRUPT, i.e. barring a compiler or major CPU bug,
the WARN will never fire.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/nested.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 6bc379cf4755..8f5ff3e259c9 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -84,12 +84,11 @@ static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
 		return false;
 
 	/*
-	 * At this point, the exit interruption info in exit_intr_info
-	 * is only valid for EXCEPTION_NMI exits.  For EXTERNAL_INTERRUPT
-	 * we need to query the in-kernel LAPIC.
+	 * vmcs.VM_EXIT_INTR_INFO is only valid for EXCEPTION_NMI exits.  For
+	 * EXTERNAL_INTERRUPT, the value for vmcs12->vm_exit_intr_info would
+	 * need to be synthesized by querying the in-kernel LAPIC, but external
+	 * interrupts are never reflected to L1 so it's a non-issue.
 	 */
-	WARN_ON(exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT);
-
 	exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
 	if ((exit_intr_info &
 	     (INTR_INFO_VALID_MASK | INTR_INFO_DELIVER_CODE_MASK)) ==
-- 
2.24.1

