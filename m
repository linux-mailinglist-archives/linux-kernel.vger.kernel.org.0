Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77427D08D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfGaWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 18:16:46 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41633 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbfGaWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:16:45 -0400
Received: by mail-pl1-f201.google.com with SMTP id i3so38351973plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=gMSAts35o/wnPODCro9DydMZX5y7p1KI0EhPMUuNYbyd5Q6Xxxy0tL/90yw+6/qQMj
         l9giTy0CijDgmA/xNQp8tpz9dJXEq7ZHBw3gHX4fMKITsYLeBVXKVVIfdulVbq3Peg3w
         1TyRbM+Rhhp85lz2YXYM+pwcYW01E767r909bQZxS1gcHPQc7p/oodSsz0ThkQlOlKHm
         ZbG6AATiMeGGcbzOk7aKYt2t/PNN56kMp7qxsWj5tSxTcaZIr/FUg24BjVgqRi3tVaLa
         ecwG54oEFOZzMaQ088eNT1XtbXcxzLAhwq7fC+roMT/tuZTDal1sDiD3x3VDkDdvwB4A
         d6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=sgCIrlCgEL6gDnjhTZxMy/EKO087V0uKamEfKVxzE4DKnG9zp37q1X0y27G+kxCT4h
         XSvVaa7pjiyGomIHtDNgsfeLzwBIVqR79HSgrUTzgbh9mct0wvMcQwKmBhPwapYSLmF/
         yrN7G+MAufjvhO+gAI5LaCTQR2Z3m4dvkCmycKcLqpKDRs4inuPt/WoJQKPad4myvQyX
         M0xi3s6VyUUapWO4KdNe/IyoNAxSWNWhAFdXMsykyjSmpjEauNTu3Itk0wvPcYkddd4h
         9ors0jg5D+R5mFIrrPyuKT9az0KJ7s8jSfYoqx4cJhhjbY8o0DZJF4ltk5m+bU2KIXE2
         /how==
X-Gm-Message-State: APjAAAUcqKaR2cZO4OJfeEFoSthOIAZhvEyzuU7wkz80tGsUGzF3gTOK
        QxLRhD0ioaxwjbQsqvT97EYv+x6gh2vK7+CA46NSeA==
X-Google-Smtp-Source: APXvYqyTX+qLDnmSpQam3pjkGQYBiZyG7S1znrHAEzFD0MX+bZTxK74CZsUoHaPZuUmDe6v6/5kjbS4vOej9Zu44WrYy9g==
X-Received: by 2002:a63:125c:: with SMTP id 28mr62619278pgs.255.1564611403845;
 Wed, 31 Jul 2019 15:16:43 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:55 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 07/29] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

Kexec reboot in case secure boot being enabled does not keep the secure
boot mode in new kernel, so later one can load unsigned kernel via legacy
kexec_load.  In this state, the system is missing the protections provided
by secure boot.

Adding a patch to fix this by retain the secure_boot flag in original
kernel.

secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
stub.  Fixing this issue by copying secure_boot flag across kexec reboot.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5ebcd02cbca7..d2f4e706a428 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -180,6 +180,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.22.0.770.g0f2c4a37fd-goog

