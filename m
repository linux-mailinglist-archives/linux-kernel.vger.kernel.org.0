Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D5BFB05
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 23:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfIZVnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 17:43:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:8270 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfIZVnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 17:43:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 14:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,553,1559545200"; 
   d="scan'208";a="192958531"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 26 Sep 2019 14:43:03 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>
Subject: [PATCH 2/2] KVM: VMX: Skip GUEST_CR3 VMREAD+VMWRITE if the VMCS is up-to-date
Date:   Thu, 26 Sep 2019 14:43:02 -0700
Message-Id: <20190926214302.21990-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190926214302.21990-1-sean.j.christopherson@intel.com>
References: <20190926214302.21990-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the VMWRITE to update GUEST_CR3 if CR3 is not available, i.e. has
not been read from the VMCS since the last VM-Enter.  If vcpu->arch.cr3
is stale, kvm_read_cr3(vcpu) will refresh vcpu->arch.cr3 from the VMCS,
meaning KVM will do a VMREAD and then VMWRITE the value it just pulled
from the VMCS.

Note, this is a purely theoretical change, no instances of skipping
the VMREAD+VMWRITE have been observed with this change.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b530950a9c2b..6de09f60edf3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3003,10 +3003,12 @@ void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 
 		if (is_guest_mode(vcpu))
 			skip_cr3 = true;
-		else if (enable_unrestricted_guest || is_paging(vcpu))
-			guest_cr3 = kvm_read_cr3(vcpu);
-		else
+		else if (!enable_unrestricted_guest && !is_paging(vcpu))
 			guest_cr3 = to_kvm_vmx(kvm)->ept_identity_map_addr;
+		else if (test_bit(VCPU_EXREG_CR3, (ulong *)&vcpu->arch.regs_avail))
+			guest_cr3 = vcpu->arch.cr3;
+		else
+			skip_cr3 = true; /* vmcs01.GUEST_CR3 is up-to-date. */
 		ept_load_pdptrs(vcpu);
 	}
 
-- 
2.22.0

