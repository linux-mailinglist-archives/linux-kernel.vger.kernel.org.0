Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3A12902B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 23:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLVWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 17:22:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLVWW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 17:22:28 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ij9cH-0003Sn-FC; Sun, 22 Dec 2019 22:22:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: pti: remove redundant assignments to retval
Date:   Sun, 22 Dec 2019 22:22:24 +0000
Message-Id: <20191222222224.732340-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable retval is assigned with a value that is never read and
it is re-assigned a new value later on.  The assignment is redundant
and can be removed.  Clean up multiple occurrances of this pattern.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/pti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 063e4419cd7e..b7f510676cd6 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -792,7 +792,7 @@ static int pti_pci_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	unsigned int a;
-	int retval = -EINVAL;
+	int retval;
 	int pci_bar = 1;
 
 	dev_dbg(&pdev->dev, "%s %s(%d): PTI PCI ID %04x:%04x\n", __FILE__,
@@ -910,7 +910,7 @@ static struct pci_driver pti_pci_driver = {
  */
 static int __init pti_init(void)
 {
-	int retval = -EINVAL;
+	int retval;
 
 	/* First register module as tty device */
 
-- 
2.24.0

