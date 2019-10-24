Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0D9E36AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503235AbfJXPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 11:30:12 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:45608 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503055AbfJXPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:30:11 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id HTW92100R5USYZQ06TW97y; Thu, 24 Oct 2019 17:30:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf3x-00078l-G2; Thu, 24 Oct 2019 17:30:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf3x-00082z-EK; Thu, 24 Oct 2019 17:30:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] x86/boot: Spelling s/disconect/disconnect/
Date:   Thu, 24 Oct 2019 17:30:08 +0200
Message-Id: <20191024153008.30892-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "disconnect".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/x86/boot/apm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/apm.c b/arch/x86/boot/apm.c
index b72fc10fc1beb5b8..bda15f9673d55862 100644
--- a/arch/x86/boot/apm.c
+++ b/arch/x86/boot/apm.c
@@ -60,7 +60,7 @@ int query_apm_bios(void)
 	intcall(0x15, &ireg, &oreg);
 
 	if ((oreg.eflags & X86_EFLAGS_CF) || oreg.bx != 0x504d) {
-		/* Failure with 32-bit connect, try to disconect and ignore */
+		/* Failure with 32-bit connect, try to disconnect and ignore */
 		ireg.al = 0x04;
 		intcall(0x15, &ireg, NULL);
 		return -1;
-- 
2.17.1

