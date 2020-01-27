Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC45714A33F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgA0LrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 06:47:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:12783 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgA0LrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:47:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="246370863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2020 03:47:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D38B814B; Mon, 27 Jan 2020 13:47:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/5] console: Drop double check for console_drivers being non-NULL
Date:   Mon, 27 Jan 2020 13:47:16 +0200
Message-Id: <20200127114719.69114-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to explicitly check for console_drivers to be non-NULL
since for_each_console() does this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
 kernel/printk/printk.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fada22dc4ab6..51337ed426e0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1772,9 +1772,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 
 	trace_console_rcuidle(text, len);
 
-	if (!console_drivers)
-		return;
-
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
 			continue;
@@ -2653,18 +2650,17 @@ void register_console(struct console *newcon)
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

