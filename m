Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFD426F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfFLNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 09:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfFLNGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:06:49 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3D6208C2;
        Wed, 12 Jun 2019 13:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560344808;
        bh=DsWkt0w0Fpfud6LWAZJ165X9OtQWGb7tOtf9BfXLfYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCmFgQiYcmFEOhtz/2577ShRIuWetu+xN0/oDdDGwnMgrOE34sL8WZc1sWUcDQb/p
         GuZScr3rOS1wLoh/TnDQFDympPwV3cX4rJ2JpeZwR++cCHL+CSrxS8gCgFN9e7sqEy
         pJegmpPjjsOCJHdJc1mjWU14LHsjQq4v/MKLnWJk=
Date:   Wed, 12 Jun 2019 21:06:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7ulp: add crypto support
Message-ID: <20190612130602.GH11086@dragon>
References: <20190606080255.25504-1-horia.geanta@nxp.com>
 <20190612103926.GE11086@dragon>
 <VI1PR0402MB3485A573518D60A573BA55C298EC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0402MB3485A573518D60A573BA55C298EC0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:45:18AM +0000, Horia Geanta wrote:
> On 6/12/2019 1:40 PM, Shawn Guo wrote:
> > On Thu, Jun 06, 2019 at 11:02:55AM +0300, Horia Geantă wrote:
> >> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> >>
> >> Add crypto node in device tree for CAAM support.
> >>
> >> Noteworthy is that on 7ulp the interrupt line is shared
> >> between the two job rings.
> >>
> >> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> >> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> >> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> >> ---
> >>
> >> I've just realized that this patch should be merged through the crypto tree,
> >> else bisectability could be affected due to cryptodev-2.6
> >> commit 385cfc84a5a8 ("crypto: caam - disable some clock checks for iMX7ULP")
> >> ( https://patchwork.kernel.org/patch/10970017/ )
> >> which should come first.
> > 
> > I'm not sure I follow it.  This is a new device added to imx7ulp DT.
> > It's never worked before on imx7ulp.  How would it affect git bisect?
> > 
> Driver corresponding to this device (drivers/crypto/caam) has to be updated
> before adding the node in DT.
> Is there any guarantee wrt. merge order of the crypto and DT trees?

Do not merge DT changes until driver part hits mainline.

Shawn
