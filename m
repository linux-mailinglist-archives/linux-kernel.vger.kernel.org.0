Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A786186B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 13:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgCPMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 08:40:50 -0400
Received: from poy.remlab.net ([94.23.215.26]:34260 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgCPMkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:40:49 -0400
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 3F9035FD10;
        Mon, 16 Mar 2020 13:40:47 +0100 (CET)
From:   =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
To:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64/sdei: gather trampolines' .rodata
Date:   Mon, 16 Mar 2020 14:40:45 +0200
Message-Id: <20200316124046.103844-2-remi@remlab.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

This gathers the two bits of data together for clarity.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 arch/arm64/kernel/entry.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 24f828739696..af17fcb4aaea 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -859,6 +859,11 @@ SYM_CODE_END(tramp_exit_compat)
 #ifdef CONFIG_RANDOMIZE_BASE
 	.pushsection ".rodata", "a"
 	.align PAGE_SHIFT
+#ifdef CONFIG_ARM_SDE_INTERFACE
+SYM_DATA_START(__sdei_asm_trampoline_next_handler)
+	.quad	__sdei_asm_handler
+SYM_DATA_END(__sdei_asm_trampoline_next_handler)
+#endif
 SYM_DATA_START(__entry_tramp_data_start)
 	.quad	vectors
 SYM_DATA_END(__entry_tramp_data_start)
@@ -980,13 +985,6 @@ SYM_CODE_END(__sdei_asm_exit_trampoline)
 NOKPROBE(__sdei_asm_exit_trampoline)
 	.ltorg
 .popsection		// .entry.tramp.text
-#ifdef CONFIG_RANDOMIZE_BASE
-.pushsection ".rodata", "a"
-SYM_DATA_START(__sdei_asm_trampoline_next_handler)
-	.quad	__sdei_asm_handler
-SYM_DATA_END(__sdei_asm_trampoline_next_handler)
-.popsection		// .rodata
-#endif /* CONFIG_RANDOMIZE_BASE */
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
-- 
2.25.1

