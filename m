Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D218317881B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 03:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgCDCRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 21:17:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387400AbgCDCRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583288219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zwpmLVhYAg+RzC4wgoFG5yb2Ol28WwASDz+oEeK9Uow=;
        b=RkMGg80ReMekloKrhUk7steiD/j0iRh1+Vg3U/b+El4vCyvrWwy7FAqUmhwkFEumaMavTB
        yyo4gZhAS0aiTs+3CflFE1aYwSnfRmDEMhiMnSKZzylnMYVUWBF+GFNB9acgZlPZw8QwKi
        zUM2QXWC7m24dzz5CaeSzNhmK7aZvFo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-KLrQ_LnZNW2aluW2YA0jjA-1; Tue, 03 Mar 2020 21:16:55 -0500
X-MC-Unique: KLrQ_LnZNW2aluW2YA0jjA-1
Received: by mail-qk1-f200.google.com with SMTP id w6so315080qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwpmLVhYAg+RzC4wgoFG5yb2Ol28WwASDz+oEeK9Uow=;
        b=GKXW4RuCUGWe43r9j/uHmNwBuMZmmTsRR8RsbTbI/Sahrt+CgFBnywDYFR6SCc1Njv
         4I43/GCJpXgUTPZaopjm8y38PTsFuptDRBPMqKKhyQYknlsctqinPg50vQZ64a4gyKiK
         AOz6oenUnpq8F60eBsI7z11qBI1zDzB7DZyXrcOleRjGvwkXErJ7mKjVj8avUHad7+4H
         khqb48bX3Ywa1/GhtEsRoDMy92Q+8lflsnge7J7AhB2JV8PE/L7rykIY02b63RuCD8nk
         UBtAM5mcBSl2NMDe9n6vZk6f3cR9a663c7ifLHBPShCZCNV59fSGsiBRStTmJ845GWJK
         fqNQ==
X-Gm-Message-State: ANhLgQ3Z6rFBfI0z0gHW4pndmv5txaGs9qrQyg6Bow8qfTQDVjIVWYYF
        I3gNkc9ZNasNjSFpuXhHMlq0MTkdyGt9LITAwlmUzfFCXsuWw6dyfYzxrdLs6JieC9hsKYBqgUR
        NS1p11+D+AFhMNyORmGmPBy/0
X-Received: by 2002:a05:620a:350:: with SMTP id t16mr936780qkm.238.1583288214462;
        Tue, 03 Mar 2020 18:16:54 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu1ZMXcr1gqC/Zi87ZN+GHeSsAkSbjaQbQrEwLisqJpF+0jVmM6F3RpKZnuzgvqnsEWVWUn7Q==
X-Received: by 2002:a05:620a:350:: with SMTP id t16mr936762qkm.238.1583288214196;
        Tue, 03 Mar 2020 18:16:54 -0800 (PST)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id n59sm4185363qtd.77.2020.03.03.18.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 18:16:53 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH] KVM: X86: Avoid explictly fetch instruction in x86_decode_insn()
Date:   Tue,  3 Mar 2020 21:16:37 -0500
Message-Id: <20200304021637.17856-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

insn_fetch() will always implicitly refill instruction buffer properly
when the buffer is empty, so we don't need to explicitly fetch it even
if insn_len==0 for x86_decode_insn().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/emulate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dd19fb3539e0..04f33c1ca926 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5175,11 +5175,6 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
 	ctxt->opcode_len = 1;
 	if (insn_len > 0)
 		memcpy(ctxt->fetch.data, insn, insn_len);
-	else {
-		rc = __do_insn_fetch_bytes(ctxt, 1);
-		if (rc != X86EMUL_CONTINUE)
-			goto done;
-	}
 
 	switch (mode) {
 	case X86EMUL_MODE_REAL:
-- 
2.24.1

