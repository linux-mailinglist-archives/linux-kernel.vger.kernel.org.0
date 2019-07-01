Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0063444F9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392794AbfFMQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:41:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50018 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbfFMG4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:56:16 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJeX-0006Dz-Pj; Thu, 13 Jun 2019 14:56:05 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJeT-00054D-Ad; Thu, 13 Jun 2019 14:56:01 +0800
Date:   Thu, 13 Jun 2019 14:56:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, ebiggers@google.com, rob.rice@broadcom.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH -next] crypto: bcm - Make some symbols static
Message-ID: <20190613065601.r4ppd5yhr2gkkw5c@gondor.apana.org.au>
References: <20190604145351.19392-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604145351.19392-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:53:51PM +0800, YueHaibing wrote:
> Fix sparse warnings:
> 
> drivers/crypto/bcm/cipher.c:99:6: warning: symbol 'BCMHEADER' was not declared. Should it be static?
> drivers/crypto/bcm/cipher.c:2096:6: warning: symbol 'spu_no_incr_hash' was not declared. Should it be static?
> drivers/crypto/bcm/cipher.c:4823:5: warning: symbol 'bcm_spu_probe' was not declared. Should it be static?
> drivers/crypto/bcm/cipher.c:4867:5: warning: symbol 'bcm_spu_remove' was not declared. Should it be static?
> drivers/crypto/bcm/spu2.c:52:6: warning: symbol 'spu2_cipher_type_names' was not declared. Should it be static?
> drivers/crypto/bcm/spu2.c:56:6: warning: symbol 'spu2_cipher_mode_names' was not declared. Should it be static?
> drivers/crypto/bcm/spu2.c:60:6: warning: symbol 'spu2_hash_type_names' was not declared. Should it be static?
> drivers/crypto/bcm/spu2.c:66:6: warning: symbol 'spu2_hash_mode_names' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/bcm/cipher.c |  8 ++++----
>  drivers/crypto/bcm/spu2.c   | 10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
