Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC27B302
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbfG3TNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 15:13:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfG3TNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so29310752pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W0NzhAJDW6f6zv48MhA58X21t6ZEAVN81pjWGMonLUQ=;
        b=OjB3x2X1IjXnZyRT0y4ci0Z+ZmocMVw3jXB+231CIxuQ+Vi+vnoHGPII6xu43tIQCC
         izbGp42+Tr1lJM8CDyrUkPzRGeM0gleYKorJYw2ygKdUkeHux+isppWd00bdLc2rwBsV
         7BjDP8/gm1rSJVMA09kWAibgoOJb+bvzAzmtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0NzhAJDW6f6zv48MhA58X21t6ZEAVN81pjWGMonLUQ=;
        b=OmqVMDgAbg1+cq+Z7R8RIFjLIP/NmuPjchL6GZhSnjJ58t+z0NPfrSN+c50a4dwHwW
         2sFGP/6nH4likls3VBWaSe5zdW3GvVMUKklUoLDN3NsgjzAqy4emv/GLpPfsfFJeJMAN
         p6CCVD4huUsi/Bh3tb01rIAlJ0v87wHIUO0bHyn0Lk9G/YtiBMns+HnNlOyULZi5jKZK
         EstmX+zRGQXynwNaw3tduYWwYCMtGvQmeAi9DkjIFn78T7cYdvRDaqxgdax7hwPpH2xc
         wWKoDLuVVjr6NBlD0svutK866KaLbgtuq0YarUmPl3fPqiOlC3gZNFg5nL94DC3VIEPf
         Mosw==
X-Gm-Message-State: APjAAAVLklakqBchj3neZbEzsThDKxn0Ga16YIwb4YhyF3lIjlVC+7YV
        M5U3Z+ZkguBnnu4Cg13Q03zhvQ==
X-Google-Smtp-Source: APXvYqwsIu5EjDisGZPc1G7mJNiIJ7XnbgYepkvqZhs11fZLulhf+xJkltnPFGWfc108tM55QvLPhQ==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr116539349plb.270.1564513994552;
        Tue, 30 Jul 2019 12:13:14 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:14 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/11] x86: relocate_kernel - Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:47 -0700
Message-Id: <20190730191303.206365-4-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only absolute references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c51ccff5cd01..c72889b09840 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -206,7 +206,7 @@ identity_mapped:
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
-	movq	$virtual_mapped, %rax
+	movabsq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
 
-- 
2.22.0.770.g0f2c4a37fd-goog

