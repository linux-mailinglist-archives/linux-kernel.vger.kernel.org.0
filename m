Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFED01634E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEGMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 08:01:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34838 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEGMBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:01:04 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hNymM-0008IV-1L; Tue, 07 May 2019 14:01:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, amstan@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Remove bogus 'i2s_clk_out' from rk3288-veyron-mickey
Date:   Tue, 07 May 2019 14:01:01 +0200
Message-ID: <2275852.0beATWnSof@phil>
In-Reply-To: <20190503234814.230901-1-dianders@chromium.org>
References: <20190503234814.230901-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 4. Mai 2019, 01:48:14 CEST schrieb Douglas Anderson:
> The rk3288-veyron-mickey device tree overrides the default "i2s" clock
> settings to add the clock for "i2s_clk_out".
> 
> That clock is only present in the bindings downstream Chrome OS 3.14
> tree.  Upstream the i2s port bindings doesn't specify that as a
> possible clock.
> 
> Let's remove it.
> 
> NOTE: for other rk3288-veyron devices this clock is consumed by
> 'maxim,max98090'.  Presumably if this clock is needed for mickey it'll
> need to be consumed by something similar.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3 with Matthias' rb.

Thanks
Heiko


