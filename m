Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3217AE45
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 19:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCEShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 13:37:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgCEShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583433455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2yWNaYqjJ/RvKkVVduCbhM3C1I4Zkz6logIvpDXjRI=;
        b=U5fGzHUtb96Q7PGaokngMGbqU33czbWn/ynEUR40SCfJeFKMx2BCuu+tPaucxtFyypL1Sa
        A/9OEGz+rklJHEyUv3/OEIkQ8Z/Wj1dD3BtAqOJeFqOeQEu0joEgUH5A9FHCJRNLmdGZuU
        CoVZVoG+9T0CDP34TuMtGn5+yOaMIGk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-b7HvFR8jOnSWeefRNWPHWw-1; Thu, 05 Mar 2020 13:37:32 -0500
X-MC-Unique: b7HvFR8jOnSWeefRNWPHWw-1
Received: by mail-wm1-f72.google.com with SMTP id p17so1062506wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2yWNaYqjJ/RvKkVVduCbhM3C1I4Zkz6logIvpDXjRI=;
        b=DI9gBVCWE96Q1qg9pqz22nrvLTBEzyd3Jksm77g1WwqDn9mmqrt0epi7XxzTdhp9gb
         4CBpAuBIIGcrMiwLbyewSKhUdeLSQ1bSh65lJmiIR1BtluX8KGgwtXqZOMZsDVs58L97
         X9sNnRYnKkaUABEYVpncXwgGrKNtEAvJzTv88XlfOhlOh7pTXn6dtjz73W5XnORwJGPf
         4bOhFPqt0Zs2XKXMowelBJiAMXiwaGDkS9ilqNI41XwDArI6JiEDrR8gqAHsaQox4OVB
         3cqpUkqofG2Uu1oLOf/mA+Hl2CNqIiEs0n0VFQhcWyMOzGmu3aGWExL9wcGQtB5Ti2hv
         X+gQ==
X-Gm-Message-State: ANhLgQ2SV6i8+7pL2EAaEbx1fSUXoJI0Zfj4dy/kcn3QOoR1ORebr2Ru
        sbh0H8zRrOzOU0vG9FIdHJThZpMT399IG0aDk9bQFRY316QieIDtbT24Vr78x3nisWdo8YFVZot
        WprJj12LJiVOZI1GEPc8klxW1
X-Received: by 2002:a5d:4805:: with SMTP id l5mr251436wrq.11.1583433451433;
        Thu, 05 Mar 2020 10:37:31 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt5yUT+iVGTGcKSZmbdeAb5G5VOmuV4IHK9ltTcOTR1wb/CGf1O1/ALTCR0TuslpOqF3DIkKg==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr251423wrq.11.1583433451243;
        Thu, 05 Mar 2020 10:37:31 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u17sm9369121wmj.47.2020.03.05.10.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:37:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: VMX: rename 'kvm_area' to 'vmxon_region'
Date:   Thu,  5 Mar 2020 19:37:24 +0100
Message-Id: <20200305183725.28872-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305183725.28872-1-vkuznets@redhat.com>
References: <20200305183725.28872-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name 'kvm_area' is misleading (as we have way too many areas which are
KVM related), what alloc_kvm_area()/free_kvm_area() functions really do is
allocate/free VMXON region for all CPUs. Rename accordingly.

No functional change intended.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40b1e6138cd5..dab19e4e5f2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2635,7 +2635,7 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	return -ENOMEM;
 }
 
-static void free_kvm_area(void)
+static void free_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2645,7 +2645,7 @@ static void free_kvm_area(void)
 	}
 }
 
-static __init int alloc_kvm_area(void)
+static __init int alloc_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2654,7 +2654,7 @@ static __init int alloc_kvm_area(void)
 
 		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
 		if (!vmcs) {
-			free_kvm_area();
+			free_vmxon_regions();
 			return -ENOMEM;
 		}
 
@@ -7815,7 +7815,7 @@ static __init int hardware_setup(void)
 			return r;
 	}
 
-	r = alloc_kvm_area();
+	r = alloc_vmxon_regions();
 	if (r)
 		nested_vmx_hardware_unsetup();
 	return r;
@@ -7826,7 +7826,7 @@ static __exit void hardware_unsetup(void)
 	if (nested)
 		nested_vmx_hardware_unsetup();
 
-	free_kvm_area();
+	free_vmxon_regions();
 }
 
 static bool vmx_check_apicv_inhibit_reasons(ulong bit)
-- 
2.24.1

