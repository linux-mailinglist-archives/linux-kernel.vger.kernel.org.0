Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050AB75916
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfGYUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 16:46:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39584 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfGYUqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:46:24 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqkd2-00020C-9t; Thu, 25 Jul 2019 22:46:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/5] ARM: dts: rockchip: consolidate veyron panel and backlight settings
Date:   Thu, 25 Jul 2019 22:46:18 +0200
Message-ID: <3741084.UeuVJec2DR@phil>
In-Reply-To: <20190725162642.250709-3-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org> <20190725162642.250709-3-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. Juli 2019, 18:26:39 CEST schrieb Matthias Kaehlcke:
> veyron jaq, jerry, minnie and speedy have mostly redundant regulator
> and pinctrl configurations for the panel/backlight. Consolidate these
> pieces in the eDP .dtsi.
> 
> Also change the default power supply for the panel to
> 'panel_regulator', instead of overriding it in all the board files.
> pinky is the only device that uses 'vcc33_lcd' (the prior default),
> so overwrite it in this case. pinky doesn't have a complete display
> configuration, to keep things as they were delete the common nodes
> that didn't exist previously in pinky's board file.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.4

Thanks
Heiko


