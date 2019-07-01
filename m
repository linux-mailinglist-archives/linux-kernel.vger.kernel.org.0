Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22DC36CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 08:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFFG6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 02:58:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39098 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFG6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:58:06 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hYmLZ-00071d-Co; Thu, 06 Jun 2019 14:58:01 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hYmLV-0006mr-F1; Thu, 06 Jun 2019 14:57:57 +0800
Date:   Thu, 6 Jun 2019 14:57:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190606065757.4agqd4poer4rexri@gondor.apana.org.au>
References: <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au>
 <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
 <20190606063724.n77z7gaf32tmyxng@gondor.apana.org.au>
 <CAKv+Gu-YtKRsUYMMD_PNoFvrPpmwTD7fJNs64Q-34L8-TvucqA@mail.gmail.com>
 <20190606064603.lvde6dproqi3vwcq@gondor.apana.org.au>
 <CAKv+Gu-DokZ179_Gx8_20v_pQ3w_CARKdO0xdsO8CRZJG1uOqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-DokZ179_Gx8_20v_pQ3w_CARKdO0xdsO8CRZJG1uOqA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:53:10AM +0200, Ard Biesheuvel wrote:
>
> That same patch 'fixes' CBC, since CBC was never broken to begin with.
> The CTS driver does not have something like the auth_tag sharing the
> same cacheline with the IV, so CBC has always worked fine.

CBC is broken.  Any crypto API user is allowed to place the IV
in the same position relative to the src/dst buffer.  So the driver
must deal with it.

It's just that the CTR/ghash combo happened to expose this first.

> So I guess what you are after is a patch that, instead of dodging the
> issue by limiting the copy to CBC, does not perform the copy at all
> while anything is mapped for DMA? Then we can leave it up to the NXP
> engineers to fix CTR mode.

Right, we definitely need to fix it for CBC, probably in the way that
you suggested.

We should fix CTR too but at least it should be obviously broken as
the self-test should catch this case now.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
