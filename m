Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9EFBBC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfIWTiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:38:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfIWTiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:38:04 -0400
Received: from zn.tnic (p200300EC2F060400F036B51F4D309BFC.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:f036:b51f:4d30:9bfc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82BFC1EC06F3;
        Mon, 23 Sep 2019 21:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569267483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=jq7kwN95yA0GegIm8GbXcl8cFgaETjDV8PvdovKWvps=;
        b=EnEs7dDfTbP+T0GshEshtVs+/S4ryIMSK1VssA/Y9IsmRXwTsY2jniKqwE4X/hBR4EFNnr
        vwW17hvqaEry75/ikiNPVmqU0eacppLWwYhnvCiYf2Y0GbD4R1ql/cYLDKStt0rx7efmUD
        FambLboS1fQhn7BAgsCXQ3sJ2LV6dec=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/nmi: Remove stale EDAC include leftover
Date:   Mon, 23 Sep 2019 21:38:07 +0200
Message-Id: <20190923193807.30896-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

db47d5f85646 ("x86/nmi, EDAC: Get rid of DRAM error reporting thru PCI SERR NMI")

forgot to remove it. Drop it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/traps.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f8447112..c90312146da0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,11 +37,6 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/io.h>
-
-#if defined(CONFIG_EDAC)
-#include <linux/edac.h>
-#endif
-
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>
-- 
2.21.0

