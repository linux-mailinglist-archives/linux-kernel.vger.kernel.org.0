Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70013E36
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfEEHoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 03:44:24 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16973 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726524AbfEEHoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:44:24 -0400
X-UUID: bca66897c5a5492c9a238fe0951bb677-20190505
X-UUID: bca66897c5a5492c9a238fe0951bb677-20190505
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 720570531; Sun, 05 May 2019 15:43:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 5 May
 2019 15:43:54 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 May 2019 15:43:53 +0800
Message-ID: <1557042233.18628.33.camel@mhfsdcap03>
Subject: Re: [PATCH 1/4] mmc: mtk-sd: don't hard-code interrupt trigger type
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     NeilBrown <neil@brown.name>
CC:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thirtythreeforty@gmail.com>
Date:   Sun, 5 May 2019 15:43:53 +0800
In-Reply-To: <155696549653.8632.3279283591868841381.stgit@noble.brown>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
         <155696549653.8632.3279283591868841381.stgit@noble.brown>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 20:24 +1000, NeilBrown wrote:
> When using devicetree for configuration, interrupt trigger type
> should be described in the dts file, not hard-coded in the C code.
> 
> The mtk-sd silicon in the mt7621 soc uses an active-high interrupt
> and so cannot be used with the current code.
> 
> So replace IRQF_TRIGGER_LOW with IRQF_TRIGGER_NONE.
> 
> Also IRQF_ONESHOT is not needed - it is used for threaded interrupt
> handlers, and this driver does not used a threaded interrupt handler.
> So remove that setting.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
 Reviewed-by:Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 0798f0ba6d34..469d4a717175 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2240,7 +2240,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  	msdc_init_hw(host);
>  
>  	ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> -		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
> +			       IRQF_TRIGGER_NONE, pdev->name, host);
>  	if (ret)
>  		goto release;
>  
> 
> 


