Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF5150746
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 14:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgBCNbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 08:31:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:34156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgBCNbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:31:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="263418159"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2020 05:31:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7AF5F2CA; Mon,  3 Feb 2020 15:31:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 7/7] console: Introduce ->exit() callback
Date:   Mon,  3 Feb 2020 15:31:30 +0200
Message-Id: <20200203133130.11591-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
References: <20200203133130.11591-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some consoles might require special operations on unregistering.
For instance, serial console, when registered in the kernel,
keeps power on for entire time, until it gets unregistered.
Example of use:

	->setup(console):
		pm_runtime_get(...);

	->exit(console):
		pm_runtime_put(...);

For such cases to have a balance we would provide ->exit() callback.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: Return error code from ->exit() (Sergey)

 include/linux/console.h | 1 +
 kernel/printk/printk.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index f33016b3a401..7a140f4e5d0c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -148,6 +148,7 @@ struct console {
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
+	int	(*exit)(struct console *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
 	short	flags;
 	short	index;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index abd9b92ae0e3..43b5cb88c607 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2860,6 +2860,9 @@ int unregister_console(struct console *console)
 	console_unlock();
 	console_sysfs_notify();
 
+	if (console->exit)
+		res = console->exit(console);
+
 	return res;
 
 out_disable_unlock:
-- 
2.24.1

