Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7C11BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 21:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLKUsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 15:48:32 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:33509 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLKUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:48:31 -0500
Received: by mail-ua1-f74.google.com with SMTP id u20so6582793uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jlDyQ8V1A4E8vFOmfZoIbJ2QXkEwRCCLJLwBmOJe29A=;
        b=jjExR/ypQVqELVfmZroUTsrHDq+Kyle0r7cM6GRFHucL2QDpMuZu3CdhmxcEj1+Ggx
         T8So24lxdlDrhk+RuF27Un0DG77dq2CZ9HeYsLpV5QlMy2HtKC55VRqIb8qE+dHH0ITg
         GSleJ9N1oeFDK3s2487N+mFccVTnmHlEbx7WcAxgELvTZjNngusHfdOSkg/QcdlZ1riq
         qSeHd362e8Pu/ZhX+hsgtZ0jZ0iw8suFK6xgpZ2TVTpBplBECiph61eND0JBp2AbBmpq
         y8snT3db8QYHtMiqkIYkCXFjwa9j8jV//DXickQMzbWZWaBg5Lf9mVwD5Hf2mz9W0kIa
         v82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jlDyQ8V1A4E8vFOmfZoIbJ2QXkEwRCCLJLwBmOJe29A=;
        b=aohQ3BK0rOiyIU2JVTZC0TNDLVUdpwR3v8xVPVITj2mJ3lzbaxWE8GghGCVyAN7BVp
         uMLsw61DTfXxU0uLi1L3DaseZ8wWI14ZQeCVeRPXVKILnAiFYtOTO8r5rIwnXgm2ooZl
         ABySVrVLknBTaXmwjGQ/fJ3ilAC2fc3oejJUhucsjBK14yi7M+tpi2UHffLbGIaDJekK
         XJhRytPJRMins1+n5HGlfaLU5vgk9rNKiY34xW/qTIWmbDYPmliLxuhw0H/WjtDgN+0q
         gafXjuSjgys4DdC8sLVxTWXtPgQjEzRtUEs1nGLI8QmepQJ23iv84j4nlwlTb9o1j/Sy
         VaMQ==
X-Gm-Message-State: APjAAAXwQor/IEkzqqbVEKsMhacV1Znv7RHSTrvtHCqKCxySocZ0s+j4
        iw+Sc5JTNRajh1MAKKNScKfTNTTi/kvW
X-Google-Smtp-Source: APXvYqyq+7rLt1Mbo63AO66IU/V2FHwB6iU0oZSlIduHJY1TtnmF475NNmuDKCUH1XyAbf89tAosu/+ebq+e
X-Received: by 2002:a1f:ac57:: with SMTP id v84mr5636546vke.90.1576097310120;
 Wed, 11 Dec 2019 12:48:30 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:47:42 -0800
In-Reply-To: <20191211204753.242298-1-pomonis@google.com>
Message-Id: <20191211204753.242298-3-pomonis@google.com>
Mime-Version: 1.0
References: <20191211204753.242298-1-pomonis@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v2 02/13] KVM: x86: Protect kvm_hv_msr_[get|set]_crash_data()
 from Spectre-v1/L1TF attacks
From:   Marios Pomonis <pomonis@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Finco <nifi@google.com>, Andrew Honig <ahonig@google.com>,
        Marios Pomonis <pomonis@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes Spectre-v1/L1TF vulnerabilities in kvm_hv_msr_get_crash_data()
and kvm_hv_msr_set_crash_data().
These functions contain index computations that use the
(attacker-controlled) MSR number.

Fixes: commit e7d9513b60e8 ("kvm/x86: added hyper-v crash msrs into kvm hyperv context")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kvm/hyperv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 23ff65504d7e..26408434b9bc 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -809,11 +809,12 @@ static int kvm_hv_msr_get_crash_data(struct kvm_vcpu *vcpu,
 				     u32 index, u64 *pdata)
 {
 	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+	size_t size = ARRAY_SIZE(hv->hv_crash_param);
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
+	if (WARN_ON_ONCE(index >= size))
 		return -EINVAL;
 
-	*pdata = hv->hv_crash_param[index];
+	*pdata = hv->hv_crash_param[array_index_nospec(index, size)];
 	return 0;
 }
 
@@ -852,11 +853,12 @@ static int kvm_hv_msr_set_crash_data(struct kvm_vcpu *vcpu,
 				     u32 index, u64 data)
 {
 	struct kvm_hv *hv = &vcpu->kvm->arch.hyperv;
+	size_t size = ARRAY_SIZE(hv->hv_crash_param);
 
-	if (WARN_ON_ONCE(index >= ARRAY_SIZE(hv->hv_crash_param)))
+	if (WARN_ON_ONCE(index >= size))
 		return -EINVAL;
 
-	hv->hv_crash_param[index] = data;
+	hv->hv_crash_param[array_index_nospec(index, size)] = data;
 	return 0;
 }
 
-- 
2.24.0.525.g8f36a354ae-goog

