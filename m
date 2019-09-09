Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F5ADA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405084AbfIINzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 09:55:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33054 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405028AbfIINzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:55:51 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7K8j-0006ao-PO; Mon, 09 Sep 2019 23:55:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Sep 2019 23:55:29 +1000
Date:   Mon, 9 Sep 2019 23:55:29 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] crypto: caam - Cast to long first before pointer
 conversion
Message-ID: <20190909135529.GA13530@gondor.apana.org.au>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
 <20190904023515.7107-5-andrew.smirnov@gmail.com>
 <20190909074636.GA21024@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909074636.GA21024@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While storing an int in a pointer is safe the compiler is not
happy about it.  So we need some extra casting in order to make
this warning free.

Fixes: 1d3f75bce123 ("crypto: caam - dispose of IRQ mapping only...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 8a30bbd7f2aa..c5acd9e24e14 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -500,7 +500,7 @@ static int caam_jr_init(struct device *dev)
 
 static void caam_jr_irq_dispose_mapping(void *data)
 {
-	irq_dispose_mapping((int)data);
+	irq_dispose_mapping((unsigned long)data);
 }
 
 /*
@@ -558,7 +558,7 @@ static int caam_jr_probe(struct platform_device *pdev)
 	}
 
 	error = devm_add_action_or_reset(jrdev, caam_jr_irq_dispose_mapping,
-					 (void *)jrpriv->irq);
+					 (void *)(unsigned long)jrpriv->irq);
 	if (error)
 		return error;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
