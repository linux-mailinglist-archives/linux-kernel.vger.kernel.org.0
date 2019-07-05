Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773B55F5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfGDJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 05:48:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52915 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfGDJsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 05:48:01 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hiyLH-0002sf-TQ; Thu, 04 Jul 2019 11:47:51 +0200
Message-ID: <1562233671.6641.9.camel@pengutronix.de>
Subject: Re: [PATCH V2 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Thu, 04 Jul 2019 11:47:51 +0200
In-Reply-To: <DB3PR0402MB39167FBAA2A3867148063F83F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704092600.38015-1-Anson.Huang@nxp.com>
         <1562233305.6641.8.camel@pengutronix.de>
         <DB3PR0402MB39167FBAA2A3867148063F83F5FA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 09:46 +0000, Anson Huang wrote:
> Hi, Philipp
> 
> > On Thu, 2019-07-04 at 17:25 +0800, Anson.Huang@nxp.com wrote:
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > i.MX8MM can reuse i.MX8MQ's reset driver, update the compatible
> > > property and related info to support i.MX8MM.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > New patch.
> > > ---
> > >  Documentation/devicetree/bindings/reset/fsl,imx7-src.txt | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > index 13e0951..bc24c45 100644
> > > --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> > > @@ -7,7 +7,7 @@ controller binding usage.
> > >  Required properties:
> > >  - compatible:
> > >  	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
> > > -	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
> > > +	- For i.MX8MQ/i.MX8MM SoCs should be "fsl,imx8mq-src", "syscon"
> > 
> > Please still add the "fsl,imx8mm-src" for i.MX8MM, just in case a significant
> > difference is discovered later.
> 
> OK, then I will add a new line as below:
> 
> For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"

Yes, that looks good, thanks.

regards
Philipp
