Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF3139120
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 13:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgAMMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 07:31:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39398 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:31:51 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iqysn-0005RE-Ej; Mon, 13 Jan 2020 12:31:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] drivers/misc: ti-st: remove redundant assignment to variables i and flags
Date:   Mon, 13 Jan 2020 12:31:49 +0000
Message-Id: <20200113123149.187555-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variables i and flags are being initialized with values that are
never read.  The initializations are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove assignment to flags too, thanks to Dan Carpenter for spotting that.

---
 drivers/misc/ti-st/st_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 2ae9948a91e1..14136d2cc8f9 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -736,8 +736,8 @@ static int st_tty_open(struct tty_struct *tty)
 
 static void st_tty_close(struct tty_struct *tty)
 {
-	unsigned char i = ST_MAX_CHANNELS;
-	unsigned long flags = 0;
+	unsigned char i;
+	unsigned long flags;
 	struct	st_data_s *st_gdata = tty->disc_data;
 
 	pr_info("%s ", __func__);
-- 
2.24.0

