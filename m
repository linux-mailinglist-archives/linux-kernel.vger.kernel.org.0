Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EBD64BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfJNOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 10:06:53 -0400
Received: from foss.arm.com ([217.140.110.172]:45052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbfJNOGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:06:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D47C4337;
        Mon, 14 Oct 2019 07:06:52 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FFF63F68E;
        Mon, 14 Oct 2019 07:06:50 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] iommu/mediatek: Correct the flush_iotlb_all
 callback
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        cui.zhang@mediatek.com, chao.hao@mediatek.com,
        edison.hsieh@mediatek.com
References: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
 <1571035101-4213-2-git-send-email-yong.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9aa2e356-d234-df21-7203-ce569c232e02@arm.com>
Date:   Mon, 14 Oct 2019 15:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571035101-4213-2-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 07:38, Yong Wu wrote:
> Use the correct tlb_flush_all instead of the original one.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 67a483c..76b9388 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -447,7 +447,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>   
>   static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
>   {
> -	mtk_iommu_tlb_sync(mtk_iommu_get_m4u_data());
> +	mtk_iommu_tlb_flush_all(mtk_iommu_get_m4u_data());
>   }
>   
>   static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
> 
