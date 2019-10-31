Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3307CEB148
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfJaNeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbfJaNeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 689AAAEA7;
        Thu, 31 Oct 2019 13:34:06 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Joe Perches <joe@perches.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] MAINTAINERS: Add VSPRINTF
Date:   Thu, 31 Oct 2019 14:33:37 +0100
Message-Id: <20191031133337.9306-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk maintainers have been reviewing patches against vsprintf code last
few years. Most changes have been committed via printk.git last two years.

New group is used because printk() is not the only vsprintf() user.
Also the group of interested people is not the same.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..4181a83bd30a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17441,6 +17441,16 @@ S:	Maintained
 F:	drivers/net/vrf.c
 F:	Documentation/networking/vrf.txt
 
+VSPRINTF
+M:	Petr Mladek <pmladek@suse.com>
+M:	Steven Rostedt <rostedt@goodmis.org>
+M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
+S:	Maintained
+F:	lib/vsprintf.c
+F:	lib/test_printf.c
+F:	Documentation/core-api/printk-formats.rst
+
 VT1211 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.16.4

