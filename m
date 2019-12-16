Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2327611F337
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLNR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 12:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:43 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24139214D8;
        Sat, 14 Dec 2019 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346263;
        bh=pK0dUWJUdkSxkkWr5E1mIw4trpWgO4Eu9FRrNyhUkKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2pYaSdPqU9LFmNk1jCppdM3xOP7HMsvJhIfMQ9ppCbkBLxevfAUA3ABlOnv5NRMj
         kdcodBP1lD9yTpEgnhk7+YFaAeatOKfj9a28Vq7ENGhbHFnk3Pp64bYNE34lah7eU2
         usq099UPa0UcBe+/6TSwXsriWb1KrhLgYaOg3z5U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 01/10] efi/libstub: remove unused __efi_call_early() macro
Date:   Sat, 14 Dec 2019 18:57:26 +0100
Message-Id: <20191214175735.22518-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro __efi_call_early() is defined by various architectures but
never used. Let's get rid of it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h   | 1 -
 arch/arm64/include/asm/efi.h | 1 -
 arch/x86/include/asm/efi.h   | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 7667826b93f1..2306ed783ceb 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -51,7 +51,6 @@ void efi_virtmap_unload(void);
 /* arch specific definitions used by the stub code */
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define __efi_call_early(f, ...)	f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(false)
 
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index b54d3a86c444..7cfac5e0e310 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -94,7 +94,6 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 }
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
-#define __efi_call_early(f, ...)	f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
 #define efi_is_64bit()			(true)
 
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index d028e9acdf1c..59c19e0b6027 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -233,9 +233,6 @@ static inline bool efi_is_64bit(void)
 	__efi_early()->call(efi_table_attr(efi_boot_services, f,	\
 		__efi_early()->boot_services), __VA_ARGS__)
 
-#define __efi_call_early(f, ...)					\
-	__efi_early()->call((unsigned long)f, __VA_ARGS__);
-
 #define efi_call_runtime(f, ...)					\
 	__efi_early()->call(efi_table_attr(efi_runtime_services, f,	\
 		__efi_early()->runtime_services), __VA_ARGS__)
-- 
2.17.1

