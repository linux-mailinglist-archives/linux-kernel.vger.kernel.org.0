Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 289E816361
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfEGMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 08:03:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34952 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEGMDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:03:42 -0400
Received: from we0048.dip.tu-dresden.de ([141.76.176.48] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hNyot-0008KE-Sm; Tue, 07 May 2019 14:03:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        mka@chromium.org, amstan@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Make rk3288-veyron-minnie run at hs200
Date:   Tue, 07 May 2019 14:03:39 +0200
Message-ID: <4345663.CAMg3MOt9f@phil>
In-Reply-To: <20190503234142.228982-1-dianders@chromium.org>
References: <20190503234142.228982-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 4. Mai 2019, 01:41:42 CEST schrieb Douglas Anderson:
> As some point hs200 was failing on rk3288-veyron-minnie.  See commit
> 984926781122 ("ARM: dts: rockchip: temporarily remove emmc hs200 speed
> from rk3288 minnie").  Although I didn't track down exactly when it
> started working, it seems to work OK now, so let's turn it back on.
> 
> To test this, I booted from SD card and then used this script to
> stress the enumeration process after fixing a memory leak [1]:
>   cd /sys/bus/platform/drivers/dwmmc_rockchip
>   for i in $(seq 1 3000); do
>     echo "========================" $i
>     echo ff0f0000.dwmmc > unbind
>     sleep .5
>     echo ff0f0000.dwmmc > bind
>     while true; do
>       if [ -e /dev/mmcblk2 ]; then
>         break;
>       fi
>       sleep .1
>     done
>   done
> 
> It worked fine.
> 
> [1] https://lkml.kernel.org/r/20190503233526.226272-1-dianders@chromium.org
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


