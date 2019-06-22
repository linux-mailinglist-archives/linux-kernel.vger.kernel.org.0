Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C59AE4F22A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 02:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfFVAET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 20:04:19 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:53589 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFVAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:18 -0400
Received: by mail-vs1-f73.google.com with SMTP id b23so2862680vsl.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U/lZ7fD+T6IptDZssnUJlCZR7ScE9UF2AoyQTpT4HbA=;
        b=XGkLNU5iHH7hzuL0cMZIlVDgMLidEQIz9bIMGPNZmvYRjpXgd47gSC1YjKyllW0b8O
         n4cqGDaho8/zL2ugLBApVL0GUyu0YEL8OBR7cSVggwR6jMwP8RLdQ6EcnOB0cxkUrnFb
         TCFyfWFJfKOwNPWdM+oyTiN70K82MbhBazc+Z8WxdR50iyGJwYiDEFeWSlTIE2tIz5dl
         ckMEc++flsaUac43SpRMBhHvqhPoGsLYPEDC5/adpXWXeYSjKXtNWiJPMerIHawYHUsk
         VyZWbQoGyNCtK4zeJgDBeLYOPrK6v2onoPFnZJMQWgjLhlqzV4sYI1qdJTfUDSPGkPSt
         nZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U/lZ7fD+T6IptDZssnUJlCZR7ScE9UF2AoyQTpT4HbA=;
        b=LYutV3g46z+RpWq1Kn5ReiXlsAWGBlrHVsfi5WS6U11Reu0d6ZX7rTvcZaqMlMTNFz
         9cSqE9swQFjoDCSDjHO5MGca9iX0i1NP9Kc26zHw9ogok5fBKUI8/LACmpuXI1CUukbD
         dh5CEbuLtssDxvpqv515s+DpEV0ZYCuv9vX0lJNlJVYads+TbP6Dk6DwR1qT78ecH/tG
         tMJo64MKYuNl/91IR3FZ8QmVGzyNV4ZxltUAE/wfQ5r9vOHBrcMPOcNirG5LF5nPlpWp
         YBUjRIdNDP39dVtZN7ZQpiPqk9KNRSug2NBnHJ9HcRgHBzsPr2EFR4y1V7zc3Rqbzzcf
         Sa7w==
X-Gm-Message-State: APjAAAXXBzgKOmopxklgNYRH6n1rIjCRORgI7ckEqKkQMQu/Hpz0xscJ
        jMHtsXsvSFlMC+CK+hENpkdbK+65hM2aHVlfjNkfyA==
X-Google-Smtp-Source: APXvYqziUqgtWLgJrBADFFVvyKB2oLgiiIjHdoYuwv326vdxMw4s35iQ24bb3foHcyDzF6GLXkrPi9QxFNM1SCvcd+SeCw==
X-Received: by 2002:a1f:728b:: with SMTP id n133mr14793805vkc.84.1561161856703;
 Fri, 21 Jun 2019 17:04:16 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:35 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-7-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 06/29] kexec_load: Disable at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
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
cc: kexec@lists.infradead.org
---
 include/linux/security.h     | 1 +
 kernel/kexec.c               | 8 ++++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 200175c8605a..00a31ab2e5ba 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -84,6 +84,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_KEXEC,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 68559808fdfa..ec3f07a4b1c0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
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
index 565c87451f0f..08fcd8116db3 100644
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
2.22.0.410.gd8fdbe21b5-goog

