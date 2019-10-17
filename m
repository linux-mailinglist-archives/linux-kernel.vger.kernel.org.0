Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A713DAB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502159AbfJQLtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:49:33 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:54117 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502148AbfJQLtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:49:32 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL4HY-0003yS-Lk; Thu, 17 Oct 2019 12:49:28 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL4HX-0002qP-Pw; Thu, 17 Oct 2019 12:49:27 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rapidio: fix missing include of  <linux/rio_drv.h>
Date:   Thu, 17 Oct 2019 12:49:23 +0100
Message-Id: <20191017114923.10888-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/rio_drv.h> for the missing declarations
of functions exported from this file. Fixes the following
sparse warnings:

drivers/rapidio/rio-driver.c:53:16: warning: symbol 'rio_dev_get' was not declared. Should it be static?
drivers/rapidio/rio-driver.c:70:6: warning: symbol 'rio_dev_put' was not declared. Should it be static?
drivers/rapidio/rio-driver.c:150:5: warning: symbol 'rio_register_driver' was not declared. Should it be static?
drivers/rapidio/rio-driver.c:169:6: warning: symbol 'rio_unregister_driver' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/rapidio/rio-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index 2d99a3712b72..72874153972e 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/rio.h>
 #include <linux/rio_ids.h>
+#include <linux/rio_drv.h>
 
 #include "rio.h"
 
-- 
2.23.0

