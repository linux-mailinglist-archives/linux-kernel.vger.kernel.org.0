Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FE14A342
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 12:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgA0Lrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 06:47:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:38970 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbgA0LrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:47:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="305276384"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2020 03:47:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE785650; Mon, 27 Jan 2020 13:47:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] console: Introduce ->exit() callback
Date:   Mon, 27 Jan 2020 13:47:19 +0200
Message-Id: <20200127114719.69114-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consoles might require special operations on unregistering. For example,
serial console, when registered in the kernel, keeps power on for entire time,
until it gets unregistered. For such cases to have a balance we would provide
->exit() callback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: move callback out from console_lock (Sergey)
 include/linux/console.h | 1 +
 kernel/printk/printk.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index f33016b3a401..54759ad0c36b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -148,6 +148,7 @@ struct console {
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
+	void	(*exit)(struct console *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
 	short	flags;
 	short	index;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da6a9bdf76b6..6ca03d199132 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2853,6 +2853,10 @@ int unregister_console(struct console *console)
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
+
+	if (console->exit)
+		console->exit(console);
+
 	return res;
 }
 EXPORT_SYMBOL(unregister_console);
-- 
2.24.1

