Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B696F714
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 04:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGVCEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 22:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfGVCEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 22:04:13 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D2321903;
        Mon, 22 Jul 2019 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563761052;
        bh=u4GMHX419j+/fLtW5nJhQiv+DYaZYYSo6Ud74Se+32w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4eZt8wEZuLZ+mtO0Xva01Eg3MwbuxFhCt6ub0uXmg4C8u8iJAf8GLjXsippu5hrw
         YmNDMAbU8IQpsERrOC1lKDFqKbnCLjQwhjdUMgjdWqT65aZLeH2FmptVZNFhPt7B9a
         2KUM0geVCoZk8PCaG0aSXV1AzqaSd9MlsCWPV5Yc=
Date:   Mon, 22 Jul 2019 10:03:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        Fabio Estevam <festevam@gmail.com>, aisheng.dong@nxp.com,
        l.stach@pengutronix.de, angus@akkea.ca, vabhav.sharma@nxp.com,
        pankaj.bansal@nxp.com, bhaskar.upadhaya@nxp.com, ping.bai@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Richard Hu <richard.hu@technexion.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: fsl: pico-pi: Add a device tree for the
 PICO-PI-IMX8M
Message-ID: <20190722020345.GR3738@dragon>
References: <20190625123407.15888-1-andradanciu1997@gmail.com>
 <20190718035523.GD11324@X250>
 <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNLGszB239AHpD+kRCPRWZaToTYHiq5YUHRjfRwTqknwHMdMA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 02:12:10PM +0300, Andra Danciu wrote:
...
> > > +     pmic: pmic@4b {
> > > +             reg = <0x4b>;
> > > +             compatible = "rohm,bd71837";
> > > +             /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > > +             pinctrl-0 = <&pinctrl_pmic>;
> > > +             gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
> >
> > Where is the bindings for this property?
> Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

I do not see property 'gpio_intr' in there.

Shawn
