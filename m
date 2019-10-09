Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE6D133C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfJIPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 11:50:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfJIPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xTB9MslzzB0F5KW3M1C+wJKgHCO3oHuoENVSbmRi9/U=; b=NaGfnVf9Rz6Oqnpod4/niOtwX
        lFqaxyhhHoNAbPvpU3qz3WiE4rkibJOPnUTGZMhnnZHoQXT0GowkKZFTAs0cxzOj9MifiybbXzApj
        ibTB/WqX2oaMGrFHdAw3iomnG5hQZPoL5r85z89ElM5wg4wkEWeoVVoIKQ0Pl3LCOjiFlzt2XJAfo
        9bsQDh/RVHitGFnqd/8SpxrzPpnn44OTXJPQ6I6HK2eUm6BLSx1WHz521ssppPtZMTNhkcMPmmKzl
        3RAqpaAQ5WlIGfTww5HPqlUCYk9YS0XWoqubSG1f0KAm66IhetRehJ9u6Jpy7HJt3TTSbAci4RK6I
        6OIl2P4ZA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIEDV-0003nX-Hg; Wed, 09 Oct 2019 15:49:33 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc:     Antoine Tenart <antoine.tenart@free-electrons.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] crypto: inside-secure: fix build error for
 safexcel_hash.c
Message-ID: <6670b7d4-224c-cfd8-2cba-96a60ea98d1c@infradead.org>
Date:   Wed, 9 Oct 2019 08:49:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

safexcel_hash.c (CRYPTO_DEV_SAFEXCEL) needs to select CRYPTO_SM3.

Fixes this build error:

safexcel_hash.c:(.text+0x1b17): undefined reference to `sm3_zero_message_hash'

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 drivers/crypto/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20191009.orig/drivers/crypto/Kconfig
+++ linux-next-20191009/drivers/crypto/Kconfig
@@ -751,6 +751,7 @@ config CRYPTO_DEV_SAFEXCEL
 	select CRYPTO_SHA512
 	select CRYPTO_CHACHA20POLY1305
 	select CRYPTO_SHA3
+	select CRYPTO_SM3
 	help
 	  This driver interfaces with the SafeXcel EIP-97 and EIP-197 cryptographic
 	  engines designed by Inside Secure. It currently accelerates DES, 3DES and


