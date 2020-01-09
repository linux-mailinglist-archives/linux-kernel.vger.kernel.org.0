Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8086F135057
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgAIAPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 19:15:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51582 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgAIAPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:15:49 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ipLUC-0003nJ-TJ; Thu, 09 Jan 2020 01:15:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/rockchip: fix integer type used for storing dp data rate and lane count
Date:   Thu, 09 Jan 2020 01:15:40 +0100
Message-ID: <2028959.b8b8FNkPgY@diego>
In-Reply-To: <20200108223949.355975-2-t.schramm@manjaro.org>
References: <20200108223949.355975-1-t.schramm@manjaro.org> <20200108223949.355975-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Januar 2020, 23:39:49 CET schrieb Tobias Schramm:
> commit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changes
> the type of variables used to store the display port data rate and
> number of lanes to u8. However u8 is not sufficient to store the link
> data rate of the display port.
> This commit reverts the type of both the number of lanes and the data
> rate to unsigned int.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  drivers/gpu/drm/rockchip/cdn-dp-core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> index 83c4586665b4..806cb0b08982 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
> @@ -94,8 +94,8 @@ struct cdn_dp_device {
>  	struct video_info video_info;
>  	struct cdn_dp_port *port[MAX_PHY];
>  	u8 ports;
> -	u8 max_lanes;
> -	u8 max_rate;
> +	unsigned int max_lanes;

although I would think u8 should be enough for max_lanes?
There shouldn't be be more than 255 dp lanes?


Heiko

> +	unsigned int max_rate;
>  	u8 lanes;
>  	int active_port;
>  
> 




