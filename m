Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09D802D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 00:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391588AbfHBWgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 18:36:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36326 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfHBWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:36:15 -0400
Received: from p508fd160.dip0.t-ipconnect.de ([80.143.209.96] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1htg9j-0005N8-FP; Sat, 03 Aug 2019 00:36:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] ARM: dts: rockchip: A few fixes for veyron-{fievel,tiger}
Date:   Sat, 03 Aug 2019 00:36:10 +0200
Message-ID: <3131503.0ZxQz3Vuye@phil>
In-Reply-To: <20190731151527.122002-1-mka@chromium.org>
References: <20190731151527.122002-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 31. Juli 2019, 17:15:27 CEST schrieb Matthias Kaehlcke:
> Fix/improve a few things for veyron fievel/tiger:
> 
> - move 'vccsys' regulator from tiger to fievel, both boards
>   have it (and tiger includes the fievel .dtsi)
> - move 'ext_gmac' node below regulators
> - fix GPIO ids of vcc5_host1 and vcc5_host2 regulators
> - remove reset configuration from 'gmac' node, this is already done
>   in rk3288.dtsi
> - fixed style issues of some multi-line comments
> - switch 'vcc18_lcdt', 'vdd10_lcd' and 'vcc33_ccd' regulators off
>   during suspend
> - no pull-up on the Bluetooth wake-up pin, there is an external
>   pull-up. The signal is active low, add the 'bt_host_wake_l'
>   pinctrl config
> - move BC 1.2 pins up in the pinctrl config to keep 'wake only' pins
>   separate
> - add BC 1.2 pins to sleep config
> 
> Fixes: 0067692b662e ("ARM: dts: rockchip: add veyron-fievel board")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.4

Thanks
Heiko


