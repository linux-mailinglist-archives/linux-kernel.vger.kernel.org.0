Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099AB109D02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfKZL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 06:28:51 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43084 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfKZL2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:28:51 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iZZ1O-0001yf-OA; Tue, 26 Nov 2019 19:28:42 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iZZ1I-000449-Pn; Tue, 26 Nov 2019 19:28:36 +0800
Date:   Tue, 26 Nov 2019 19:28:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: talitos - Fix build error by selecting LIB_DES
Message-ID: <20191126112836.tnim24tiafufe7z4@gondor.apana.org.au>
References: <201911240718.6RqTEBvE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911240718.6RqTEBvE%lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 07:42:21AM +0800, kbuild test robot wrote:
>
> All errors (new ones prefixed by >>):
> 
>    drivers/crypto/talitos.o: In function `crypto_des_verify_key':
> >> include/crypto/internal/des.h:31: undefined reference to `des_expand_key'

This patch should fix it.

---8<---
The talitos driver needs to select LIB_DES as it needs calls
des_expand_key.

Fixes: 9d574ae8ebc1 ("crypto: talitos/des - switch to new...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 43ed1b621718..91eb768d4221 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -289,6 +289,7 @@ config CRYPTO_DEV_TALITOS
 	select CRYPTO_AUTHENC
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
+	select CRYPTO_LIB_DES
 	select HW_RANDOM
 	depends on FSL_SOC
 	help
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
