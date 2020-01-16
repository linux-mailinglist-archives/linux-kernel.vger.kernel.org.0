Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2259013D141
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgAPAqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 19:46:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:23140 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgAPAqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:46:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 16:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="423805463"
Received: from unknown (HELO ubuntu) ([10.226.248.98])
  by fmsmga005.fm.intel.com with SMTP; 15 Jan 2020 16:46:41 -0800
Received: by ubuntu (sSMTP sendmail emulation); Thu, 16 Jan 2020 08:46:40 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     lftan.linux@gmail.com, Thor Thayer <thor.thayer@linux.intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH] MAINTAINERS: Remove nios2-dev@lists.rocketboards.org
Date:   Thu, 16 Jan 2020 08:46:38 +0800
Message-Id: <1579135598-57425-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2-dev@lists.rocketboards.org mailing list is no longer supported,
remove it from MAINTAINERS file.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7c7a89..e584217 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -721,7 +721,6 @@ F:	drivers/i2c/busses/i2c-altera.c
 
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <ley.foon.tan@intel.com>
-L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
@@ -749,14 +748,12 @@ F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 ALTERA TRIPLE SPEED ETHERNET DRIVER
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 L:	netdev@vger.kernel.org
-L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/net/ethernet/altera/
 
 ALTERA UART/JTAG UART SERIAL DRIVERS
 M:	Tobias Klauser <tklauser@distanz.ch>
 L:	linux-serial@vger.kernel.org
-L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/tty/serial/altera_uart.c
 F:	drivers/tty/serial/altera_jtaguart.c
@@ -11681,7 +11678,6 @@ F:	drivers/scsi/nsp32*
 
 NIOS2 ARCHITECTURE
 M:	Ley Foon Tan <ley.foon.tan@intel.com>
-L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
 S:	Maintained
 F:	arch/nios2/
-- 
2.7.4

