Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E356D500
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfGRToj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:44:39 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53876 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391523AbfGRTof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:44:35 -0400
Received: by mail-pg1-f201.google.com with SMTP id t18so7274904pgu.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eu667FWqsyv1eiS+2MgLd1pI1Yi90NnjxQ1QKJHeSZs=;
        b=ohrtYog4gGPeInnSgPNEoQxrDXPaBrUloNn0kHObJFwMww/WL/1QitIjfRTdQ7Io3l
         3SFmno+zU0LHqnjj1iwf/EcXC0mkATM1jwJSktN3EWogC7qhjF9T+4Vc2XXS/dPtmlKX
         mz5jQECVWQ2KxykCHqcx7Q4Oj8ogBpTDoACnxdCUgqa3Ot4HPl0AkiJXF4fk6mY7//oL
         7PbCHo+Yh6dVRTJvVO6GMzSfDJ2XD8gX5qc9TCAmUHKXJA2d2DOUhz+oq/Fg4W64rGof
         PvjyvsAmKWx9isgpl4njBFhx7acc40bmEcgvG4s2a7Usp9NXUY50lVDgZ8lf+u3ipVh8
         +y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eu667FWqsyv1eiS+2MgLd1pI1Yi90NnjxQ1QKJHeSZs=;
        b=dH8yRuJCKUL4pm6SBJD4o9eb/maSKjy8wEYmSCpk/ZqyqyeJ+cUiGj90ugs770ydk0
         4QdBfj3pWQv3eHN/CPopnqb58G964JO6b243iW99SMUhoImh4GaOkDKOC7erEb4tTZ+5
         kkP6jtFkk53knP2NzwLGbGP1HQLFpDH2kD2xcKNFb0e9+/C/b4G8BpcPJZUELFvcZI+b
         zNpJ+64TjR8gBAQz0skkqE0U1nMTjImcw0GWePb8fhlnrxCru8uDYIP0rfBTdGuQKD+b
         flxrPxDcoyw7FylpcgvnY11NZ/5B+sEMkuGFt6ccpa+kZf4CWfJ4We6U5OYR34P3yVxd
         FP2g==
X-Gm-Message-State: APjAAAWRVraNksknDHayYg3LbYqJFle8wmnLfou0GqD7w5GsPy63CE1h
        /SP/2sEUxr7+6HGzTiD9p6yw3F96THh15Xu9fmlseQ==
X-Google-Smtp-Source: APXvYqz2hh3xf3NNVSMQwnKxLqxoPr5fEA/x4WWO1oTU5T/O29MD4PGWgIppNaZkbdLHJf6ADY0SDRBtGzSuhQYGFEqqag==
X-Received: by 2002:a65:500d:: with SMTP id f13mr48703316pgo.151.1563479074121;
 Thu, 18 Jul 2019 12:44:34 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:52 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

The kexec_load() syscall permits the loading and execution of arbitrary
code in ring 0, which is something that lock-down is meant to prevent. It
makes sense to disable kexec_load() in this situation.

This does not affect kexec_file_load() syscall which can check for a
signature on the image to be booted.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9458152601b5..69c5de539e9a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1b018f1a6e0d..bc933c0db9bf 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -205,6 +205,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
 	if (result < 0)
 		return result;
 
+	/*
+	 * kexec can be used to circumvent module loading restrictions, so
+	 * prevent loading in that case
+	 */
+	result = security_locked_down(LOCKDOWN_KEXEC);
+	if (result)
+		return result;
+
 	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index d2ef29d9f0b2..6f302c156bc8 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

