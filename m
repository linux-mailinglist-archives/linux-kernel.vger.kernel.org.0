Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028FF15D0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 04:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBNDjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 22:39:53 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39356 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:39:53 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2RpT-0003Q5-2y; Fri, 14 Feb 2020 11:39:47 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2RpO-0008KC-8Z; Fri, 14 Feb 2020 11:39:42 +0800
Date:   Fri, 14 Feb 2020 11:39:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 1/2] crypto: engine - support for parallel requests
Message-ID: <20200214033942.uatozeoqzrhu7shq@gondor.apana.org.au>
References: <1581078974-14778-1-git-send-email-iuliana.prodan@nxp.com>
 <1581078974-14778-2-git-send-email-iuliana.prodan@nxp.com>
 <20200213061808.t6udjbgskc2hs7sa@gondor.apana.org.au>
 <AM0PR04MB717171C785D20ECC74B415638C150@AM0PR04MB7171.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB717171C785D20ECC74B415638C150@AM0PR04MB7171.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 01:25:50AM +0000, Iuliana Prodan wrote:
> 
> Given your suggestion, I’m thinking of implementing do_one_request, in 
> the driver, to return -IN_PROGRESS if the hw can enqueue more and -EBUSY 
> if otherwise (solution 1). But, this implies to update all the drivers 
> that use crypto-engine (something I wouldn’t mind doing, but I don’t 
> have the hw to test it).

We could always maintain a legacy interface for existing drivers
until they are all converted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
