Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4412838F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfLTVDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 16:03:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727773AbfLTVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=PIatT3YmUI0QQL4Ha8iq75+UvFfY31aC6VQmskgN+KNmui7JNUHCqVwfsLcqRrgxU1dhGr
        iH3Q4Vq5/EuPTlPlYijhf8vX7WwM/h80fPaOm9JRB63iLAPAUPQHiLe6cyX9gP6zDKJZAE
        U88GLZxgzW7QBgV+LjkdYjjjzwv3l4U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-3y9T-upMOkGdC8db8drCXw-1; Fri, 20 Dec 2019 16:03:36 -0500
X-MC-Unique: 3y9T-upMOkGdC8db8drCXw-1
Received: by mail-qk1-f198.google.com with SMTP id x127so6740575qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JYh7n3fhb27PXs/bYUs6lzlcg1ya8dgcofIlxRo1Jg=;
        b=o6m7DTcU2JfKTuCBu8lbKUQFTKKzcY+ZUEtIFj0pwjKf4H+cZw9APfdT3Z51Omec/q
         CaspGTwqqlEQtVPbeXVK2Pm3CSZ91iQ6NsbZeX3oIAxFfkrzNOvxYO9ZBZCibLAg+vMi
         rVkLp4tX2OvAO6MZPvW/h6IV3vFKEOl1It9komKrMP+q0onduHKy59uQii8xoziKGkX6
         1QDC8fbYdUF40FqBGQJgGwYskBDJkLndfoSZqSq1asWsJxNDTQlikoCza1COaeYSEh8Y
         JuuTlmZE+rnVsBJ4XJDHqxH8N2jqOsATQRzBwY0+eC4HG2tQcC848G2oN93DmceJ/qiR
         Eb4w==
X-Gm-Message-State: APjAAAXH/OqULBxjGX4Fk/mKYU+T+cNkDA/N6fAOrTxeh01zBF7UedoQ
        8DeqbaLyGMnwLodr6XpIPBh/DOwHG0uJy6p9TW6S0p9gT9IJDRbMMEDMFYXNNr0IyllXNC4juGM
        H1Cnb6053tCllBTUURyNT33F7
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr14081863qvo.91.1576875816077;
        Fri, 20 Dec 2019 13:03:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNSD9sJzoZa53Bscgtcp3kOJukY7A7DFBD+/ym7p7wDcbwYwsje85hFcdBLyzFwr+wgJtPTg==
X-Received: by 2002:a0c:f8ce:: with SMTP id h14mr14081841qvo.91.1576875815891;
        Fri, 20 Dec 2019 13:03:35 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id a9sm3061018qtb.36.2019.12.20.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:03:34 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 04/17] KVM: Cache as_id in kvm_memory_slot
Date:   Fri, 20 Dec 2019 16:03:13 -0500
Message-Id: <20191220210326.49949-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210326.49949-1-peterx@redhat.com>
References: <20191220210326.49949-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's cache the address space ID just like the slot ID.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4e34cf97ca90..24854c9e3717 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -348,6 +348,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u8 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b1047173d78e..cea4b8dd4ac9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1027,6 +1027,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

