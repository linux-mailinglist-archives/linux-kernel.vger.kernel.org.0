Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F113BCBFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390097AbfJDPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:45:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42680 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389886AbfJDPp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:45:58 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPlz-0001XF-61; Sat, 05 Oct 2019 01:45:40 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:45:38 +1000
Date:   Sat, 5 Oct 2019 01:45:38 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 0/2] crypto: sun4i-ss: Enable power management
Message-ID: <20191004154538.GB5148@gondor.apana.org.au>
References: <20190924080832.18694-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924080832.18694-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:08:30AM +0200, Corentin Labbe wrote:
> Hello
> 
> This serie enables power management in the sun4i-ss driver.
> 
> Regards
> 
> Changes since v2 ( https://lore.kernel.org/linux-arm-kernel/20190919051035.4111-2-clabbe.montjoie@gmail.com/T/ ):
> - depends on PM
> - fusioned suspend/resume functions with sun4i_ssenable/disable
> - fixed style problem
> 
> Changes since v1:
> - Fixed style in patch #1
> - Check more return code of PM functions
> - Add PM support in hash/prng
> - reworked the probe order of PM functions and the PM strategy
> 
> Corentin Labbe (2):
>   crypto: sun4i-ss: simplify enable/disable of the device
>   crypto: sun4i-ss: enable pm_runtime
> 
>  drivers/crypto/Kconfig                    |   1 +
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c |  10 ++
>  drivers/crypto/sunxi-ss/sun4i-ss-core.c   | 139 ++++++++++++++++------
>  drivers/crypto/sunxi-ss/sun4i-ss-hash.c   |  12 ++
>  drivers/crypto/sunxi-ss/sun4i-ss-prng.c   |   9 +-
>  drivers/crypto/sunxi-ss/sun4i-ss.h        |   2 +
>  6 files changed, 133 insertions(+), 40 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
