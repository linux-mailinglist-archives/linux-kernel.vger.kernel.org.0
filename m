Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B27150747
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgBCNbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 08:31:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:34156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgBCNbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="429443786"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2020 05:31:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75C8730C; Mon,  3 Feb 2020 15:31:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH v5 6/7] console: Don't notify user space when unregister non-listed console
Date:   Mon,  3 Feb 2020 15:31:29 +0200
Message-Id: <20200203133130.11591-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If console is not on the list then there is nothing for us to do
and sysfs notify is pointless.

Note, that nr_ext_console_drivers is being changed only for listed consoles.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: new patch

 kernel/printk/printk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5fdae891a4cd..abd9b92ae0e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2843,7 +2843,10 @@ int unregister_console(struct console *console)
 		}
 	}
 
-	if (!res && (console->flags & CON_EXTENDED))
+	if (res)
+		goto out_disable_unlock;
+
+	if (console->flags & CON_EXTENDED)
 		nr_ext_console_drivers--;
 
 	/*
@@ -2856,6 +2859,13 @@ int unregister_console(struct console *console)
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
+
+	return res;
+
+out_disable_unlock:
+	console->flags &= ~CON_ENABLED;
+	console_unlock();
+
 	return res;
 }
 EXPORT_SYMBOL(unregister_console);
-- 
2.24.1

