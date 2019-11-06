Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6960F0AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 00:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfKEX4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 18:56:24 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:44629 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfKEX4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:22 -0500
Received: by mail-vk1-f202.google.com with SMTP id 131so1158607vkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OH2SjYe0B8esWxTAcCgR+62MsPomBC+RzRSTMU1rFk8=;
        b=LANLIsSLRt+jERn9z/YC1fWtMQVX8zCypiEu6yw+A7ph5wykxHwT9wsDMQDlDMl2rg
         stArYiAU/nb/XpN8wDOhlGyfTc0fdCPVyLoqsctOyYeGq24aghzkvptD+XVbn9Xq4Qx2
         yxJPdKckjUE2Le0UST7HQhi45E/yHrtn4L5mNNxo+7JL+AcIOJugxBvuaOWMfQaRKd19
         pgc7iEsvYu0XarG32KP1cibZw6Yh6odpoBcAbe/UiVxBTEh1uk9MrGBjI2ktk5L02xPX
         x9VA45PGyhIT4mZVHxYbG80ZMkQKYGWocfpS2nmfUWNgOvxc1mQu8MLaMnzS4vac3Qt1
         JBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OH2SjYe0B8esWxTAcCgR+62MsPomBC+RzRSTMU1rFk8=;
        b=TUyR+rqVaJspadU916/klyNUk0i8ONOlGv9SZsAV5s9HKza5n91keL9FcWiuFSWWxv
         Gd4eQABF9uuQ/3Rk6czEkkHKKfoaTH4LNdbLDBEjo/R/BQb8MTT9Ug+8NFPBEycuIPJB
         eKS3VR32pexg0JOVTPP596UhE6+UM9VmasM9pwTXNAEdwWEssQ7ISPhEMTg12n/4IDdY
         2mlEMVFqDhKRxIilPSFphCLY/pC/7OunV3HRiJCYBK04oH5fEO9JhPOLr+YCBZWaQb6Q
         6hUR5LzanT4jWQIMYe3sSN3tbLFubi5/R02RrAtx/RucGrPaEPF+AK0mf/cHro90BdcG
         DUsg==
X-Gm-Message-State: APjAAAVu8JcdFwcSSsU3brkkElPcmjrZfHzh0AzJqeVOR0gjxeEH7/nP
        oj4l8DvJp/gAZfYWR92SvsGmryi2H1I4U/diwME=
X-Google-Smtp-Source: APXvYqxFzno9MSXI4Ly95n1ixFuKJLy5PBpFiCEvi59EZLe1JMvD55HUp/RJhtm2+ZnxbDY2T+pgxUE1vx1ZzWw2zK4=
X-Received: by 2002:a67:ef0c:: with SMTP id j12mr9381038vsr.201.1572998180740;
 Tue, 05 Nov 2019 15:56:20 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:55:56 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 02/14] arm64/lib: copy_page: avoid x18 register in
 assembler code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Register x18 will no longer be used as a caller save register in the
future, so stop using it in the copy_page() code.

Link: https://patchwork.kernel.org/patch/9836869/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Sami: changed the offset and bias to be explicit]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/lib/copy_page.S | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index bbb8562396af..290dd3c5266c 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -34,45 +34,45 @@ alternative_else_nop_endif
 	ldp	x14, x15, [x1, #96]
 	ldp	x16, x17, [x1, #112]
 
-	mov	x18, #(PAGE_SIZE - 128)
+	add	x0, x0, #256
 	add	x1, x1, #128
 1:
-	subs	x18, x18, #128
+	tst	x0, #(PAGE_SIZE - 1)
 
 alternative_if ARM64_HAS_NO_HW_PREFETCH
 	prfm	pldl1strm, [x1, #384]
 alternative_else_nop_endif
 
-	stnp	x2, x3, [x0]
+	stnp	x2, x3, [x0, #-256]
 	ldp	x2, x3, [x1]
-	stnp	x4, x5, [x0, #16]
+	stnp	x4, x5, [x0, #16 - 256]
 	ldp	x4, x5, [x1, #16]
-	stnp	x6, x7, [x0, #32]
+	stnp	x6, x7, [x0, #32 - 256]
 	ldp	x6, x7, [x1, #32]
-	stnp	x8, x9, [x0, #48]
+	stnp	x8, x9, [x0, #48 - 256]
 	ldp	x8, x9, [x1, #48]
-	stnp	x10, x11, [x0, #64]
+	stnp	x10, x11, [x0, #64 - 256]
 	ldp	x10, x11, [x1, #64]
-	stnp	x12, x13, [x0, #80]
+	stnp	x12, x13, [x0, #80 - 256]
 	ldp	x12, x13, [x1, #80]
-	stnp	x14, x15, [x0, #96]
+	stnp	x14, x15, [x0, #96 - 256]
 	ldp	x14, x15, [x1, #96]
-	stnp	x16, x17, [x0, #112]
+	stnp	x16, x17, [x0, #112 - 256]
 	ldp	x16, x17, [x1, #112]
 
 	add	x0, x0, #128
 	add	x1, x1, #128
 
-	b.gt	1b
+	b.ne	1b
 
-	stnp	x2, x3, [x0]
-	stnp	x4, x5, [x0, #16]
-	stnp	x6, x7, [x0, #32]
-	stnp	x8, x9, [x0, #48]
-	stnp	x10, x11, [x0, #64]
-	stnp	x12, x13, [x0, #80]
-	stnp	x14, x15, [x0, #96]
-	stnp	x16, x17, [x0, #112]
+	stnp	x2, x3, [x0, #-256]
+	stnp	x4, x5, [x0, #16 - 256]
+	stnp	x6, x7, [x0, #32 - 256]
+	stnp	x8, x9, [x0, #48 - 256]
+	stnp	x10, x11, [x0, #64 - 256]
+	stnp	x12, x13, [x0, #80 - 256]
+	stnp	x14, x15, [x0, #96 - 256]
+	stnp	x16, x17, [x0, #112 - 256]
 
 	ret
 ENDPROC(copy_page)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

