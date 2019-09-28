Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF92EC1149
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfI1Q0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 12:26:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48204 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfI1Q0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 12:26:06 -0400
Received: from zn.tnic (p200300EC2F1EDB0090155002B4D741D2.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:db00:9015:5002:b4d7:41d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E7361EC02FE;
        Sat, 28 Sep 2019 18:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569687965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=+6s1DBHAGPooj8Ecm172XrcwKs5Pi1Nh83t7vj2jcCg=;
        b=sVGZeGKuMh6BPrEtGxYi1wBQISIhY6kvlE74n0mSsO+DGZEqjwILkV0QwYFmqlfEHy3W0p
        StCIHeWWINgApDAMxY1LlCkzFu9gcsUVcm2jf74jWpMh5orNMNOk9Vp6z84q5xXZu9zMXU
        k0EpM7xqAw48l6xYd2GV5AQElaBKfBU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode/amd: Fix two -Wunused-but-set-variable warnings
Date:   Sat, 28 Sep 2019 18:25:59 +0200
Message-Id: <20190928162559.26294-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The dummy variable is the high part of the microcode revision MSR which
is defined as reserved. Mark it unused so that W=1 builds don't trigger
the above warning.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a0e52bd00ecc..3f6b137ef4e6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -567,7 +567,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 void reload_ucode_amd(void)
 {
 	struct microcode_amd *mc;
-	u32 rev, dummy;
+	u32 rev, dummy __always_unused;
 
 	mc = (struct microcode_amd *)amd_ucode_patch;
 
@@ -673,7 +673,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy;
+	u32 rev, dummy __always_unused;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
-- 
2.21.0

