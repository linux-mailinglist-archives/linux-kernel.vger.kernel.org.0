Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4894F341
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFVCm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 22:42:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50096 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbfFVCm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 22:42:56 -0400
X-UUID: d6cd0e2e4bbc4284bbdc8a37dd63a604-20190622
X-UUID: d6cd0e2e4bbc4284bbdc8a37dd63a604-20190622
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1360281704; Sat, 22 Jun 2019 10:42:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 22 Jun
 2019 10:42:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 22 Jun 2019 10:42:35 +0800
Message-ID: <1561171355.4850.7.camel@mhfsdcap03>
Subject: Re: [PATCH v2 05/12] media: mtk-jpeg: Get rid of
 mtk_smi_larb_get/put
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Evan Green" <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Rick Chang <rick.chang@mediatek.com>
Date:   Sat, 22 Jun 2019 10:42:35 +0800
In-Reply-To: <6539751d-1751-f309-1c51-b3f9576c1b99@gmail.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
         <1560171313-28299-6-git-send-email-yong.wu@mediatek.com>
         <6539751d-1751-f309-1c51-b3f9576c1b99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 2A30C6EFC43BFC5A9239BAECC619A787D0115E0887011AB5A837AB732B8DB5C02000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-20 at 17:20 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:55, Yong Wu wrote:
> > MediaTek IOMMU has already added device_link between the consumer
> > and smi-larb device. If the jpg device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> Please help me out find this relation. I seem to miss something basic, because I
> can't find any between the jpeg IP and the iommu.

JPEG also is a multimedia consumer. It also access memory via IOMMU. All
the current SoC have the JPG smi ports. 

grep -r JPG include/dt-bindings/memory/mt*

> 
> Regards,
> Matthias
> 
> > 
> > CC: Rick Chang <rick.chang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 22 ----------------------
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  2 --
> >  2 files changed, 24 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > index f761e4d..2f37538 100644
> > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > @@ -29,7 +29,6 @@
> >  #include <media/v4l2-ioctl.h>
> >  #include <media/videobuf2-core.h>
> >  #include <media/videobuf2-dma-contig.h>
> > -#include <soc/mediatek/smi.h>
> >  
> >  #include "mtk_jpeg_hw.h"
> >  #include "mtk_jpeg_core.h"
> > @@ -901,11 +900,6 @@ static int mtk_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
> >  
> >  static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
> >  {
> > -	int ret;
> > -
> > -	ret = mtk_smi_larb_get(jpeg->larb);
> > -	if (ret)
> > -		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
> >  	clk_prepare_enable(jpeg->clk_jdec_smi);
> >  	clk_prepare_enable(jpeg->clk_jdec);
> >  }
> > @@ -914,7 +908,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
> >  {
> >  	clk_disable_unprepare(jpeg->clk_jdec);
> >  	clk_disable_unprepare(jpeg->clk_jdec_smi);
> > -	mtk_smi_larb_put(jpeg->larb);
> >  }
> >  
> >  static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
> > @@ -1059,21 +1052,6 @@ static int mtk_jpeg_release(struct file *file)
> >  
> >  static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
> >  {
> > -	struct device_node *node;
> > -	struct platform_device *pdev;
> > -
> > -	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
> > -	if (!node)
> > -		return -EINVAL;
> > -	pdev = of_find_device_by_node(node);
> > -	if (WARN_ON(!pdev)) {
> > -		of_node_put(node);
> > -		return -EINVAL;
> > -	}
> > -	of_node_put(node);
> > -
> > -	jpeg->larb = &pdev->dev;
> > -
> >  	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
> >  	if (IS_ERR(jpeg->clk_jdec))
> >  		return PTR_ERR(jpeg->clk_jdec);
> > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > index 1a6cdfd..e35fb79 100644
> > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > @@ -55,7 +55,6 @@ enum mtk_jpeg_ctx_state {
> >   * @dec_reg_base:	JPEG registers mapping
> >   * @clk_jdec:		JPEG hw working clock
> >   * @clk_jdec_smi:	JPEG SMI bus clock
> > - * @larb:		SMI device
> >   */
> >  struct mtk_jpeg_dev {
> >  	struct mutex		lock;
> > @@ -69,7 +68,6 @@ struct mtk_jpeg_dev {
> >  	void __iomem		*dec_reg_base;
> >  	struct clk		*clk_jdec;
> >  	struct clk		*clk_jdec_smi;
> > -	struct device		*larb;
> >  };
> >  
> >  /**
> > 


