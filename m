Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF89AE120
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 00:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbfIIWgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 18:36:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36388 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfIIWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:36:05 -0400
Received: from pendragon.ideasonboard.com (unknown [88.214.160.167])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 97E3D4FE;
        Tue, 10 Sep 2019 00:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568068562;
        bh=ytpDKk/iTXIZzQdXuSLQiM1Plw/tdurNCuOlF0kQUBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oh/81Sl2yegYqXREdFzqny3O9/0MXoaO0hhHQz8Uaf+i1uVY7Hcea6+AOc82SUsr/
         6wDS8y9xBfUdzP8pzfY83cphRhLjI4YfGqyYIjZqo6U99uPv64UjVENczPxqJetUQD
         D/8XptB8PPpCjvPrnoWa98HtKYrkgF/IpQEm1Qww=
Date:   Tue, 10 Sep 2019 01:35:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tilcdc: include linux/pinctrl/consumer.h again
Message-ID: <20190909223556.GB15652@pendragon.ideasonboard.com>
References: <20190909203409.652308-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909203409.652308-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Mon, Sep 09, 2019 at 10:33:57PM +0200, Arnd Bergmann wrote:
> This was apparently dropped by accident in a recent
> cleanup, causing a build failure in some configurations now:
> 
> drivers/gpu/drm/tilcdc/tilcdc_tfp410.c:296:12: error: implicit declaration of function 'devm_pinctrl_get_select_default' [-Werror,-Wimplicit-function-declaration]
> 
> Fixes: fcb57664172e ("drm/tilcdc: drop use of drmP.h")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> index 525dc1c0f1c1..9edcdd7f2b96 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
> @@ -8,6 +8,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>

I'd put this before platform_device.h to keep the headers alphabetically
ordered. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_encoder.h>

-- 
Regards,

Laurent Pinchart
