Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E10186F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEIIqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 04:46:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfEIIqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 04:46:19 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hOegx-00020s-6J; Thu, 09 May 2019 10:46:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Use clk_hw_get_rate() in MMC phase calculation
Date:   Thu, 09 May 2019 10:46:14 +0200
Message-ID: <23276655.4tYWeNrtuJ@phil>
In-Reply-To: <20190507204935.256982-1-dianders@chromium.org>
References: <20190507204935.256982-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Mai 2019, 22:49:35 CEST schrieb Douglas Anderson:
> When calculating the MMC phase we can just use clk_hw_get_rate()
> instead of clk_get_rate().  This avoids recalculating the rate.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


