Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB7816C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfHEKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 06:17:20 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:52172 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfHEKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:17:19 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 0F71210089E14;
        Mon,  5 Aug 2019 18:17:17 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id F0F422042423F;
        Mon,  5 Aug 2019 18:17:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hJCk14iFE37W; Mon,  5 Aug 2019 18:17:16 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id CB5602042423E;
        Mon,  5 Aug 2019 18:17:16 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     lftan@altera.com, rppt@linux.vnet.ibm.com,
        nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] nios2: force the string buffer NULL-terminated
Date:   Mon,  5 Aug 2019 18:17:12 +0800
Message-Id: <20190805101712.22580-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() does not ensure NULL-termination when the input string
size equals to the destination buffer size COMMAND_LINE_SIZE.
Besides, grep under arch/ with 'boot_command_line' shows
no other arch-specific code uses strncpy() when copying
boot_command_line.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 arch/nios2/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 6bbd4ae2beb0..4cf35b09c0ec 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -123,7 +123,7 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 		dtb_passed = r6;
 
 		if (r7)
-			strncpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
+			strlcpy(cmdline_passed, (char *)r7, COMMAND_LINE_SIZE);
 	}
 #endif
 
@@ -131,10 +131,10 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 #ifndef CONFIG_CMDLINE_FORCE
 	if (cmdline_passed[0])
-		strncpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, cmdline_passed, COMMAND_LINE_SIZE);
 #ifdef CONFIG_NIOS2_CMDLINE_IGNORE_DTB
 	else
-		strncpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
 #endif
 
-- 
2.11.0

