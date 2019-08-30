Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE72FA3007
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3Geq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:34:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1677 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfH3Geq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:34:46 -0400
X-UUID: 38e5d13ac4ea4e928864b05c935a20a0-20190830
X-UUID: 38e5d13ac4ea4e928864b05c935a20a0-20190830
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 360870798; Fri, 30 Aug 2019 14:34:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 14:34:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 14:34:38 +0800
Message-ID: <1567146872.5942.21.camel@mtksdaap41>
Subject: Re: [PATCH v5, 30/32] drm/mediatek: add connection from DITHER0 to
 DSI0
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
Date:   Fri, 30 Aug 2019 14:34:32 +0800
In-Reply-To: <1567090254-15566-31-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
         <1567090254-15566-31-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2D80EE79821C3E6C697081CC7D2D39A69D62CD500E2390B9E48C61F531F4FD352000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

On Thu, 2019-08-29 at 22:50 +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> This patch add connection from DITHER0 to DSI0

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 237824f..fd38658 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -35,10 +35,12 @@
>  
>  #define MT8183_DISP_OVL0_2L_MOUT_EN		0xf04
>  #define MT8183_DISP_OVL1_2L_MOUT_EN		0xf08
> +#define MT8183_DISP_DITHER0_MOUT_EN		0xf0c
>  #define MT8183_DISP_PATH0_SEL_IN		0xf24
>  
>  #define OVL0_2L_MOUT_EN_DISP_PATH0			BIT(0)
>  #define OVL1_2L_MOUT_EN_RDMA1				BIT(4)
> +#define DITHER0_MOUT_IN_DSI0				BIT(0)
>  #define DISP_PATH0_SEL_IN_OVL0_2L			0x1
>  
>  #define MT2701_DISP_MUTEX0_MOD0			0x2c
> @@ -323,6 +325,9 @@ static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
>  		   next == DDP_COMPONENT_RDMA1) {
>  		*addr = MT8183_DISP_OVL1_2L_MOUT_EN;
>  		value = OVL1_2L_MOUT_EN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_DITHER && next == DDP_COMPONENT_DSI0) {
> +		*addr = MT8183_DISP_DITHER0_MOUT_EN;
> +		value = DITHER0_MOUT_IN_DSI0;
>  	} else {
>  		value = 0;
>  	}


