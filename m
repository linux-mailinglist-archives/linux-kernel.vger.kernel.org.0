Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601D1CEE16
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 16:58:52 -0400
Received: from [165.204.78.2] ([165.204.78.2]:12957 "EHLO
        localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbfJGU6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:58:52 -0400
X-Greylist: delayed 613 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Oct 2019 16:58:52 EDT
Received: from localhost.localdomain (localhost [IPv6:::1])
        by localhost.localdomain (Postfix) with ESMTP id 775E6224EA78;
        Mon,  7 Oct 2019 15:48:39 -0500 (CDT)
Subject: [PATCH] x86/cpufeatures: Add feature bit RDPRU on AMD
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     fenghua.yu@intel.com, jpoimboe@redhat.com, aaronlewis@google.com,
        robert.hu@linux.intel.com, ak@linux.intel.com,
        thellstrom@vmware.com, linux-kernel@vger.kernel.org
Date:   Mon, 07 Oct 2019 15:48:39 -0500
Message-ID: <20191007204839.5727.10803.stgit@localhost.localdomain>
User-Agent: StGit/0.19-24-ge95d
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Zen 2 introduces new RDPRU instruction which is used to give access
to some processor registers that are typically only accessible when the
privilege level is zero.

ECX is used as the implicit register to specify which register to read.
RDPRU places the specified register’s value into EDX:EAX

For example, RDPRU instruction can be used to reading MPERF and APERF at
user level.

Adding this to cpu feature definition, so it is visible in /proc/cpuinfo.

Details are available in AMD64 Architecture Programmer’s Manual.
https://www.amd.com/system/files/TechDocs/24594.pdf

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0652d3e..5d2f1a7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -292,6 +292,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_RDPRU		(13*32+ 4) /* read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */

