Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D956723FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfGXBtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 21:49:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38678 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728675AbfGXBtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:49:23 -0400
X-UUID: 517c04dad5a54f7aa85127aa0890d8b9-20190724
X-UUID: 517c04dad5a54f7aa85127aa0890d8b9-20190724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1467029798; Wed, 24 Jul 2019 09:49:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Jul 2019 09:49:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Jul 2019 09:49:15 +0800
Message-ID: <1563932955.26104.0.camel@mtksdaap41>
Subject: Re: [PATCH -next] drm/mediatek: Remove duplicated include from
 mtk_drm_drv.c
From:   CK Hu <ck.hu@mediatek.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Date:   Wed, 24 Jul 2019 09:49:15 +0800
In-Reply-To: <20190724013348.153144-1-yuehaibing@huawei.com>
References: <20190724013348.153144-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, YueHaibing:

On Wed, 2019-07-24 at 01:33 +0000, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 2ee809a6f3dc..e3b64a266dcf 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -23,7 +23,6 @@
>  
>  #include "mtk_drm_crtc.h"
>  #include "mtk_drm_ddp.h"
> -#include "mtk_drm_ddp.h"
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_drv.h"
>  #include "mtk_drm_fb.h"
> 
> 
> 
> 
> 


