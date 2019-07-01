Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3430863
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaGOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 02:14:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:45856 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaGOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:14:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWanm-00047N-Ga; Fri, 31 May 2019 14:14:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWank-00055C-3G; Fri, 31 May 2019 14:14:04 +0800
Date:   Fri, 31 May 2019 14:14:04 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
Message-ID: <20190531061403.3lzvddt3r2mrn2g2@gondor.apana.org.au>
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com>
 <20190530053421.keesqb54yu5w7hgk@gondor.apana.org.au>
 <VI1PR0402MB3485ADA3C4410D61191582A498180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAKv+Gu84HndAnkn7DU=ykjCokw_+bAHEcF0Rm12-hnXhVy2u_Q@mail.gmail.com>
 <VI1PR0402MB34859577A96645E890BD8F3198180@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190530132623.4h3y2bymv4uvfnms@gondor.apana.org.au>
 <VI1PR0402MB3485D7664F87D8C38FA8FD5C98190@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190531054250.p2bc3igiu4s7dmvk@gondor.apana.org.au>
 <VI1PR0402MB348582411F826968EBC59A8B98190@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB348582411F826968EBC59A8B98190@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 06:10:51AM +0000, Horia Geanta wrote:
>
> Driver is not touching the DMA mapped areas, the DMA API conventions are
> carefully followed.
> It's touching a virtual pointer that is not DMA mapped, that just happens to be
> on the same cache line with a DMA mapped buffer.

Well you can't control what the users give you so you must assume
that the virtual address always share a cacheline with the DMA
buffer.

That's why you must only operate on that virtual address either
before you DMA map or after you DMA unmap.  Virtual addresses
that you allocate yourself (including ones on the stack) are
obviously not subject to this restriction.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
