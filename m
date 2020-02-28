Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678B6172CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 01:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgB1ABW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 19:01:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgB1ABV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so469294plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVEfaBtq4P7YQEKJlB0rNIhGuSMdX7ZyWHWzM+iNj0k=;
        b=MiPZlyhhgfM7UPgKZ/frWvRzNlBB5613UuXaClOb+/1qj4My0rxjR2m0/Q68Aqjer2
         gZYS9YdvWjfD32foSE/T14ZSJwLXcxaxD5TFllT8NBx0vpNpvH9gXUcwAi9LBcMVYSoD
         GAqgi2ibQpd1tNuqjY7zAzuM2NwWtDPz6cTyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVEfaBtq4P7YQEKJlB0rNIhGuSMdX7ZyWHWzM+iNj0k=;
        b=fPSHNk5VZ/VxuqF2xxnvO/B96CIq7DKCy0zYLbI2ajj6cA6Ty+3Uuu/uXOavoziUz1
         CeE+WwN/x0cUqQZ5hTOrhgdWeHAkyIkmCvegP0XR3DzGL99AmqqJNixq0Q/IiaeGjex6
         dD13uLps2Kqrt2qseaNJN4yxBUWOgmBgLunpdiN1C0vGELD857verDs/6uAEKUazUINp
         d4hUyZ3gIaZuXRniPMS542H5ly+/5V4JxPC3wsWn2oJbehtpUHVA5XKtilMLP0qQKYih
         fUMIEXEorTlG4R2Mbu73FYrdQ2WI/ISmOVzjaxW1I26eQKX9YHds2bhlTQRtuY3kFEMX
         UxZA==
X-Gm-Message-State: APjAAAXZ3xbnC+A/6NfmUbeU2oavKpKShlyRofFRiQhpIRl9lOpSoOsY
        nNSCbOtujt7FhT+WxfN8c5SIcA==
X-Google-Smtp-Source: APXvYqymY4xDGLBpKhllQYQtdvp8eIxEJSyOvYMBEHU7xpDpUfih++1rH9KsvwXHUVBag4LFr8Qb4Q==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr1614784pjk.134.1582848081160;
        Thu, 27 Feb 2020 16:01:21 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:20 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/11] x86/CPU: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:51 -0800
Message-Id: <20200228000105.165012-7-thgarnie@chromium.org>
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
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 09705ccc393c..fdf6366c482d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -746,11 +746,13 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT
+		: : "cc", "memory");
 #endif
 }
 
-- 
2.25.1.481.gfbce0eb801-goog

