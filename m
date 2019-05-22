Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324EA25EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 10:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfEVIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 04:04:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43316 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEVIEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:04:23 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTMEX-00080Q-GY; Wed, 22 May 2019 10:04:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     briannorris@chromium.org, ryandcase@chromium.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Mark that the rk3288 timer might stop in suspend
Date:   Wed, 22 May 2019 10:04:20 +0200
Message-ID: <1654629.mRIXxtDvp3@phil>
In-Reply-To: <20190521234933.153953-1-dianders@chromium.org>
References: <20190521234933.153953-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Mai 2019, 01:49:33 CEST schrieb Douglas Anderson:
> This is similar to commit e6186820a745 ("arm64: dts: rockchip: Arch
> counter doesn't tick in system suspend").  Specifically on the rk3288
> it can be seen that the timer stops ticking in suspend if we end up
> running through the "osc_disable" path in rk3288_slp_mode_set().  In
> that path the 24 MHz clock will turn off and the timer stops.
> 
> To test this, I ran this on a Chrome OS filesystem:
>   before=$(date); \
>   suspend_stress_test -c1 --suspend_min=30 --suspend_max=31; \
>   echo ${before}; date
> 
> ...and I found that unless I plug in a device that requests USB wakeup
> to be active that the two calls to "date" would show that fewer than
> 30 seconds passed.
> 
> NOTE: deep suspend (where the 24 MHz clock gets disabled) isn't
> supported yet on upstream Linux so this was tested on a downstream
> kernel.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3


