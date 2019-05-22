Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD0264E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfEVNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 09:40:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfEVNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:40:55 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hTRUB-0002PK-69; Wed, 22 May 2019 15:40:51 +0200
Message-ID: <1558532450.2624.44.camel@pengutronix.de>
Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 22 May 2019 15:40:50 +0200
In-Reply-To: <AM0PR04MB6434B72679CD26C22FFB420BEE000@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190522131304.GA5692@bogon.m.sigxcpu.org>
         <AM0PR04MB6434B72679CD26C22FFB420BEE000@AM0PR04MB6434.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 22.05.2019, 13:30 +0000 schrieb Leonard Crestez:
> On 22.05.2019 16:13, Guido Günther wrote:
> > Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
> 
> Fixed subject
> 
> > On Wed, May 08, 2019 at 02:40:18PM +0200, Guido Günther wrote:
> > > Thanks for your comments. Let's try s.th. different then: identify by
> > > bootrom, ocotop and anatop and fall back to ATF afterwards (I'll split
> > > out the DT part and add binding docs if this makes sense). I'm also
> > > happy to drop the whole ATF logic until mailine ATF catched up:
> > > 
> > > The mainline ATF doesn't currently support the FSL_SIP_GET_SOC_INFO call
> > > nor does it have the code to identify different imx8mq SOC revisions so
> > > mimic what NXPs ATF does here.
> > 
> > Does this makes sense? If so I'll send this out as a series.
> 
> Mainline ATF has recently caught up:
> 
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/imx/imx8m/imx8mq/imx8mq_bl31_setup.c#n52
> 
> > > As a fallback use ATF so we can identify new revisions once it gains
> > > support or when using NXPs ATF.
> > 
> > I'm also fine with dropping the ATF part if we don't want to depend on
> > it in mainline.
> 
> Linux arm64 depends on ATF to implement power management via PSCI: 
> hotplug cpuidle and suspend.
> 
> It is not clear why Linux would avoid other services and insist on 
> reimplementing hardware workarounds.

I fully agree. We should not duplicate functionality between ATF and
Linux kernel. If the mainline ATF provides the facilities to do the SoC
identification the kernel should use them as the sole source to get
this information.

Regards,
Lucas
