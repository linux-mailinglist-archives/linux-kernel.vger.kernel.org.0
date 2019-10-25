Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D37E4FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 17:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440639AbfJYPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 11:20:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35772 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440610AbfJYPUR (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 25 Oct 2019 11:20:17 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iO1Nn-0001gt-At; Fri, 25 Oct 2019 23:20:07 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iO1Nl-0007p5-6Z; Fri, 25 Oct 2019 23:20:05 +0800
Date:   Fri, 25 Oct 2019 23:20:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: ka-sa - fix __iomem on registers
Message-ID: <20191025152005.3mesb4toi3na5f2q@gondor.apana.org.au>
References: <20191015123604.28749-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015123604.28749-1-ben.dooks@codethink.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:36:04PM +0100, Ben Dooks wrote:
> Add __ioemm attribute to reg_rng to fix the following
> sparse warnings:
> 
> drivers/char/hw_random/ks-sa-rng.c:102:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:102:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:102:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:104:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:104:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:104:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:113:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:113:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:113:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:116:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:116:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:116:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:119:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:119:17:    expected void const volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:119:17:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:121:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:121:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:121:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:132:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:132:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:132:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:143:19: warning: incorrect type in argument 1 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:143:19:    expected void const volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:143:19:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:144:19: warning: incorrect type in argument 1 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:144:19:    expected void const volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:144:19:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:146:9: warning: incorrect type in argument 2 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:146:9:    expected void volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:146:9:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:160:25: warning: incorrect type in argument 1 (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:160:25:    expected void const volatile [noderef] <asn:2> *addr
> drivers/char/hw_random/ks-sa-rng.c:160:25:    got unsigned int *
> drivers/char/hw_random/ks-sa-rng.c:194:28: warning: incorrect type in assignment (different address spaces)
> drivers/char/hw_random/ks-sa-rng.c:194:28:    expected struct trng_regs *reg_rng
> drivers/char/hw_random/ks-sa-rng.c:194:28:    got void [noderef] <asn:2> *
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Acked-by:  Arnd Bergmann <arnd@arndb.de>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/char/hw_random/ks-sa-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
