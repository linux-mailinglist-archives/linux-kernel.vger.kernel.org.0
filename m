Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE81ADCA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502674AbfJRQLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:11:30 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44697 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502587AbfJRQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:28 -0400
Received: by mail-pg1-f201.google.com with SMTP id z7so4583687pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAZH5b29Q7ARe7ApEbNubNt6T6v1C763yQTiGjc3PQk=;
        b=MU3xv8ySUWa8q2gpjX+qFLOwCKhVBxOWHnEJ3R9sBKpRssnEcrJMlv2k41DcBabefp
         YGOIRyOHtuLqhQjP/H6UeJPJ31HbWh9EpsVg0P4HVVdbNapzd4whA6CQO0jcE6HFqrZI
         pgFlyp8aklTxhdiWcaDBLc5CpmFKJZswMRP/d6udWasrZrb61oeIxbFInJG3ZOTF4sVk
         8JrRWRNQEQR/efYLvQF070upFjEKFVFMcnO8HN9mWGmqJ5+afIdNL+vr/Zp/pbDcSsCQ
         e4yhuM2R8kT/imgzLMvhUd7v/AWzMuvSo0KChcal0UxqcYxBSXGTsqlDEDweUlIG3qti
         24Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAZH5b29Q7ARe7ApEbNubNt6T6v1C763yQTiGjc3PQk=;
        b=Jch4J1Rpsk1l2Ab6xssJ+EfaFuxlOdOKkjENjVAz3LI4pcYt2mF4nRtmPMj1HqeyFw
         uigbI5U+YhLn94fkJH8Jvz7ovO/0VglWS6G3npnpN1gcsiCTvu1780N0ohfUkDR1TAZe
         d8iz+YGwnh0IOpmYqR20pALb5KxJdnqP3ABeU5S1Vu5FhCiZaRuYcAoR6xXzVtK6ffyT
         xdYyXfrMYzzGkjm/uzMXXzZ3wVXbIYOuAy/I1QK/mk/ieKu0ojLBrkJ2/2+JWDXxC9CO
         h3UQtCrO6u5eThiKtOtgJgdduOGvNdvuyzvIojnHfE+JHdHkbKh4ChZgy3lcghzlbVRp
         M2Hg==
X-Gm-Message-State: APjAAAVkXO5UqS1QodY5xEyLua1FGjFzNQiyG8DaEj/e7Gi8E50UW7Ff
        JzZ6h2NV0/DeOTctIpdhHK7w3nQr6b0L7HkxZAk=
X-Google-Smtp-Source: APXvYqxrZ7wEgagooCPTAQmdCRYdis4uNkIIYm64oppMcYVDpcyhHuDu43I31sdZRydHODqHUlaqbmkndVluNi8asAA=
X-Received: by 2002:a63:ff08:: with SMTP id k8mr10900425pgi.8.1571415087691;
 Fri, 18 Oct 2019 09:11:27 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:30 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 15/18] arm64: vdso: disable Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index dd2514bb1511..b23c963dd8df 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -19,7 +19,7 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
-
+ccflags-y += $(DISABLE_SCS)
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-- 
2.23.0.866.gb869b98d4c-goog

