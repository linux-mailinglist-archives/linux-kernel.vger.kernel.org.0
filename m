Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE4150748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 14:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBCNbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 08:31:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:1860 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgBCNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="225163163"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2020 05:31:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 33AB614E; Mon,  3 Feb 2020 15:31:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/7] console: Don't perform test for CON_BRL flag
Date:   Mon,  3 Feb 2020 15:31:24 +0200
Message-Id: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't call braille_register_console() without CON_BRL flag set.
And the _braille_unregister_console() already tests for console to have
CON_BRL flag. No need to repeat this in braille_unregister_console().

Drop the repetitive checks from Braille console driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
v5: no change
 drivers/accessibility/braille/braille_console.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 1339c586bf64..a8f7c278b691 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -347,8 +347,6 @@ int braille_register_console(struct console *console, int index,
 {
 	int ret;
 
-	if (!(console->flags & CON_BRL))
-		return 0;
 	if (!console_options)
 		/* Only support VisioBraille for now */
 		console_options = "57600o8";
@@ -371,8 +369,6 @@ int braille_unregister_console(struct console *console)
 {
 	if (braille_co != console)
 		return -EINVAL;
-	if (!(console->flags & CON_BRL))
-		return 0;
 	unregister_keyboard_notifier(&keyboard_notifier_block);
 	unregister_vt_notifier(&vt_notifier_block);
 	braille_co = NULL;
-- 
2.24.1

