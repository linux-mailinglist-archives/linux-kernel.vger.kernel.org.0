Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8595263
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfHTASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:18:49 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43921 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbfHTASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:45 -0400
Received: by mail-pl1-f201.google.com with SMTP id go13so2937919plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=SvGMP+S6tMmZzB+fw4HPKsKm+2MzyO3OimsS0WVncAijxpLHKoBqaTGUEm9cRs2F3g
         JFUqTBIEbmfxGZMI708DrwMp7SC9bYp0+w98WIkUwTk7xD2TQ/plYib5XDtlmzInzPK4
         Bl15YFCF7X65kaqgC0Jq7joAWDh7/aaHOFj97YCrlK/WTgaq58IRXzDQei3jcJd9JEf1
         8zt90+b0w3jm7dsVXxx3U8USdMIbQTQegNG5MEYO04d4lN/NdioBvpCVsa65qQjwjwpJ
         bww+t43WooMK364Z+SmADURskaIOmMQDM/zOyPpKkUTMMVVLy5hhJzfDuMzR0cb4GqD2
         /bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=28L+ehB4vT7SQwhr1GVEAssWYqpFu3ff7CisXtvvxdY=;
        b=jvYY1nzfA9MTiq2nTxAWBrRYo+RdownRS3H0NlQhE/Yh1cwbBl7OwoWBF87Gj4NXqf
         UJEmwsQruRApFnEqbXDGZWAIn4gQc8zNsxyXCB9KQk8AUIPQ+2pNKj/IRC8uLt/MN44s
         ek7Gj/tNTbO6aufLLWCE9tOIOcCF+f7nTKFJYpTWl+Oq4cKC9sxuCpULZDFSCJtlH/Kj
         DpuKewq6c7NtM7q9XskvLvkr5xvKw/60GjMASCs2LfvI0WA7F61cCnvLWtJ/mh06zRAh
         kN7GcTlR6U3/u9kx5+aRyRCDq23DPRZ56Gwogo1AGl/SbKrhPu+4xNXUmm5u0U4Hn1i6
         OfUw==
X-Gm-Message-State: APjAAAV52V1c3UQygHLa/hUexMVQWJYhXILg65yZCCpV/nXTxU+/4i/6
        QgDZceL6kz7EpYjS9NEwBQztZgA69p+UQhsyrIIj3g==
X-Google-Smtp-Source: APXvYqwSAuJyFawiCWBPUfWSfl+ey1b0WgKBia9JeslWeeR5kptToofdPLL2GkFbfzP46jJ2hazqwwFcv+/poIq39PAY2Q==
X-Received: by 2002:a65:4304:: with SMTP id j4mr22959013pgq.419.1566260323884;
 Mon, 19 Aug 2019 17:18:43 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:49 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-14-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 13/29] x86/msr: Restrict MSR access when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
cc: x86@kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/x86/kernel/msr.c        | 8 ++++++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 3db2252b958d..1547be359d7f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/uaccess.h>
 #include <linux/gfp.h>
+#include <linux/security.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -79,6 +80,10 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	err = security_locked_down(LOCKDOWN_MSR);
+	if (err)
+		return err;
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -130,6 +135,9 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		err = security_locked_down(LOCKDOWN_MSR);
+		if (err)
+			break;
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
diff --git a/include/linux/security.h b/include/linux/security.h
index cd93fa5d3c6d..010637a79eac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -109,6 +109,7 @@ enum lockdown_reason {
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
 	LOCKDOWN_IOPORT,
+	LOCKDOWN_MSR,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8b7d65dbb086..b1c1c72440d5 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -24,6 +24,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
 	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

