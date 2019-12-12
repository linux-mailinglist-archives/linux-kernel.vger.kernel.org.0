Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD111D8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 22:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfLLVtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 16:49:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:9274 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfLLVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:49:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:49:09 -0800
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; 
   d="scan'208,223";a="208240156"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 13:49:09 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: Add feature flag for fast short rep movsb
Date:   Thu, 12 Dec 2019 13:49:08 -0800
Message-Id: <20191212214908.20185-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the Intel Optimization Reference Manual:

3.7.6.1 Fast Short REP MOVSB
Beginning with processors based on Ice Lake Client microarchitecture,
REP MOVSB performance of short operations is enhanced. The enhancement
applies to string lengths between 1 and 128 bytes long.  Support for
fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
[EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
in the REP STOS performance.

Add an X86_FEATURE_FSRM flag for this.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Net effect of this patch is just to make "fsrm" appear in the
flags section of /proc/cpuinfo. Maybe someone can look into whether
we should make copy routines that use "rep movsb" check for this
flag to optimize copies on older CPUs that don't have it?

 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0652d3eed9bd..ab441b15d582 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -356,6 +356,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
 #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
-- 
2.20.1

