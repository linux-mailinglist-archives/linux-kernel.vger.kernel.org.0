Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5A15BBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgBMJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:25:49 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42542 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbgBMJZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:25:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2Aka-0004Bp-Lc; Thu, 13 Feb 2020 17:25:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2AkZ-0006rf-OP; Thu, 13 Feb 2020 17:25:35 +0800
Date:   Thu, 13 Feb 2020 17:25:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     clabbe.montjoie@gmail.com, davem@davemloft.net, mripard@kernel.org,
        wens@csie.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: allwinner - remove redundant
 platform_get_irq error message
Message-ID: <20200213092535.buas6vaiusonkhrw@gondor.apana.org.au>
References: <20200205140130.164805-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205140130.164805-1-chenzhou10@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:01:30PM +0800, Chen Zhou wrote:
> Function dev_err() after platform_get_irq() is redundant because
> platform_get_irq() already prints an error.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
