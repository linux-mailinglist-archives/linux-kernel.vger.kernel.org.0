Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5317970B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgCDRuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 12:50:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388189AbgCDRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfTkC/PY7xB+DvD3BXQd6wkmojeJ73JPJ868luIW5QI=;
        b=Ew6ViRSW+jgrTdZcI/bibJtVngLuS+9HaoL2K/hFIwkGcMUf7W+673w6idEWhGh/RTIY12
        j1YFh+sEkl+b6l7lu/M/EIySkFykA7GHmQHkyqAMtimrKDIZ2wlZ80mDA/eSxqJqNUWmVL
        4TiCJ7Q5Z6X0W5+df+Yu+Bjn9tZcz6k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-95EYofcGO-S_U0opbASqKw-1; Wed, 04 Mar 2020 12:49:58 -0500
X-MC-Unique: 95EYofcGO-S_U0opbASqKw-1
Received: by mail-qt1-f200.google.com with SMTP id i6so1995823qtw.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfTkC/PY7xB+DvD3BXQd6wkmojeJ73JPJ868luIW5QI=;
        b=Fq1BHs+lDWRv3d2P6smP7NOQOkcIgR2bVFE1NAe2TeCOACIi8kITHTjX0gIcbpG0Uy
         gsyabibm53YfDuXJn5OCXmftqIeIOsFSeXeRfAUxfMvau+MhpPrea6g26eQ710XU6Zr6
         OUCjU+RNuDcW/Wgg3ZL4CGZHdG5Nt7KxSec6RFCddEiGLDQUwElPOs7TSpxvdt42ECm7
         rBGSp3vrGZYS5LiNUcTlvpSVHIiOrD/94Dzj4pYzC34E5dLkpIOH0Mqb1i2q2bqEHC15
         m3EuAF9/D5UaVkBGLMV77OZJY9IuwhZpJaFIMNG9e/ws1/b9GirD2MyUIoPtqzOSCkjb
         tKsQ==
X-Gm-Message-State: ANhLgQ06Fl996ZhEQQ+AM2CRgQKCPdsSD2mH1ezVd81rrUnJdPACI1T1
        KZEnn/mFQOSxcYRw4rW5+MnXG7LC0qX5IwwSx9823bEn9uHuaEjP7VgpCIArW1tLa6X2d93mW9f
        j3P6RLj2CnCtFKEL++RgWTYbJ
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr4026047qkl.311.1583344197311;
        Wed, 04 Mar 2020 09:49:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvrMDWUEoj6vNcSrSe6DsUXUc0EpIPzTdDJM3axSpL8+wBuqbsoHgNqZ8SLGK51EOT04ppFQg==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr4026023qkl.311.1583344197103;
        Wed, 04 Mar 2020 09:49:57 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id e88sm7085142qtd.9.2020.03.04.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:49:56 -0800 (PST)
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
Subject: [PATCH v5 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Wed,  4 Mar 2020 12:49:35 -0500
Message-Id: <20200304174947.69595-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the address space ID just like the slot ID.  It will be used in
order to fill in the dirty ring entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bcb9b2ac0791..afa0e9034881 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -346,6 +346,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u8 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 70f03ce0e5c1..e6484dabfc59 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1036,6 +1036,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

