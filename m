Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1540B103BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfKTNhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:37:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbfKTNhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:12 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563F422527;
        Wed, 20 Nov 2019 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257031;
        bh=89jwJ4YgSifTwu+8Hwfz7I1uOD0mYccjN2Q9h/yjSlQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XjvVHPkGi/BNuVPzwsbdOGxTyC9QGzdo3iQ/KXCGo6FAI5RK8b7r/Wa0xlGTtTPE+
         0TRDynFVqCR88V6gexS70y/cngObVOKQRry9Jr4JwERGXQiqE+NrQb7Pl9Jqlq7GeV
         af1udVCs5Q/lbYt3VRHg5CcxgZ+Wd+BfXwTASC2E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:08 +0800
Message-Id: <20191120133708.12011-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/powerpc/Kconfig.debug             | 18 +++++++++---------
 arch/powerpc/platforms/Kconfig.cputype |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c59920920ddc..4e1d39847462 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -122,8 +122,8 @@ config XMON_DEFAULT_RO_MODE
 	depends on XMON
 	default y
 	help
-          Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
-          'xmon=ro' override this default.
+	  Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
+	  'xmon=ro' override this default.
 
 config DEBUGGER
 	bool
@@ -222,7 +222,7 @@ config PPC_EARLY_DEBUG_44x
 	help
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.  If you enable this, ensure you set
-          PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
+	  PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
 
 config PPC_EARLY_DEBUG_40x
 	bool "Early serial debugging for IBM/AMCC 40x CPUs"
@@ -325,7 +325,7 @@ config PPC_EARLY_DEBUG_44x_PHYSLOW
 	default "0x40000200"
 	help
 	  You probably want 0x40000200 for ebony boards and
-          0x40000300 for taishan
+	  0x40000300 for taishan
 
 config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	hex "EPRN of early debug UART physical address"
@@ -359,9 +359,9 @@ config FAIL_IOMMU
 	  If you are unsure, say N.
 
 config PPC_PTDUMP
-        bool "Export kernel pagetable layout to userspace via debugfs"
-        depends on DEBUG_KERNEL && DEBUG_FS
-        help
+	bool "Export kernel pagetable layout to userspace via debugfs"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
 	  This option exports the state of the kernel pagetables to a
 	  debugfs file. This is only useful for kernel developers who are
 	  working in architecture specific areas of the kernel - probably
@@ -390,8 +390,8 @@ config PPC_DEBUG_WX
 
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
-        depends on DEBUG_KERNEL && PPC_BOOK3S_64
-        help
+	depends on DEBUG_KERNEL && PPC_BOOK3S_64
+	help
 	  If you're unsure what this is, say N.
 
 config KASAN_SHADOW_OFFSET
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 303752f97c19..d3dee3f5113b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -421,7 +421,7 @@ config PPC_PERF_CTRS
        def_bool y
        depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
        help
-         This enables the powerpc-specific perf_event back-end.
+	 This enables the powerpc-specific perf_event back-end.
 
 config FORCE_SMP
 	# Allow platforms to force SMP=y by selecting this
-- 
2.17.1

