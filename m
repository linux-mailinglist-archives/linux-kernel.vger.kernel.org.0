Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7B150749
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgBCNbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 08:31:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:34156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgBCNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="429443780"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2020 05:31:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43888149; Mon,  3 Feb 2020 15:31:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/7] console: Drop double check for console_drivers being non-NULL
Date:   Mon,  3 Feb 2020 15:31:25 +0200
Message-Id: <20200203133130.11591-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to explicitly check for console_drivers to be non-NULL
since for_each_console() does this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
v5: no change

 kernel/printk/printk.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 815739eb8406..21b1a5d5e5b0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1779,9 +1779,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 
 	trace_console_rcuidle(text, len);
 
-	if (!console_drivers)
-		return;
-
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
 			continue;
@@ -2660,18 +2657,17 @@ void register_console(struct console *newcon)
 	struct console_cmdline *c;
 	static bool has_preferred;
 
-	if (console_drivers)
-		for_each_console(bcon)
-			if (WARN(bcon == newcon,
-					"console '%s%d' already registered\n",
-					bcon->name, bcon->index))
-				return;
+	for_each_console(bcon) {
+		if (WARN(bcon == newcon, "console '%s%d' already registered\n",
+					 bcon->name, bcon->index))
+			return;
+	}
 
 	/*
 	 * before we register a new CON_BOOT console, make sure we don't
 	 * already have a valid console
 	 */
-	if (console_drivers && newcon->flags & CON_BOOT) {
+	if (newcon->flags & CON_BOOT) {
 		/* find the last or real console */
 		for_each_console(bcon) {
 			if (!(bcon->flags & CON_BOOT)) {
-- 
2.24.1

