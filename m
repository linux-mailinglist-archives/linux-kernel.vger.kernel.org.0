Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BF3103CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfKTNyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:54:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfKTNyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:54:22 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C54622310;
        Wed, 20 Nov 2019 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258062;
        bh=e4Hx2w9CUlEMUZpsptlAxS9898JO9B+VvzwEQN+NU2w=;
        h=From:To:Cc:Subject:Date:From;
        b=DnDVMSDqZSs+ymUoVPy297rCTEPftTas6C1s0DfSYZ3QQy0/XhxtmFfBLvTFeoQYj
         VTfcbBnJR1Wodt5LSSEbzrfuCADpMjronMJRRkIR+vxMpVu6sQzUeZ4qaYYLUw3rNn
         8LYrZ5+g30MgSyL5Vjnxkqc+dkSgNXafpyGnvFao=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>,
        kernel-janitors@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] arch: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:54:15 +0800
Message-Id: <20191120135415.18013-1-krzk@kernel.org>
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
 arch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3c6ec65596da..f6463f8b142f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -76,7 +76,7 @@ config JUMP_LABEL
        depends on HAVE_ARCH_JUMP_LABEL
        depends on CC_HAS_ASM_GOTO
        help
-         This option enables a transparent branch optimization that
+	 This option enables a transparent branch optimization that
 	 makes certain almost-always-true or almost-always-false branch
 	 conditions even cheaper to execute within the kernel.
 
@@ -84,7 +84,7 @@ config JUMP_LABEL
 	 scheduler functionality, networking code and KVM have such
 	 branches and include support for this optimization technique.
 
-         If it is detected that the compiler has support for "asm goto",
+	 If it is detected that the compiler has support for "asm goto",
 	 the kernel will compile such branches with just a nop
 	 instruction. When the condition flag is toggled to true, the
 	 nop will be converted to a jump instruction to execute the
-- 
2.17.1

