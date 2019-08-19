Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F285C91C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 07:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHSFSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 01:18:42 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:56207 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHSFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:18:41 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d86 with ME
        id qtJc200090Dzhgk03tJcua; Mon, 19 Aug 2019 07:18:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Aug 2019 07:18:39 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: picoxcell - Fix the name of the module in the description of CRYPTO_DEV_PICOXCELL
Date:   Mon, 19 Aug 2019 07:18:33 +0200
Message-Id: <20190819051833.6622-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help section says that the module will be called 'pipcoxcell_crypto'.
This is likely a typo.
Use 'picoxcell_crypto' instead

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b8c50871f11b..2305416c2393 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -393,7 +393,7 @@ config CRYPTO_DEV_PICOXCELL
 	  Picochip picoXcell SoC devices. Select this for IPSEC ESP offload
 	  and for 3gpp Layer 2 ciphering support.
 
-	  Saying m here will build a module named pipcoxcell_crypto.
+	  Saying m here will build a module named picoxcell_crypto.
 
 config CRYPTO_DEV_SAHARA
 	tristate "Support for SAHARA crypto accelerator"
-- 
2.20.1

