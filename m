Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0514BA02
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 15:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbgA1Oeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 09:34:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:32996 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733177AbgA1Oe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:34:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 06:34:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="401673803"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2020 06:34:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 89BF513F; Tue, 28 Jan 2020 16:34:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Sort entries in database for VSPRINTF
Date:   Tue, 28 Jan 2020 16:34:25 +0200
Message-Id: <20200128143425.47283-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run parse-maintainers.pl and choose VSPRINTF record. Fix it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 211043d91cd0..4791757ba1ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17932,11 +17932,11 @@ M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
 S:	Maintained
-F:	lib/vsprintf.c
-F:	lib/test_printf.c
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
 F:	Documentation/core-api/printk-formats.rst
+F:	lib/test_printf.c
+F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
 M:	Juerg Haefliger <juergh@gmail.com>
-- 
2.24.1

