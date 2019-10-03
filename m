Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761B5CAD9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfJCRtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 13:49:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388833AbfJCRs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 684E01000;
        Thu,  3 Oct 2019 10:48:57 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 300563F739;
        Thu,  3 Oct 2019 10:48:56 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v5 6/6] lib: vdso: Remove CROSS_COMPILE_COMPAT_VDSO
Date:   Thu,  3 Oct 2019 18:48:38 +0100
Message-Id: <20191003174838.8872-7-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003174838.8872-1-vincenzo.frascino@arm.com>
References: <20191003174838.8872-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 was the last architecture using CROSS_COMPILE_COMPAT_VDSO config
option. With this patch series the dependency in the architecture has
been removed.

Remove CROSS_COMPILE_COMPAT_VDSO from the Unified vDSO library code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index cc00364bd2c2..9fe698ff62ec 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -24,13 +24,4 @@ config GENERIC_COMPAT_VDSO
 	help
 	  This config option enables the compat VDSO layer.
 
-config CROSS_COMPILE_COMPAT_VDSO
-	string "32 bit Toolchain prefix for compat vDSO"
-	default ""
-	depends on GENERIC_COMPAT_VDSO
-	help
-	  Defines the cross-compiler prefix for compiling compat vDSO.
-	  If a 64 bit compiler (i.e. x86_64) can compile the VDSO for
-	  32 bit, it does not need to define this parameter.
-
 endif
-- 
2.23.0

