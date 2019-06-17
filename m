Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1FE48598
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfFQOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 10:36:20 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:41138 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:36:19 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id RqcD2000g3XaVaC06qcDTX; Mon, 17 Jun 2019 16:36:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsk1-0002Ij-82; Mon, 17 Jun 2019 16:36:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsk1-0001GQ-5r; Mon, 17 Jun 2019 16:36:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sparc64: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:36:12 +0200
Message-Id: <20190617143612.4810-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sparc/lib/NG4clear_page.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/NG4clear_page.S b/arch/sparc/lib/NG4clear_page.S
index 97e2678d042a3390..d91d6b5f2444aef6 100644
--- a/arch/sparc/lib/NG4clear_page.S
+++ b/arch/sparc/lib/NG4clear_page.S
@@ -27,4 +27,4 @@ NG4clear_user_page:	/* %o0=dest, %o1=vaddr */
 	retl
 	 nop
 	.size		NG4clear_page,.-NG4clear_page
-	.size		NG4clear_user_page,.-NG4clear_user_page
\ No newline at end of file
+	.size		NG4clear_user_page,.-NG4clear_user_page
-- 
2.17.1

