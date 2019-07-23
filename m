Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76B571B05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbfGWPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:03:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfGWPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:03:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hpwJu-00078I-HM; Tue, 23 Jul 2019 15:03:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/isicom: remove redundant assignment to variable word_count
Date:   Tue, 23 Jul 2019 16:03:14 +0100
Message-Id: <20190723150314.14513-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable word_count is being assigned a value that is never read before
a return, the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/isicom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/isicom.c b/drivers/tty/isicom.c
index e04a43e89f6b..fc38f96475bf 100644
--- a/drivers/tty/isicom.c
+++ b/drivers/tty/isicom.c
@@ -553,7 +553,6 @@ static irqreturn_t isicom_interrupt(int irq, void *dev_id)
 
 	tty = tty_port_tty_get(&port->port);
 	if (tty == NULL) {
-		word_count = byte_count >> 1;
 		while (byte_count > 1) {
 			inw(base);
 			byte_count -= 2;
-- 
2.20.1

