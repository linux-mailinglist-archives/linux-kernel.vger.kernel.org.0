Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569AF444A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbfFMQij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:38:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:11951 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392729AbfFMQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:38:32 -0400
Received: from anisse-station.iliad.local (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 3D8A813F8F2;
        Thu, 13 Jun 2019 18:38:05 +0200 (CEST)
From:   Anisse Astier <aastier@freebox.fr>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@aerifal.cx>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Anisse Astier <aastier@freebox.fr>
Subject: [PATCH] arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl.h>
Date:   Thu, 13 Jun 2019 18:38:01 +0200
Message-Id: <20190613163801.21949-1-aastier@freebox.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise this will create userspace build issues for any program
(strace, qemu) that includes both <sys/prctl.h> (with musl libc) and
<linux/ptrace.h> (which then includes <asm/ptrace.h>), like this:

	error: redefinition of 'struct prctl_mm_map'
	 struct prctl_mm_map {

See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
for a public example of people working around this issue.

This fixes an UAPI regression introduced in commit 43d4da2c45b2
("arm64/sve: ptrace and ELF coredump support").

Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <aastier@freebox.fr>
---
 arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d78623acb649..03b6d6f029fc 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -65,8 +65,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/prctl.h>
-
 /*
  * User structures for general purpose, floating point and debug registers.
  */
@@ -113,10 +111,10 @@ struct user_sve_header {
 
 /*
  * Common SVE_PT_* flags:
- * These must be kept in sync with prctl interface in <linux/ptrace.h>
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
  */
-#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
-#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
+#define SVE_PT_VL_INHERIT		(1 << 1) /* PR_SVE_VL_INHERIT */
+#define SVE_PT_VL_ONEXEC		(1 << 2) /* PR_SVE_SET_VL_ONEXEC */
 
 
 /*
-- 
2.19.1

