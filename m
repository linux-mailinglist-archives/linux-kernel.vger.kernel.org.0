Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697159CC42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfHZJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 05:11:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729753AbfHZJK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:10:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 98E03EE471DA0DD908C3;
        Mon, 26 Aug 2019 17:10:57 +0800 (CST)
Received: from [127.0.0.1] (10.57.77.74) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 17:10:52 +0800
Subject: Re: [PATCH] drm/hisilicon: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
References: <20190723103852.3907-1-hslester96@gmail.com>
CC:     Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   xinliang <z.liuxinliang@hisilicon.com>
Message-ID: <5D63A21B.1020207@hisilicon.com>
Date:   Mon, 26 Aug 2019 17:10:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20190723103852.3907-1-hslester96@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.77.74]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/7/23 18:38, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Chuhong, thanks for the patch. And sorry for late reply.
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Applied to drm-hisilicon-hibmc-next.

Thanks,
Xinliang

> ---
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index ce89e56937b0..f0be263feff5 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -60,16 +60,14 @@ static struct drm_driver hibmc_driver = {
>   
>   static int __maybe_unused hibmc_pm_suspend(struct device *dev)
>   {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   
>   	return drm_mode_config_helper_suspend(drm_dev);
>   }
>   
>   static int  __maybe_unused hibmc_pm_resume(struct device *dev)
>   {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct drm_device *drm_dev = pci_get_drvdata(pdev);
> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   
>   	return drm_mode_config_helper_resume(drm_dev);
>   }


