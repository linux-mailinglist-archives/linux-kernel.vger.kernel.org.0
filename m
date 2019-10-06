Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A628BCD246
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 16:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfJFO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 10:29:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55239 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJFO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 10:29:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iH7Xo-0002Vh-A0; Sun, 06 Oct 2019 14:29:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] ata: pata_artop: make arrays static const, makes object smaller
Date:   Sun,  6 Oct 2019 15:29:56 +0100
Message-Id: <20191006142956.23360-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const arrays on the stack but instead make them
static. Makes the object code smaller by 292 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
   6988	   3132	    128	  10248	   2808	drivers/ata/pata_artop.o

After:
   text	   data	    bss	    dec	    hex	filename
   6536	   3292	    128	   9956	   26e4	drivers/ata/pata_artop.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: fix up commit message

---
 drivers/ata/pata_artop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 3aa006c5ed0c..6bd2228bb6ff 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -100,7 +100,7 @@ static void artop6210_load_piomode(struct ata_port *ap, struct ata_device *adev,
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
-	const u16 timing[2][5] = {
+	static const u16 timing[2][5] = {
 		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 },
 		{ 0x0700, 0x070A, 0x0708, 0x0403, 0x0401 }
 
@@ -154,7 +154,7 @@ static void artop6260_load_piomode (struct ata_port *ap, struct ata_device *adev
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
-	const u8 timing[2][5] = {
+	static const u8 timing[2][5] = {
 		{ 0x00, 0x0A, 0x08, 0x33, 0x31 },
 		{ 0x70, 0x7A, 0x78, 0x43, 0x41 }
 
-- 
2.20.1

