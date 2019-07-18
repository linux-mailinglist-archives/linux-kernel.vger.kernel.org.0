Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF906D53E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404176AbfGRTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 15:45:42 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42380 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404122AbfGRTpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:45:32 -0400
Received: by mail-pf1-f201.google.com with SMTP id 21so17195094pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=pXA0X1WYESnUxeTUYFiBCooMuuh4vW22b03ZXSm5zMUF8YBE6F9xjLpiSkz32ut3dV
         sVCzdtElGnDxQykLV1WTTmAb4YgbqMhw/hJhKNId5sf+lP1WkFe0DHEDbRiM4z2hfhLJ
         iK6U7KPrBHEEp8izpgpV6X73LDyuvV6V+9ToWMovS4380QxL1/U7mzutzATNB8OaZYHm
         Kh4FpkPv0Fv9auWT8s+aCImHbJyjCZGGXPxuA7yH/Mz+sBDaleVUmj4UhNsPTyHTjynY
         rYOMdVuEtQROB+t1c2KOrP0kx5v/9LJmd1xN+mRHEQjwWOj18vFW99Kt5KEGb6PYfMR2
         S60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1gkPgS/LUQWYTDhNcm4n5VtrDpueDO81OkRBGTKoxwg=;
        b=o1iLTrG6heUv8FQ3QiyBoQ0TZeyyVElrDAlTjEv6WWvCq53ZqB0ec+BBKGlKDID1L7
         7R89AxllMjEKoXw6V0cw9nSS2e3/WD8VjGZyvCzYf6cNaCpbBdHWNIHjZjgeEWVISFgJ
         qfVynVNDANjWUdnrwWO1zylXQIvuBCARZYyTwtxoI5xC9BadfDGDjQE9FhewX1kaHR5I
         soQRg2pHZxwl3f3umRtlpqfIihexKIMjBs7gtJdwqGav4ZIBwVo9jAQZi67BPlPDdhbn
         RhnoKLLT/2T+g17jym1QoXhbXM162BLfNXkSko0bS07ti1emWKxpBRxoxJSXm02z5MQY
         s+iw==
X-Gm-Message-State: APjAAAXADecHiRdgcNRpVH4+VA9l7496Qlwavp4z9n1VQlxG5Stqungj
        hL0DSZTmL6J3P3/2qaGD1YDVXTNIbQK/zM8/bgoyHw==
X-Google-Smtp-Source: APXvYqxwqkDrXVnqXgFX8V2quFdORdqeEDNkSG6F+hbmam7qsgt7IU5OHfo3gKWFROaZ4LnpcXcAdTeF5PDp8QS5kQDg+Q==
X-Received: by 2002:a63:24a:: with SMTP id 71mr24650403pgc.273.1563479131021;
 Thu, 18 Jul 2019 12:45:31 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:44:14 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-29-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 28/29] efi: Restrict efivar_ssdt_load when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

efivar_ssdt_load allows the kernel to import arbitrary ACPI code from an
EFI variable, which gives arbitrary code execution in ring 0. Prevent
that when the kernel is locked down.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..776f479e5499 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
+#include <linux/security.h>
 
 #include <asm/early_ioremap.h>
 
@@ -242,6 +243,11 @@ static void generic_ops_unregister(void)
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
 {
+	int ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
+
+	if (ret)
+		return ret;
+
 	if (strlen(str) < sizeof(efivar_ssdt))
 		memcpy(efivar_ssdt, str, strlen(str));
 	else
-- 
2.22.0.510.g264f2c817a-goog

