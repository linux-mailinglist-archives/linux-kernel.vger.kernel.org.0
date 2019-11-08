Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82AF4EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 16:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKHPLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 10:11:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57706 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfKHPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:11:17 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iT5uq-00072n-MF; Fri, 08 Nov 2019 23:11:12 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iT5un-00072n-2J; Fri, 08 Nov 2019 23:11:09 +0800
Date:   Fri, 8 Nov 2019 23:11:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] crypto: amlogic - Use kmemdup in meson_aes_setkey()
Message-ID: <20191108151108.axg6mblvepkcr443@gondor.apana.org.au>
References: <20191029015523.126987-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029015523.126987-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:55:23AM +0000, YueHaibing wrote:
> Use kmemdup rather than duplicating its implementation
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
