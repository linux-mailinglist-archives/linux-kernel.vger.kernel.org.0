Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1C3721B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfFFKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:53:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37742 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfFFKxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:53:36 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYq1V-0003l3-NS; Thu, 06 Jun 2019 12:53:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, mka@chromium.org,
        seanpaul@chromium.org, Urja Rannikko <urjaman@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Remove 48 MHz PLL rate from rk3288
Date:   Thu, 06 Jun 2019 12:53:33 +0200
Message-ID: <4759206.qoGe4VK7Kb@phil>
In-Reply-To: <20190604223200.345-1-dianders@chromium.org>
References: <20190604223200.345-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 5. Juni 2019, 00:31:59 CEST schrieb Douglas Anderson:
> The 48 MHz PLL rate is not present in the downstream chromeos-3.14
> tree.  Looking at history, it was originally removed in
> <https://crrev.com/c/265810> ("CHROMIUM: clk: rockchip: expand more
> clocks support") with no explanation.  Much of that patch was later
> reverted in <https://crrev.com/c/284595> ("CHROMIUM: clk: rockchip:
> Revert more questionable PLL rates"), but that patch left in the
> removal of 48 MHz.  What I wrote in that patch:
> 
> > Note that the original change also removed the rate (48000000, 1,
> > 64, 32) from the table.  I have no idea why that was squashed in
> > there, but that rate was invalid anyway (it appears to have an out
> > of bounds NO).  I'm not putting that rate in.
> 
> Reading the TRM I see that NO is defined as
> - NO: 1, 2-16 (even only)
> ...and furthermore only 4 bits are assigned for NO-1, which means that
> the highest NO we could even represent is 16.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


