Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F979483D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfFQNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 09:23:20 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:12941 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbfFQNXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:23:20 -0400
Received: from anisse-station.iliad.local (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id CDE8713F85F;
        Mon, 17 Jun 2019 15:22:49 +0200 (CEST)
From:   Anisse Astier <aastier@freebox.fr>
To:     Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@aerifal.cx>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Sasha Levin <sashal@kernel.org>,
        Anisse Astier <aastier@freebox.fr>
Subject: [PATCH v3 2/2] arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl.h>
Date:   Mon, 17 Jun 2019 15:22:22 +0200
Message-Id: <20190617132222.32182-2-aastier@freebox.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190617132222.32182-1-aastier@freebox.fr>
References: <20190617084545.GA38959@anisse-station>
 <20190617132222.32182-1-aastier@freebox.fr>
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

Copying the defines is a bit imperfect here, but better than creating a
whole other header for just two defines that would never change, as part
of the kernel ABI.

This patch depends on patch "arm64: ssbd: explicitly depend on
<linux/prctl.h>" for kernel >= 4.18

Fixes: 43d4da2c45b2 ("arm64/sve: ptrace and ELF coredump support")
Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <aastier@freebox.fr>
---
 arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 97c53203150b..e932284993d4 100644
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
+#define SVE_PT_VL_INHERIT		((1 << 17) /* PR_SVE_VL_INHERIT */ >> 16)
+#define SVE_PT_VL_ONEXEC		((1 << 18) /* PR_SVE_SET_VL_ONEXEC */ >> 16)
 
 
 /*
-- 
2.19.1

