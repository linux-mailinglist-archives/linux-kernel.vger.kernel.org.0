Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE1717C5F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 20:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCFTJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Mar 2020 14:09:25 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35526 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFTJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:09:25 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jAILK-0002nL-U7; Fri, 06 Mar 2020 20:09:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>,
        Alexis Ballier <aballier@gentoo.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nick Xie <nick@khadas.com>, Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: Add initial support for Pinebook Pro
Date:   Fri, 06 Mar 2020 20:09:05 +0100
Message-ID: <1783248.GgDFSgCcj8@diego>
In-Reply-To: <b30fef29-6667-9200-178b-4d0e9fc63c12@manjaro.org>
References: <20200304213023.689983-2-t.schramm@manjaro.org> <6168222.Wuk326WHQK@phil> <b30fef29-6667-9200-178b-4d0e9fc63c12@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

Am Freitag, 6. März 2020, 19:58:45 CET schrieb Tobias Schramm:
> Hi Heiko,
> 
> >> This commit adds initial dt support for the rk3399 based Pinebook Pro.
> >>
> >> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> >
> > applied for 5.7
> >
> 
> any chance you can squeeze in another small fix? Somewhere in the
> process the vmcc and vqmmc supplies of the sdmmc controller were removed
> in error. Those should be added to the sdmmc controller like this:
> 
>  &sdmmc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
>         sd-uhs-sdr104;
> +       vmmc-supply = <&vcc3v0_sd>;
> +       vqmmc-supply = <&vcc_sdio>;
>         status = "okay";
>  };

I've amended the commit with these two properties.

Heiko


