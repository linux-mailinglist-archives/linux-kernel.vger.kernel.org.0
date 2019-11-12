Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F51F9CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 23:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLWSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 17:18:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLWSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:18:35 -0500
Received: from zn.tnic (p200300EC2F0F7D00610FFA679789BEE6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:7d00:610f:fa67:9789:bee6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F25371EC0CBD;
        Tue, 12 Nov 2019 23:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573597114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq6+SEUVeJWGjZHtXLuf1kFyBIboQ7zLeTG3FELODMM=;
        b=SDLBJ8HJcTFjsrjmxI1Ql0zLbgEt/4TMquT7uaSNZvCy/QrHA7StIlaLLLCbEmivOG2gUh
        CKl7M0tEGXL5VScINH12Wt4/ZZrTll3kruydrWO17UMhvDAhLfdHauSPQLJ0AGxgu2RnOF
        1QZge4ZMZUEV2zuW+zx1/CvV2fnpjYs=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/cpu/tsx: Define pr_fmt()
Date:   Tue, 12 Nov 2019 23:18:23 +0100
Message-Id: <20191112221823.19677-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112221823.19677-1-bp@alien8.de>
References: <20191112221823.19677-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... so that all current and future pr_* statements in this file have the
proper prefix.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/tsx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 3e20d322bc98..1674c8da003e 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -14,6 +14,9 @@
 
 #include "cpu.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "tsx: " fmt
+
 enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
 
 void tsx_disable(void)
@@ -99,7 +102,7 @@ void __init tsx_init(void)
 			tsx_ctrl_state = x86_get_tsx_auto_mode();
 		} else {
 			tsx_ctrl_state = TSX_CTRL_DISABLE;
-			pr_err("tsx: invalid option, defaulting to off\n");
+			pr_err("invalid option, defaulting to off\n");
 		}
 	} else {
 		/* tsx= not provided */
-- 
2.21.0

