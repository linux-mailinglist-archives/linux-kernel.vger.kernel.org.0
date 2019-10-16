Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC5D8FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfJPLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:45:26 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49635 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbfJPLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:45:26 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKhjx-00062v-JZ; Wed, 16 Oct 2019 12:45:17 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKhjw-000281-Ug; Wed, 16 Oct 2019 12:45:16 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: inside-secure - fix unexported warnings
Date:   Wed, 16 Oct 2019 12:45:12 +0100
Message-Id: <20191016114512.8138-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The safexcel_pci_remove, pcireg_rc and ofreg_rc are
not exported or declared externally so make them static.

This avoids the following sparse warnings:

drivers/crypto/inside-secure/safexcel.c:1760:6: warning: symbol 'safexcel_pci_remove' was not declared. Should it be static?
drivers/crypto/inside-secure/safexcel.c:1794:5: warning: symbol 'pcireg_rc' was not declared. Should it be static?
drivers/crypto/inside-secure/safexcel.c:1797:5: warning: symbol 'ofreg_rc' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/inside-secure/safexcel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 4ab1bde8dd9b..223d1bfdc7e6 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1757,7 +1757,7 @@ static int safexcel_pci_probe(struct pci_dev *pdev,
 	return rc;
 }
 
-void safexcel_pci_remove(struct pci_dev *pdev)
+static void safexcel_pci_remove(struct pci_dev *pdev)
 {
 	struct safexcel_crypto_priv *priv = pci_get_drvdata(pdev);
 	int i;
@@ -1791,10 +1791,10 @@ static struct pci_driver safexcel_pci_driver = {
 
 /* Unfortunately, we have to resort to global variables here */
 #if IS_ENABLED(CONFIG_PCI)
-int pcireg_rc = -EINVAL; /* Default safe value */
+static int pcireg_rc = -EINVAL; /* Default safe value */
 #endif
 #if IS_ENABLED(CONFIG_OF)
-int ofreg_rc = -EINVAL; /* Default safe value */
+static int ofreg_rc = -EINVAL; /* Default safe value */
 #endif
 
 static int __init safexcel_init(void)
-- 
2.23.0

