Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E8E493E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438603AbfJYLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:08:39 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:34164 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392749AbfJYLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:08:39 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id Hn8b2100S5USYZQ01n8bdN; Fri, 25 Oct 2019 13:08:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-Lf; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvu3-0006Or-Vv; Fri, 25 Oct 2019 11:29:04 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Kosina <trivial@kernel.org>, Scott Wood <oss@buserror.net>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial resend] powerpc/booke: Spelling s/date/data/
Date:   Fri, 25 Oct 2019 11:29:01 +0200
Message-Id: <20191025092901.24560-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caching dates is never a good idea ;-)

Fixes: e7affb1dba0e9068 ("powerpc/cache: add cache flush operation for various e500")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 2b4f3ec0acf7d988..1d308780e0d31eb9 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -231,7 +231,7 @@ _GLOBAL(__setup_cpu_e5500)
 	blr
 #endif
 
-/* flush L1 date cache, it can apply to e500v2, e500mc and e5500 */
+/* flush L1 data cache, it can apply to e500v2, e500mc and e5500 */
 _GLOBAL(flush_dcache_L1)
 	mfmsr	r10
 	wrteei	0
-- 
2.17.1

