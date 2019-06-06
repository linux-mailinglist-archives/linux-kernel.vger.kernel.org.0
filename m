Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197B3371B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfFFK3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:29:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFK3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:29:07 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYpdY-0003d7-6L; Thu, 06 Jun 2019 12:28:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] ARM: dts: rockchip: Switch to builtin HDMI DDC bus on rk3288-veyron
Date:   Thu, 06 Jun 2019 12:28:47 +0200
Message-ID: <1843069.a0lnjFrhvD@phil>
In-Reply-To: <20190502225336.206885-3-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org> <20190502225336.206885-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. Mai 2019, 00:53:34 CEST schrieb Douglas Anderson:
> Downstream Chrome OS kernels use the builtin DDC bus from dw_hdmi on
> veyron.  This is the only way to get them to negotiate HDCP.
> 
> Although HDCP isn't currently all supported upstream, it still seems
> like it makes sense to use dw_hdmi's builtin I2C.  Maybe eventually we
> can get HDCP negotiation working.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied patches 3 to 5 for 5.3

Thanks
Heiko


