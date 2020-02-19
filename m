Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1416382B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 01:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBSAJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 19:09:09 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43917 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBSAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:09:08 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so14293612pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ou3AmoAB4pAV4E8hHdrZJU8tYRoLaJy68OnSkjNriPk=;
        b=ExdFaXJLQUrLqD1cXdvV6V+f2pvG4gneydCqd14okgp/Waqa0Qii99gHccZPxv5u7T
         ful3UrQEJD0mlccXRaOv9ncjUpURLfgt1M2GftTdPAksHrqi4oP/mH8JmpSYvfwHIm7J
         e3+kj63xZtRB4dCYxQwR6HNmc35LUxGimjg5k2n2O8xxH439zv2/XtncK8lwRfMu5R+O
         u4llohrY6SlfXI9mRKQ2oYKubkIkauF/gn83zq1xPCFdbiaSThaYvjtA6Lb7Zay9qZ6q
         H8vw2D8eYgjNx+t+KvfMrj5S0vZf+h5Qmzl6mlBhwILCDL8Jf2+qBwxQma4EGN9GtIZX
         bJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ou3AmoAB4pAV4E8hHdrZJU8tYRoLaJy68OnSkjNriPk=;
        b=iCvVevbngt+plJgtQl5jBA6jYPJ/61fq7e8mjpIE82ID8cVzRsImcRmCXybSgmHy1g
         WRbFb+mOGPmbXHFAz0CW0WfyltqAUAYX1y6j9c0KjdwqlXv/TPl9wwf+xatrgvHZevaM
         42Ia60yHuOUeKMJc8dMFkiz0aCFXhk/nQRVn2rpb+JVuB17QK55XU7Skb322gxnrKaEl
         prcawqQpJ3kEBAse3u/1liFILb8tjToTmVcl23CNgzDFlzqTOAxsScEV9R5guywzDjdp
         adRf9BxRptSnFG1jQ0YhG0LpsE8bXfbjCdz+N58datJ643dC+wOJJA6eCVTfTbSLjvmw
         oKZw==
X-Gm-Message-State: APjAAAX3wF44+w6JT9x2C3Nq8U0Yi0krKE7kj/vvI/zuMZWIoZO0eXSH
        sG5IoelRO12t1c6DvMCTAoOxrkk+gEDJJN5QU9M=
X-Google-Smtp-Source: APXvYqwONz8h4AimAH0TTKyO3Bm5Hq6D70pRhoeCO2SJP39ItHHxl//O2KOBNiMiAvvC4x9LMa3MQfSB9GUboiWhKfY=
X-Received: by 2002:a63:30c2:: with SMTP id w185mr26462644pgw.307.1582070943849;
 Tue, 18 Feb 2020 16:09:03 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:17 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 12/12] efi/libstub: disable SCS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
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

Disable SCS for the EFI stub and allow x18 to be used.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 98a81576213d..dff9fa5a3f1c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -30,6 +30,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   $(call cc-option,-fno-stack-protector) \
 				   -D__DISABLE_EXPORTS
 
+#  remove SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.25.0.265.gbab2e86ba0-goog

