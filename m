Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6371FEB54F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfJaQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:48:00 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43702 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfJaQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id k7so4796960pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NvkEBCuGDFGmxutij1zSuSKxlsUUBaj5IQr0NLQJ5So=;
        b=Ru92iBuuYlPhHAFVLWeOs87kE0FiX1qHnTaOtpzTb/jKviPaXonwKKd+N66yjkRYuK
         cgnBq46YclvPXSguuBJeqzLri7jCCWWG2Dfk0n6Id4jZM2n7hZ/78QAEvq8GFPDPGfUD
         qNtrv8foscV0AHwaybS2313mz3Cil7NrOo8pDuPY6Jd1tSs6WarJ755+eSf/RomcChV4
         7A1jpdn6Ivzs9aO1uXSVTF6S5nlm17BU8Kojsg1aHJT+c27sDLV3569+F5xcQdMXNe/B
         BAiGEf7hztz5GyYBj6nLqE1P0Jc3Ye8dMxEAQ36afKH6zRhZp6NxcrpWbI9k75gVvReY
         hMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NvkEBCuGDFGmxutij1zSuSKxlsUUBaj5IQr0NLQJ5So=;
        b=JxQiqlfG2Yf/+EcPcCSSWmRsc/9aD2gLK2+epxAmAR1AkEBdQNWfGfpsAppDrh/cWN
         G9dO4hvd12QcFA1/g3pySI9ziH0d29sTjklGdY/1aCiDAqHt2WVCjt7GUqwrfWeNQgCo
         4zCB4YpIj0pSkrrVzULcAXU157HbODMSznmTafEdtM86SYeMWH8rH3fPQ4euvyVmpZnk
         C7fVc96z3Gc8JfMDPTuPz4o3Qcf1TDd/UK2Ng43zlh34uFyFHdYnFHAmr+VqFLw4C1O4
         5Nn3I3ind/Cj3OBeA36SPtIYfxrBvoSm9wdAstk9QsAa/feDxirk8MuNxmHHXzWwOxpw
         dblA==
X-Gm-Message-State: APjAAAXxLfgD9NZO4kcSC59V12lqRERnDFvazAl7DwxqKlFzpweL43XP
        pOZW3hdFZ+cpHmEMbg/i+OL8rIND11UhsYwAfow=
X-Google-Smtp-Source: APXvYqyQVapc0HQb2zNlrO9ACUIg0p0PZIO3eKHtqDUB9iKBoqT2ZxFgyWPN3wIre99JvuCaIlvEX84YwMN3a1ZjF+Y=
X-Received: by 2002:a63:d809:: with SMTP id b9mr7733622pgh.143.1572540408812;
 Thu, 31 Oct 2019 09:46:48 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:22 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 02/17] arm64/lib: copy_page: avoid x18 register in
 assembler code
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

Register x18 will no longer be used as a caller save register in the
future, so stop using it in the copy_page() code.

Link: https://patchwork.kernel.org/patch/9836869/
Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[ changed the offset and bias to be explicit ]
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
2.24.0.rc0.303.g954a862665-goog

