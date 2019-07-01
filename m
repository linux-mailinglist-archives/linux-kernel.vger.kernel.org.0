Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2A427D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408422AbfFLNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 09:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbfFLNjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:39:05 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FDC20B1F;
        Wed, 12 Jun 2019 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560346744;
        bh=WBC3kV6boUG4g0ISh+/Q4tHQr5heRL1XoT+RzTqjx/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jadukF9E0+CT+yi715fyqQx75FWd9SG+n5IHNuVSvny1BFdo4qJulitWVAdLiCDm+
         dcXCnRt5p2izrUGcxU0FBywUIVl/Ontpx0aG5VLMjFxYO/y/itjIGLAjNgZEx3fOin
         RQYkQugxl/iZJwGadx+LOtSpkmAkB3OGKlkVDxVE=
Date:   Wed, 12 Jun 2019 21:38:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel@ziswiler.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
Message-ID: <20190612132705.GJ11086@dragon>
References: <20190606090612.16685-1-igor.opaniuk@gmail.com>
 <3b84f3cc6cd5399f25ebd8e1c8559c58@agner.ch>
 <CAByghJZJzFN9c9V-o=SV0z07++RPqsB0R8MTsovbtLr3vqJgyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAByghJZJzFN9c9V-o=SV0z07++RPqsB0R8MTsovbtLr3vqJgyw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:49:03PM +0300, Igor Opaniuk wrote:
> Hi Stefan,
> 
> On Wed, Jun 12, 2019 at 3:17 PM Stefan Agner <stefan@agner.ch> wrote:
> >
> > On 06.06.2019 11:06, Igor Opaniuk wrote:
> > > From: Igor Opaniuk <igor.opaniuk@toradex.com>
> > >
> > > Allows to use the SD interface at a higher speed mode if the card
> > > supports it. For this the signaling voltage is switched from 3.3V to
> > > 1.8V under the usdhc1's drivers control.
> > >
> > > Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> > > ---
> > >  arch/arm/boot/dts/imx6ul.dtsi                  |  4 ++++
> > >  arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 11 +++++++++--
> > >  arch/arm/boot/dts/imx6ull-colibri.dtsi         |  6 ++++++
> > >  3 files changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> > > index fc388b84bf22..91a0ced44e27 100644
> > > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > > @@ -857,6 +857,8 @@
> > >                                        <&clks IMX6UL_CLK_USDHC1>,
> > >                                        <&clks IMX6UL_CLK_USDHC1>;
> > >                               clock-names = "ipg", "ahb", "per";
> > > +                             fsl,tuning-step= <2>;
> > > +                             fsl,tuning-start-tap = <20>;
> > >                               bus-width = <4>;
> > >                               status = "disabled";
> > >                       };
> > > @@ -870,6 +872,8 @@
> > >                                        <&clks IMX6UL_CLK_USDHC2>;
> > >                               clock-names = "ipg", "ahb", "per";
> > >                               bus-width = <4>;
> > > +                             fsl,tuning-step= <2>;
> > > +                             fsl,tuning-start-tap = <20>;
> > >                               status = "disabled";
> > >                       };
> > >
> > > diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > index 006690ea98c0..7dc7770cf52c 100644
> > > --- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > +++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> > > @@ -145,13 +145,20 @@
> > >  };
> > >
> > >  &usdhc1 {
> > > -     pinctrl-names = "default";
> > > +     pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> > >       pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
> > > -     no-1-8-v;
> > > +     pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
> > > +     pinctrl-2 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
> >
> > Should that not be pinctrl_usdhc1_200mhz?
> >
> 
> Correct, thanks for pointing this out.
> Taking into account that the patch was already accepted by Shawn, will
> send another to fix this typo ASAP (added to my todo list).

I just fixed it up on my branch.

Shawn
