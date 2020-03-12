Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDE182CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 10:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCLJpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 05:45:05 -0400
Received: from poy.remlab.net ([94.23.215.26]:50916 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:45:05 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 05:45:04 EDT
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 10E535FA9A;
        Thu, 12 Mar 2020 10:38:47 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org
Subject: [PATCH] arm64: move kimage_vaddr to .rodata
Date:   Thu, 12 Mar 2020 11:38:46 +0200
Message-Id: <20200312093846.153235-1-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>

This datum is not referenced from .idmap.text: it does not need to be
mapped in idmap. Lets move it to .rodata as it is never written to after
early boot of the primary CPU.
(Maybe .data.ro_after_init would be cleaner though?)

Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
---
 arch/arm64/kernel/head.S | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6e08ee2b4d55..8e5c0e0040e4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -457,17 +457,19 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	b	start_kernel
 SYM_FUNC_END(__primary_switched)
 
+	.pushsection ".rodata", "a"
+SYM_DATA_START(kimage_vaddr)
+	.quad		_text - TEXT_OFFSET
+SYM_DATA_END(kimage_vaddr)
+EXPORT_SYMBOL(kimage_vaddr)
+	.popsection
+
 /*
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
 	.section ".idmap.text","awx"
 
-SYM_DATA_START(kimage_vaddr)
-	.quad		_text - TEXT_OFFSET
-SYM_DATA_END(kimage_vaddr)
-EXPORT_SYMBOL(kimage_vaddr)
-
 /*
  * If we're fortunate enough to boot at EL2, ensure that the world is
  * sane before dropping to EL1.
-- 
2.25.1

