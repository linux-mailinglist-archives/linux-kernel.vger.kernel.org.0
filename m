Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD75F86CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 03:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKLCPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 21:15:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:35330 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfKLCPP (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Mon, 11 Nov 2019 21:15:15 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iULi1-0007XR-N1; Tue, 12 Nov 2019 10:15:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iULhz-0004Xt-II; Tue, 12 Nov 2019 10:15:07 +0800
Date:   Tue, 12 Nov 2019 10:15:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, cyrille.pitchen@atmel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH -next] crypto: atmel - Fix randbuild error
Message-ID: <20191112021507.y52sqecdaotqptcf@gondor.apana.org.au>
References: <20191111133901.19164-1-yuehaibing@huawei.com>
 <20191112021350.qu44becwmwom7ywu@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112021350.qu44becwmwom7ywu@gondor.apana.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:13:50AM +0800, Herbert Xu wrote:
>
> What we should do instead is turn DEV_ATMEL_AUTHENC into a bool,

Oh and DEV_ATMEL_AUTHENC should also depend on CRYPTO_DEV_ATMEL_AES
and lose all its selects.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
