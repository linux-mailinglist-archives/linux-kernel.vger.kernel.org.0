Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C4116FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLIOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 09:53:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36664 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:53:35 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D07A5DAD;
        Mon,  9 Dec 2019 15:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575903213;
        bh=Q0OVJhjw7SZuhsekU9fG/W4V8dGuID7ElTtvVg2tjfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv4lpIeREWadJYjO759G72RPdXeU5ytjXx/ob10hZoTe/IswAGeDQLCHxUI4DX4Tt
         tPlgWX51TCYGLR+dbgXIc4ZEPe+ngZdGMNcP0i/g8iawWiI0m71Fv7ci5WtugvivTl
         8Tu1OQw3xhB28KH+8FSBX9B1XQUjhWiBXUruY6rc=
Date:   Mon, 9 Dec 2019 16:53:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>, p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 1/4] dt-bindings: drm/bridge: analogix-anx7688:
 Add ANX7688 transmitter binding
Message-ID: <20191209145326.GC12841@pendragon.ideasonboard.com>
References: <20191209145016.227784-1-hsinyi@chromium.org>
 <20191209145016.227784-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209145016.227784-2-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

On Mon, Dec 09, 2019 at 10:50:13PM +0800, Hsin-Yi Wang wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
> 
> Add support for analogix,anx7688
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/display/bridge/anx7688.txt       | 32 +++++++++++++++++++

How about converting this to yaml bindings already ? It's fairly simple
and gives you DT validation.

>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.txt b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
> new file mode 100644
> index 000000000000..78b55bdb18f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
> @@ -0,0 +1,32 @@
> +Analogix ANX7688 SlimPort (Single-Chip Transmitter for DP over USB-C)
> +---------------------------------------------------------------------
> +
> +The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
> +second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
> +resolution from a smartphone or tablet with full function USB-C.
> +
> +This binding only describes the HDMI to DP display bridge.
> +
> +Required properties:
> +
> + - compatible          : "analogix,anx7688"
> + - reg                 : I2C address of the device (fixed at 0x2c)
> +
> +Optional properties:
> +
> + - Video port for HDMI input, using the DT bindings defined in [1].
> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +Example:
> +
> +	anx7688: anx7688@2c {
> +		compatible = "analogix,anx7688";
> +		reg = <0x2c>;
> +
> +		port {
> +			anx7688_in: endpoint {
> +				remote-endpoint = <&hdmi0_out>;
> +			};
> +		};
> +	};
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 

-- 
Regards,

Laurent Pinchart
