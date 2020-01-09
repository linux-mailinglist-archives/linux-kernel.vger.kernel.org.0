Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E956135DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 17:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgAIQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 11:10:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731792AbgAIQKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYrT6TRHMGtnrr0wIPLjvHg1Nvng0fUgO8VFzG9RuSY=;
        b=ISk7YWsaey6qrykZH6UQYIqhKm4cdrbZYpzDvv65IznsrBtguVmxccYlU3ER8Gvr3wTjQM
        7wwG6W9wO3umKHtzTyJSOvR6pTY1FLhumjyFPwbZ3Nb4EFsRBboeErvb+Uny2KjdOEbf6A
        LxcM6SsXx10sHILpL/ZtSevGLfV8pz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-FzupJEYJOpK3RhM79zQlVw-1; Thu, 09 Jan 2020 11:10:12 -0500
X-MC-Unique: FzupJEYJOpK3RhM79zQlVw-1
Received: by mail-wm1-f72.google.com with SMTP id g26so623356wmk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYrT6TRHMGtnrr0wIPLjvHg1Nvng0fUgO8VFzG9RuSY=;
        b=BxOJptOOd+4vr5xijF000MVLwTOE7r58LmBn/1GUbc5ww83yGMGmWvcInhCqn9Qxsl
         u2b6vKUO6bl2wsctozTUDtCQ2jcSL3V9EIDob4dpg+1EkG3chArqTlbl0JOyo7ybfXgs
         uiYNBjw+9BaM500WXq4SGTMdjCMAJK3UIpTXB9J7pZAzf4TQSeCTRIohRncPeqgdOt68
         oUtgzcG/Yuisjc78+IPasgavN9b/hE2A7CZcWlRa0FNMn8ZfuhBNvQt2KqosZqH07F3J
         OHEeBu/wmnpf9jYJ1ui8Z95mDXJRSMXJxc3d5juh+SqLgW9oaJEVz0MiikzJg89qgNXu
         CD8Q==
X-Gm-Message-State: APjAAAW/CjxNVDuxl//gXeTxGjdxB3a7oMw/Bkj1lf6m60g2Kbw+1CaL
        BXWCVqB4jN41Gea0qBKnhCcG/rq2FgCmim5B2UydmkmSDGGWzzRg11RlpnNQBtQize3fSSrdnhj
        gAbnQYkiAee85jGcG0f63f9y3
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5599515wml.138.1578586211421;
        Thu, 09 Jan 2020 08:10:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjp1dWXem4kmadDnAuoaApxhJOhhpVFrfaTf6yB8TLsgHEvhENEDjZczqJHI6GszCgiysJfg==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5599496wml.138.1578586211254;
        Thu, 09 Jan 2020 08:10:11 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id y17sm2820948wma.36.2020.01.09.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:10:10 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 56/57] arm64: entry: Avoid empty alternatives entries
Date:   Thu,  9 Jan 2020 16:02:59 +0000
Message-Id: <20200109160300.26150-57-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel_ventry will create alternative entries to potentially replace
0 instructions with 0 instructions for EL1 vectors. While this does not
cause an issue, it pointlessly takes up some bytes in the alternatives
section.

Do not generate such entries.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/kernel/entry.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7c6a0a41676f..605bb7cbe499 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -60,16 +60,16 @@
 	.macro kernel_ventry, el, label, regsize = 64
 	.align 7
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-alternative_if ARM64_UNMAP_KERNEL_AT_EL0
 	.if	\el == 0
+alternative_if ARM64_UNMAP_KERNEL_AT_EL0
 	.if	\regsize == 64
 	mrs	x30, tpidrro_el0
 	msr	tpidrro_el0, xzr
 	.else
 	mov	x30, xzr
 	.endif
-	.endif
 alternative_else_nop_endif
+	.endif
 #endif
 
 	sub	sp, sp, #S_FRAME_SIZE
-- 
2.21.0

