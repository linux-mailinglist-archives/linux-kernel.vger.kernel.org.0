Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9361187312
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbgCPTLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 15:11:24 -0400
Received: from vps.xff.cz ([195.181.215.36]:42666 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732298AbgCPTLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1584385882; bh=FW1eAGDaOwZotXT5BTvXsi+IhkF86WgYclyjbaMj8x0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=tUMLz8BV7T0c827DnXQtea8vx0HkcPUk4ToUSZaHMUkDk+9csPNi+kqJ8KJVU2vjg
         5mxCNIApW9dNDx1t6jX13OOLMFgskXtNRfdIW7qMODyiG26wqc/yvtGDBkv7AlsSQA
         eUYRwhujgrnht7UefJkn1OgNsJQ8aJw8PnwwT1h0=
Date:   Mon, 16 Mar 2020 20:11:22 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 3/5] drm: panel: add Xingbangda XBD599 panel
Message-ID: <20200316191122.yeb5l22ldtt73vx5@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
References: <20200316133503.144650-1-icenowy@aosc.io>
 <20200316133503.144650-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316133503.144650-4-icenowy@aosc.io>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Icenowy,

On Mon, Mar 16, 2020 at 09:35:01PM +0800, Icenowy Zheng wrote:
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI IPS LCD panel made by
> Xingbangda, which is used on PinePhone final assembled phones.
>
> [snip]
>
> +static const struct drm_display_mode xbd599_default_mode = {
> +	.hdisplay    = 720,
> +	.hsync_start = 720 + 40,
> +	.hsync_end   = 720 + 40 + 40,
> +	.htotal	     = 720 + 40 + 40 + 40,
> +	.vdisplay    = 1440,
> +	.vsync_start = 1440 + 18,
> +	.vsync_end   = 1440 + 18 + 10,
> +	.vtotal	     = 1440 + 18 + 10 + 17,
> +	.vrefresh    = 60,

Does the display actually run for you at 60fps? I measured 36.63 FPS with
a DRM app that just does DRM_IOCTL_MODE_ATOMIC update after each
DRM_EVENT_FLIP_COMPLETE event.

thank you and regards,
	o.

> +	.clock	     = 69000,
> +	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +
> +	.width_mm    = 68,
> +	.height_mm   = 136,
> +	.type        = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
