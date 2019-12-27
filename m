Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4EC12B3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfL0Kip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Dec 2019 05:38:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60258 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfL0Kip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 05:38:45 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikn0s-0007O6-GV; Fri, 27 Dec 2019 18:38:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikn0o-0005nC-B6; Fri, 27 Dec 2019 18:38:30 +0800
Date:   Fri, 27 Dec 2019 18:38:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH V3 1/3] crypto: caam: Add support for i.MX8M Mini
Message-ID: <20191227103830.savjawvuzjolpfuj@gondor.apana.org.au>
References: <20191218130616.13860-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218130616.13860-1-aford173@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 07:06:14AM -0600, Adam Ford wrote:
> The i.MX8M Mini uses the same crypto engine as the i.MX8MQ, but
> the driver is restricting the check to just the i.MX8MQ.
> 
> This patch expands the check for either i.MX8MQ or i.MX8MM.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
> ---
> V3:  No Change
> V2:  Expand the check that forces the setting on imx8mq to also be true for imx8mm
>      Explictly state imx8mm compatiblity instead of making it generic to all imx8m*
>       this is mostly due to lack of other hardware to test

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
