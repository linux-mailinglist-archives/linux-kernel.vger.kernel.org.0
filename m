Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6DBE44B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 20:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439907AbfIYSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 14:09:16 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48189 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437914AbfIYSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:09:15 -0400
Received: by mail-pl1-f202.google.com with SMTP id g20so3847643plj.15
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=odWFUeVAN7YhnhW55GNbSGYhuzY85XxckGS+YUUU8WI=;
        b=djIhdg5BWH7ef9newhR0tqcOBZ0wsXX2JJpiGQGf85VKLkQzQdcuR6Rz1olvK9VsXE
         ZI1mIbSZxRutrrB3llL7jge/6ojfzrlkcMGIE3hLz0bi/q9D/PMLm70+XXXr7Sk9tgxe
         bAxvPRL4hy6gGNHuyPLMFDnGL4EEIYPammuj767IZVltt8hLb52Y+ZmT1kefeZoBoU/F
         H5M6LtLWAgOG8M/f9iClYJl8RgtV16HaTPr6F11rthhdnRzNUC94vqauJXCCKG89GSS3
         4X0NbADi0uEsQPRzKYtJtfg49CM30BXknPw4k2xTFnvMmn3ZPKjZ4nEQGHJ/KgxzD7cj
         zmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=odWFUeVAN7YhnhW55GNbSGYhuzY85XxckGS+YUUU8WI=;
        b=nZ3q/Q+J7vISCQaop3UzYAovkQgCbKG4kqJJwjnfeEKVy0rc80HkV8o2VrCNWHPuJb
         GjeU6Rosva5nzCQf2dRCi8ZWsVqsAkCBUx88VZ8iHja+SGtKokwoqHi9IlKDdxDi/ESq
         pAUjESLMCqHcqvXhLVSjY5zNyTZBt4ghlViD5g1fx7Tdo/GPnvnRi7UWAIo3WDvNmZfO
         97Digba+d2lnVkKT59HKb59qPe22oqogE9bisp2X+gCU8NJQJylcYKlbWdjGicVDODG2
         w3IJkC+VcOdw0OxtaOhfiNRlpe1gzwS7eDjMuEBo1zh9QIrE0+MUK4WBh2EngA97L25u
         /NKA==
X-Gm-Message-State: APjAAAX9J2RTvZ/Rl0TAqwkqKYx/ZYV1qarXTzBhce5RfSl9XrN3U91A
        V0pgHv/xmz5vCUubdc5GfROdt3QpXWBhSWXGMX0=
X-Google-Smtp-Source: APXvYqxjfGQuM6o0hLkh6Q4heaMTJQ9dFh+W1rfklsoSp6RxqVmJq3Jp8lOWvI8Zjt+9ABEA2t2V0tKqtJENzHt2+no=
X-Received: by 2002:a65:6285:: with SMTP id f5mr666067pgv.238.1569434953051;
 Wed, 25 Sep 2019 11:09:13 -0700 (PDT)
Date:   Wed, 25 Sep 2019 11:09:06 -0700
In-Reply-To: <20190925171025.GF3891@zn.tnic>
Message-Id: <20190925180908.54260-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190925171025.GF3891@zn.tnic>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3] x86, realmode: explicitly set entry via ENTRY in linker script
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     clang-built-linux@googlegroups.com, maskray@google.com,
        grimar@accesssoftek.com, ruiu@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linking with ld.lld via $ make LD=ld.lld produces the warning:
ld.lld: warning: cannot find entry symbol _start; defaulting to 0x1000

Linking with ld.bfd shows the default entry is 0x1000:
$ readelf -h arch/x86/realmode/rm/realmode.elf | grep Entry
  Entry point address:               0x1000

While ld.lld is being pedantic, just set the entry point explicitly,
instead of depending on the implicit default. The symbol pa_text_start
refers to the start of the .text section, which may not be at 0x1000 if
the preceding sections listed in arch/x86/realmode/rm/realmode.lds.S
were large enough. This matches behavior in arch/x86/boot/setup.ld.

Link: https://github.com/ClangBuiltLinux/linux/issues/216
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Peter Smith <Peter.Smith@arm.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/realmode/rm/realmode.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index 3bb980800c58..64d135d1ee63 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -11,6 +11,7 @@
 
 OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
+ENTRY(pa_text_start)
 
 SECTIONS
 {
-- 
2.23.0.351.gc4317032e6-goog

