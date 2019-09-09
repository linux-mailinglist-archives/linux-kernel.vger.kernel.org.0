Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018ECAD3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 09:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbfIIHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 03:22:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:32838 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfIIHW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:22:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7E0e-0007BW-5B; Mon, 09 Sep 2019 17:22:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Sep 2019 17:22:47 +1000
Date:   Mon, 9 Sep 2019 17:22:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] crypto: caam - make sure clocks are enabled first
Message-ID: <20190909072247.GA18908@gondor.apana.org.au>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
 <20190904023515.7107-2-andrew.smirnov@gmail.com>
 <VI1PR0402MB3485E5EBBC1DCEF17103964898BA0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <20190909072155.GA18825@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190909072155.GA18825@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 05:21:55PM +1000, Herbert Xu wrote:
> On Fri, Sep 06, 2019 at 11:18:19AM +0000, Horia Geanta wrote:
> > On 9/4/2019 5:35 AM, Andrey Smirnov wrote:
> > > In order to access IP block's registers we need to enable appropriate
> > > clocks first, otherwise we are risking hanging the CPU.
> > > 
> > > The problem becomes very apparent when trying to use CAAM driver built
> > > as a kernel module. In that case caam_probe() gets called after
> > > clk_disable_unused() which means all of the necessary clocks are
> > > guaranteed to be disabled.
> > > 
> > > Coincidentally, this change also fixes iomap leak introduced by early
> > > return (instead of "goto iounmap_ctrl") in commit
> > > 41fc54afae70 ("crypto: caam - simplfy clock initialization")
> > > 
> > > Tested on ZII i.MX6Q+ RDU2
> > > 
> > > Fixes: 176435ad2ac7 ("crypto: caam - defer probing until QMan is available")
> > > Fixes: 41fc54afae70 ("crypto: caam - simplfy clock initialization")
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Horia Geantă <horia.geanta@nxp.com>
> > > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > Cc: linux-crypto@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > Tested-by: Horia Geantă <horia.geanta@nxp.com>
> > 
> > Considering this is a boot hang, in case this does not make into v5.4
> > I would appreciate appending:
> > Cc: <stable@vger.kernel.org>
> 
> This patch does not apply against cryptodev or crypto.

Nevermind, I was trying to apply patch 4 on top of patch 1 which
is why it didn't work.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
