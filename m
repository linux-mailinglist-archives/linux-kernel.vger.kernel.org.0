Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC2172CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgB1AB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:01:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40275 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgB1AB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so467287plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBSUTQnCJbQV5pLuilITF26DLiWa2/2BRxaonElBTNQ=;
        b=ffRKFmzsputibNvCgTe4Pi3ww1xoPkHdMAQDjclUSxqmZY4+B8q2nf8RNjriw9Jun8
         QhjORrkShnXbbpqxKBG/5Su6vB1b54AxLYFiIWsapbzv3qhMKXOF8fcrqkG/eiTa+yHW
         WFQkVpmaUq0W/I2eBjsIlKnDUM+QUKxZzz2Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBSUTQnCJbQV5pLuilITF26DLiWa2/2BRxaonElBTNQ=;
        b=GBqd8PB21v1540V+plRoQlQBUm5OjjxQTDRNrUTB2Wre8F9Eo+jZPdqTZ9mirnmWrb
         Vba0lbNrPdciYgv/xVee3HzckNuMkbMsbw6i2Vo4FANlMmv3mGAb6LM/2zIVpmu6393U
         GbRWiCxa/f8qCVnA+bKCcRaN9VacIelyxkEndv4vocbc5Hs6b8mzRMENV9l8+DQj+Y/U
         OrvvVYYQu2y74guqa3eF5uTIKyXH8PCI5wF7fegzP4IkcTKKSaJSMXDamIi6YRCZEPp8
         l02COVinJ3n4N2geLEeEZEqE6MyK3WrNYTruGQT7FyGt8c8WTjB6E/YXKIvH0aRKd6P8
         t+IA==
X-Gm-Message-State: APjAAAVngm75PynQuPfGLpwZEGgVP+kgR/96jlnM7BJ0sO4Vl3ZOGIZx
        hEfrbUzhYYtHt7QmM3GJnvEcTg==
X-Google-Smtp-Source: APXvYqzDwLydiJZoarH5wzoZjhL6Dn3ngsWTMAguCr0uuaAVQX0qWk1h8b0wS+NGFKCGYWdFG0VCCg==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr1626609pjv.100.1582848085161;
        Thu, 27 Feb 2020 16:01:25 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:24 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 09/11] x86/power/64: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:54 -0800
Message-Id: <20200228000105.165012-10-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 7918b8415f13..977b8ae85045 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,7 +23,7 @@
 #include <asm/frame.h>
 
 SYM_FUNC_START(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -116,7 +116,7 @@ SYM_FUNC_START(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.25.1.481.gfbce0eb801-goog

