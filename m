Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35917B937
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCFJ2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Mar 2020 04:28:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:59582 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgCFJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:28:05 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jA9Gj-0000Pu-CY; Fri, 06 Mar 2020 10:27:45 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@freebsd.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: Add initial support for Pinebook Pro
Date:   Fri, 06 Mar 2020 10:27:44 +0100
Message-ID: <4053849.MTJ45Pz6JY@diego>
In-Reply-To: <7a799284-92ab-ea04-285e-37d655064118@gmail.com>
References: <20200304213023.689983-2-t.schramm@manjaro.org> <6168222.Wuk326WHQK@phil> <7a799284-92ab-ea04-285e-37d655064118@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 6. März 2020, 08:22:00 CET schrieb Johan Jonker:
> Hi,
> 
> Missing #address-cells, #size-cells
> Can you still fix that?
> 
> On 3/6/20 1:23 AM, Heiko Stuebner wrote:
> > Am Mittwoch, 4. März 2020, 22:30:23 CET schrieb Tobias Schramm:
> >> This commit adds initial dt support for the rk3399 based Pinebook Pro.
> >>
> >> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> > 
> > applied for 5.7
> > 
> > Thanks
> > Heiko
> > 
> > 
> 
> > +&edp {
> > +	force-hpd;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&edp_hpd>;
> > +	status = "okay";
> > +
> > +	ports {
> 
> #address-cells = <1>;
> #size-cells = <0>;
> 
> Don't forget that extra empty line here.

The edp ports node does get its address+size cells already from the main
node in rk3399.dtsi, so isn't needed here.


Heiko

> 
> 
> > +		edp_out: port@1 {
> > +			reg = <1>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			edp_out_panel: endpoint@0 {
> > +				reg = <0>;
> > +				remote-endpoint = <&panel_in_edp>;
> > +			};
> > +		};
> > +	};
> > +};
> 
> 




