Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD44015B3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgBLWg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 17:36:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39280 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgBLWg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:36:27 -0500
Received: from p508fd8fe.dip0.t-ipconnect.de ([80.143.216.254] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j20cF-0001ua-8B; Wed, 12 Feb 2020 23:36:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: rockchip: fix incorrect configuration of rk3228 aclk_gpu* clocks
Date:   Wed, 12 Feb 2020 23:36:18 +0100
Message-ID: <3638560.bLjz2vc75D@phil>
In-Reply-To: <20200114162503.7548-1-justin.swartz@risingedge.co.za>
References: <20200114162503.7548-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

Am Dienstag, 14. Januar 2020, 17:25:02 CET schrieb Justin Swartz:
> The following changes prevent the unrecoverable freezes and rcu_sched
> stall warnings experienced in each of my attempts to take advantage of
> lima.
> 
> Replace the COMPOSITE_NOGATE definition of aclk_gpu_pre with a
> COMPOSITE that retains the selection of HDMIPHY as the PLL source, but
> instead makes uses of the aclk_gpu PLL source gate and parent names
> defined by mux_pll_src_4plls_p rather than mux_aclk_gpu_pre_p.
> 
> Remove the now unused mux_aclk_gpu_pre_p and the four named but also
> unused definitions (cpll_gpu, gpll_gpu, hdmiphy_gpu and usb480m_gpu)
> of the aclk_gpu PLL source gate.
> 
> Use the correct gate offset for aclk_gpu and aclk_gpu_noc.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

thanks a lot for diving through the clock controller and fixing the
issues. I've checked against the TRM as well and the previous state
was quite wrong and your changes match the hardware manual.

I've applied it as fix for 5.6 now.

Thanks
Heiko


