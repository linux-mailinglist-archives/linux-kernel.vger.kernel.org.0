Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06763179708
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbgCDRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 12:49:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729979AbgCDRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=V9c6rKanZhYOcRtszuXnPCFz8rDeWWvkT5U1Dh/Zdu1eq9CzFyWlbBLcEWYMrbf9IFptSi
        TnImRPt9VtTUonX4hw27UhErGi+8bW/dDSfmps8DwP3yXXUVRPNoBRC9vRmVm8JGTg8Hxv
        DOpPVDNbvaHCeK+FmvD41h+VrxftmVc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-ZKbhGoO1NYuDt2_Wq2WIvQ-1; Wed, 04 Mar 2020 12:49:55 -0500
X-MC-Unique: ZKbhGoO1NYuDt2_Wq2WIvQ-1
Received: by mail-qt1-f198.google.com with SMTP id l21so2002253qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=eqRX4q2P10rMKfc3Kt+w1vozsUNXPFgl5EPM/P0vAqGE+Noaj6iyQFNOYNVbzUy04F
         dngRW7t+f878ppRTF0QcVI6NXSeLsG2C3lp5cNPxjbzPRwo3M9OpZWgoluE1fIqDOcfi
         c/SAnAxbDidluxPRZh5Xln1MdLs6t5Dastl+OYJL94ugZJdret4aIFwlFbGVUXIw4C6r
         6v1n0xw4JQMUaqd6owfNVxyZhon/pUl6y+dxT+f04UgUP7zOfjZmgmiGEzXARDnWfTRI
         qGyY6+A4Yoicb3nx02lwWavSDw84Q164CnQUcz1MKcP90bksJeHCSYDcq3x8PFwcvoLx
         8/7g==
X-Gm-Message-State: ANhLgQ1rDxLGdUJQ2mAe4JbtuM8Z7NrtVL7DrcM72P9Ull2O4myH2LDN
        JKVthULUsljORmlrkplwAGdcLNiln8sVD8nqW1TNTKZbBYxq0/eAbvVv74FOlhgSU6FDWCZCHd0
        L+gHYKIoXPKNvxcX1OQCGiZIB
X-Received: by 2002:ac8:534b:: with SMTP id d11mr3512260qto.101.1583344194070;
        Wed, 04 Mar 2020 09:49:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsEcJ8+mn9bDrZSYhkrNp5+S9+YoenWyrwAv3oEiBqUoFFjT9yfw5nnfEEcipf3nFOz7+yVbQ==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr3512237qto.101.1583344193844;
        Wed, 04 Mar 2020 09:49:53 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j4sm6990420qtv.45.2020.03.04.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:49:53 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Wed,  4 Mar 2020 12:49:34 -0500
Message-Id: <20200304174947.69595-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be clearer to dump the return value to know easily on whether
did we go through the fast path for handling current page fault.
Remove the old two last parameters because after all the old/new sptes
were dumped in the same line.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmutrace.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmutrace.h
index ffcd96fc02d0..ef523e760743 100644
--- a/arch/x86/kvm/mmutrace.h
+++ b/arch/x86/kvm/mmutrace.h
@@ -244,9 +244,6 @@ TRACE_EVENT(
 		  __entry->access)
 );
 
-#define __spte_satisfied(__spte)				\
-	(__entry->retry && is_writable_pte(__entry->__spte))
-
 TRACE_EVENT(
 	fast_page_fault,
 	TP_PROTO(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u32 error_code,
@@ -274,12 +271,10 @@ TRACE_EVENT(
 	),
 
 	TP_printk("vcpu %d gva %llx error_code %s sptep %p old %#llx"
-		  " new %llx spurious %d fixed %d", __entry->vcpu_id,
+		  " new %llx ret %d", __entry->vcpu_id,
 		  __entry->cr2_or_gpa, __print_flags(__entry->error_code, "|",
 		  kvm_mmu_trace_pferr_flags), __entry->sptep,
-		  __entry->old_spte, __entry->new_spte,
-		  __spte_satisfied(old_spte), __spte_satisfied(new_spte)
-	)
+		  __entry->old_spte, __entry->new_spte, __entry->retry)
 );
 
 TRACE_EVENT(
-- 
2.24.1

