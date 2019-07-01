Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30FE36D24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFFHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 03:15:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40344 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFHP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:15:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hYmcq-0007Nm-Dd; Thu, 06 Jun 2019 15:15:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hYmcm-0006rO-E9; Thu, 06 Jun 2019 15:15:48 +0800
Date:   Thu, 6 Jun 2019 15:15:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190606071548.5dacz7dnpt2lyrtv@gondor.apana.org.au>
References: <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au>
 <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
 <20190606063724.n77z7gaf32tmyxng@gondor.apana.org.au>
 <CAKv+Gu-YtKRsUYMMD_PNoFvrPpmwTD7fJNs64Q-34L8-TvucqA@mail.gmail.com>
 <20190606064603.lvde6dproqi3vwcq@gondor.apana.org.au>
 <CAKv+Gu-DokZ179_Gx8_20v_pQ3w_CARKdO0xdsO8CRZJG1uOqA@mail.gmail.com>
 <20190606065757.4agqd4poer4rexri@gondor.apana.org.au>
 <VI1PR0402MB3485A016A2E5FDEE57EBF48198170@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3485A016A2E5FDEE57EBF48198170@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 07:10:06AM +0000, Horia Geanta wrote:
>
> Not really.
> I am in favor of using the HW to update the IV, which would work for all
> skcipher algorithms.
> I have the fix ready, will send it in a couple of days.

OK that would be interesting to see.  But I presume you are still
going to do a copy after the DMA unmap since you can't do DMA to
req->iv?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
