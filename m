Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E226ED6B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 01:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfKDAvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 19:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfKDAvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:51:37 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA170222CA;
        Mon,  4 Nov 2019 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572828697;
        bh=0cPXrS85ZFNq0IkzMuelys/+Yk/AanMHiImMkP3vTHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3fcrd5RjNk9WJIl1Kea4MTeMZiT4hoj6uZT561YIM3GlTk4L7qfgmg3wuE+tPP+q
         X8co1KYv/PjnTvUgn2VaSwmcQpANSmp+qPg4UXaVci9e4A77T2sS9gEKKTr91FlY/k
         +ifsMR1p3pkJ/2yfSDMz6OVuegJIP/F96NwuS/c4=
Date:   Mon, 4 Nov 2019 08:51:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Message-ID: <20191104005108.GB24620@dragon>
References: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 06:59:51PM +0000, Leonard Crestez wrote:
> On 21.10.2019 13:19, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > We should not rely on bootloader to configure the phy reset.
> > So introduce phy-reset-gpios property to let Linux handle phy reset
> > itself.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> This broke NFS boot for me in next-20191031: board now hangs on DHCP.

I dropped both patches for now.

Shawn

> 
> It can be fixed by reverting this DT patch or by setting 
> CONFIG_AT803X_PHY to y instead of m.
> 
> Needing a phy module is not a bug but everybody will need to either 
> adjust .config or build modules into an initramfs somehow.
