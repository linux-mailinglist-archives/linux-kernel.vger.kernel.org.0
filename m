Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9338175711
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 10:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCBJ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 04:28:22 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50494 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgCBJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:28:14 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 178FE54A;
        Mon,  2 Mar 2020 10:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583141292;
        bh=9ZqrQgN1kicNCFdvQnafSQx8lmmfNjFur/cYDbP3rDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skswSqAQuA8w3fEw57iweTsG5i9uxgyuyyKNg3OiEsiYEb0M3CjsQQczW9udnAGEr
         T2HSEz9s35KdPJUtHRFZ5Wm2YwCWHcLEITfyn+nNW7CqkZe5EGYbEb/hiEAjsId6bv
         HuOSO3bAcOeA8l0Ibo4SK095T1jkIsyXt2Q/ZZ08=
Date:   Mon, 2 Mar 2020 11:27:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: dw-hdmi: Fix color space conversion
 detection
Message-ID: <20200302092748.GE11960@pendragon.ideasonboard.com>
References: <20200229163043.158262-1-jernej.skrabec@siol.net>
 <20200229163043.158262-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229163043.158262-3-jernej.skrabec@siol.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Sat, Feb 29, 2020 at 05:30:41PM +0100, Jernej Skrabec wrote:
> Currently, is_color_space_conversion() compares not only color spaces
> but also formats. For example, function would return true if YCbCr 4:4:4
> and YCbCr 4:2:2 would be set. Obviously in that case color spaces are
> the same.
> 
> Fix that by comparing if both values represent RGB color space.
> 
> Fixes: b21f4b658df8 ("drm: imx: imx-hdmi: move imx-hdmi to bridge/dw_hdmi")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

This isn't implemented today, but could the CSC be used to convert
between different YCbCr encodings ?

In any case the patch is correct based on the current implementation, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 24965e53d351..9d7bfb1cb213 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -956,7 +956,8 @@ static void hdmi_video_sample(struct dw_hdmi *hdmi)
>  
>  static int is_color_space_conversion(struct dw_hdmi *hdmi)
>  {
> -	return hdmi->hdmi_data.enc_in_bus_format != hdmi->hdmi_data.enc_out_bus_format;
> +	return hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_in_bus_format) !=
> +		hdmi_bus_fmt_is_rgb(hdmi->hdmi_data.enc_out_bus_format);
>  }
>  
>  static int is_color_space_decimation(struct dw_hdmi *hdmi)

-- 
Regards,

Laurent Pinchart
