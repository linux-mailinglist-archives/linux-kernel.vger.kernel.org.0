Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC46912A1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLXN3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 08:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLXN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 08:29:49 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2C520706;
        Tue, 24 Dec 2019 13:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577194189;
        bh=osjy2qK69yjAAQdkQOcZUurhniBODraBI82bAEFIyn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqRGLwnA/F+NR4PXaxTlOwffs4q+EPOPuckLk7tnEfFcupZszNKmW1NW6boLoxjhU
         GQ6X01ky+d4KSYBvnFc0oHbRhuiZ6pu/+5+j35BnGpITFbYAV8tGHdHaG0K6EAH4j9
         8xps0kTGjnVOxbzGGFlEookZQP9pVXKTCtCbEUmE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] x86/efistub: disable paging at mixed mode entry
Date:   Tue, 24 Dec 2019 14:29:09 +0100
Message-Id: <20191224132909.102540-4-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224132909.102540-1-ardb@kernel.org>
References: <20191224132909.102540-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI mixed mode entry code goes through the ordinary startup_32()
routine before jumping into the kernel's EFI boot code in 64-bit
mode. The 32-bit startup code must be entered with paging disabled,
but this is not documented as a requirement for the EFI handover
protocol, and so we should disable paging explicitly when entering
the kernel from 32-bit EFI firmware.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 58a512e33d8d..ee60b81944a7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -244,6 +244,11 @@ SYM_FUNC_START(efi32_stub_entry)
 	leal	efi32_config(%ebp), %eax
 	movl	%eax, efi_config(%ebp)
 
+	/* Disable paging */
+	movl	%cr0, %eax
+	btrl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
 	jmp	startup_32
 SYM_FUNC_END(efi32_stub_entry)
 #endif
-- 
2.20.1

