Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BAD0B25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfJIJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 05:28:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:26317 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbfJIJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:28:33 -0400
X-UUID: f7a9f139fedc4b6daa8d4ca89e78a73a-20191009
X-UUID: f7a9f139fedc4b6daa8d4ca89e78a73a-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1470652035; Wed, 09 Oct 2019 17:28:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 17:28:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 17:28:17 +0800
Message-ID: <1570613300.7713.7.camel@mtksdaap41>
Subject: Re: [PATCH v5, 23/32] drm/mediatek: distinguish ovl and ovl_2l by
 layer_nr
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 9 Oct 2019 17:28:20 +0800
In-Reply-To: <1567090254-15566-24-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-24-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 8828B06EB7BF6350F4191CA5E055A56083ECA0F38692A4F69FB7840773E99E852000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> distinguish ovl and ovl_2l by layer_nr when get comp
> id
> 

Applied to mediatek-drm-next-5.5 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index eb3bf85..53f3883 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -318,7 +318,12 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DISP_OVL);
> +	priv->data = of_device_get_match_data(dev);
> +
> +	comp_id = mtk_ddp_comp_get_id(dev->of_node,
> +				      priv->data->layer_nr == 4 ?
> +				      MTK_DISP_OVL :
> +				      MTK_DISP_OVL_2L);
>  	if (comp_id < 0) {
>  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
>  		return comp_id;
> @@ -331,8 +336,6 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	priv->data = of_device_get_match_data(dev);
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,


