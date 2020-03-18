Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7355A18A2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 19:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCRS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 14:58:19 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48908 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:58:18 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D26128060A;
        Wed, 18 Mar 2020 19:58:15 +0100 (CET)
Date:   Wed, 18 Mar 2020 19:58:14 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Update feiyang, st7701 panel
 bindings converted as YAML
Message-ID: <20200318185814.GB28092@ravnborg.org>
References: <20200318171003.5179-1-jagan@amarulasolutions.com>
 <20200318171003.5179-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318171003.5179-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8
        a=20KFwNOVAAAA:8 a=WZHNqt2aAAAA:8 a=e5mUnYsNAAAA:8 a=9Nv2NtiChPkpYjpV1K0A:9
        a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22 a=PrHl9onO2p7xFKlKy1af:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=pHzHmUro8NiASowvMSCR:22
        a=nt3jZW36AmriUCFCBwmW:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:40:03PM +0530, Jagan Teki wrote:
> The feiyang,fy07024di26a30d.txt and sitronix,st7701.txt has been
> converted to YAML schemas, update MAINTAINERS to match them again.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

The patch is fine.
I just dislike we repeat the maintainer info in two places..

	Sam


> ---
> Changes for v2:
> - none
> 
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ba8b584bf95..b987f2588e6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5273,7 +5273,7 @@ DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
>  F:	drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> -F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
> +F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
>  
>  DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
>  M:	Hans de Goede <hdegoede@redhat.com>
> @@ -5416,7 +5416,7 @@ DRM DRIVER FOR SITRONIX ST7701 PANELS
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
>  F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
> -F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
> +F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
>  
>  DRM DRIVER FOR SITRONIX ST7586 PANELS
>  M:	David Lechner <david@lechnology.com>
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
