Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676895CE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 13:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGBL0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 07:26:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfGBL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:26:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id B0A022852D9
Message-ID: <3c68bf286d8b75ac339df0eab43d276667e073c2.camel@collabora.com>
Subject: Re: [PATCH v2 0/3] RK3288 Gamma LUT
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Jul 2019 08:26:22 -0300
In-Reply-To: <20190621211346.1324-1-ezequiel@collabora.com>
References: <20190621211346.1324-1-ezequiel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, 2019-06-21 at 18:13 -0300, Ezequiel Garcia wrote:
> Let's support Gamma LUT configuration on RK3288 SoCs.
> 
> In order to do so, this series adds a new and optional
> address resource.
>     
> A separate address resource is required because on this RK3288,
> the LUT address is after the MMU address, which is requested
> by the iommu driver. This prevents the DRM driver
> from requesting an entire register space.
> 
> The current implementation works for RGB 10-bit tables, as that
> is what seems to work on RK3288.
> 
> This has been tested on a Rock2 Square board, using
> a hacked 'modetest' tool, with legacy and atomic APIs. 
> 
> Thanks,
> Eze
> 
> Changes from v1:
> * drop explicit linear LUT after finding a proper
>   way to disable gamma correction.
> * avoid setting gamma is the CRTC is not active.
> * s/int/unsigned int as suggested by Jacopo.
> * only enable color management and set gamma size
>   if gamma LUT is supported, suggested by Doug.
> * drop the reg-names usage, and instead just use indexed reg
>   specifiers, suggested by Doug.
> 
> Changes from RFC:
> * Request (an optional) address resource for the LUT.
> * Add devicetree changes.
> * Drop support for RK3399, which doesn't seem to work
>   out of the box and needs more research.
> * Support pass-thru setting when GAMMA_LUT is NULL.
> * Add a check for the gamma size, as suggested by Ilia.
> * Move gamma setting to atomic_commit_tail, as pointed
>   out by Jacopo/Laurent, is the correct way.
> 
> Ezequiel Garcia (3):
>   dt-bindings: display: rockchip: document VOP gamma LUT address
>   drm/rockchip: Add optional support for CRTC gamma LUT
>   ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
> 
>  .../display/rockchip/rockchip-vop.txt         |   6 +-
>  arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |   3 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 114 ++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   7 ++
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
>  6 files changed, 133 insertions(+), 3 deletions(-)
> 

Any other feedback on this series? If you are happy with the approach now,
I am wondering if you can take it or if it's way too late.

Thanks,
Eze


