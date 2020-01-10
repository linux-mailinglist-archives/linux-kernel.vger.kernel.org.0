Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04437136D16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgAJMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 07:31:45 -0500
Received: from foss.arm.com ([217.140.110.172]:43984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbgAJMbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:31:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11601063;
        Fri, 10 Jan 2020 04:31:44 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E0943F534;
        Fri, 10 Jan 2020 04:31:43 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH] arm: Fix Kexec compilation issue.
Date:   Fri, 10 Jan 2020 12:31:25 +0000
Message-Id: <20200110123125.51092-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To perform the reserve_crashkernel() operation kexec uses SECTION_SIZE to
find a memblock in a range.
SECTION_SIZE is not defined for nommu systems. Trying to compile kexec in
these conditions results in a build error:

  linux/arch/arm/kernel/setup.c: In function ‘reserve_crashkernel’:
  linux/arch/arm/kernel/setup.c:1016:25: error: ‘SECTION_SIZE’ undeclared
     (first use in this function); did you mean ‘SECTIONS_WIDTH’?
             crash_size, SECTION_SIZE);
                         ^~~~~~~~~~~~
                         SECTIONS_WIDTH
  linux/arch/arm/kernel/setup.c:1016:25: note: each undeclared identifier
     is reported only once for each function it appears in
  linux/scripts/Makefile.build:265: recipe for target 'arch/arm/kernel/setup.o'
     failed

Make KEXEC depend on MMU to fix the compilation issue.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba75e3661a41..bc99582bdc85 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1904,7 +1904,7 @@ config XIP_DEFLATED_DATA
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
-	depends on !CPU_V7M
+	depends on MMU
 	select KEXEC_CORE
 	help
 	  kexec is a system call that implements the ability to shutdown your
-- 
2.24.1

