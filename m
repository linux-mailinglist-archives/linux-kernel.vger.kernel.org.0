Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F61229D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLQL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:26:37 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:34748 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfLQL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:26:37 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihAzq-0004hI-9x; Tue, 17 Dec 2019 11:26:34 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1ihAzp-008qcP-R2; Tue, 17 Dec 2019 11:26:33 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     ben.dooks@codethink.co.uk
Cc:     Coly Li <colyli@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: crc64: include <linux/crc64.h> for 'crc64_be'
Date:   Tue, 17 Dec 2019 11:26:33 +0000
Message-Id: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crc64_be() is declared in <linux/crc64.h> so include
this where the symbol is defined to avoid the following
warning:

lib/crc64.c:43:12: warning: symbol 'crc64_be' was not declared. Should it be static?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Coly Li <colyli@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
---
 lib/crc64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/crc64.c b/lib/crc64.c
index 0ef8ae6ac047..f8928ce28280 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -28,6 +28,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/crc64.h>
 #include "crc64table.h"
 
 MODULE_DESCRIPTION("CRC64 calculations");
-- 
2.24.0

