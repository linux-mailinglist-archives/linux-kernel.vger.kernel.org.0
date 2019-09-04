Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B055A7D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 04:15:20 -0400
Received: from 8bytes.org ([81.169.241.247]:53108 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDIPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:15:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8A42E445; Wed,  4 Sep 2019 10:15:17 +0200 (CEST)
Date:   Wed, 4 Sep 2019 10:15:17 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        arno@natisbad.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/pamu: Use kzfree rather than its implementation
Message-ID: <20190904081517.GA29855@8bytes.org>
References: <1567566079-7412-1-git-send-email-zhongjiang@huawei.com>
 <1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567566079-7412-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 11:01:18AM +0800, zhong jiang wrote:
> Use kzfree instead of memset() + kfree().
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/iommu/fsl_pamu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index cde281b..ca6d147 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -1174,10 +1174,8 @@ static int fsl_pamu_probe(struct platform_device *pdev)
>  	if (irq != NO_IRQ)
>  		free_irq(irq, data);
>  
> -	if (data) {
> -		memset(data, 0, sizeof(struct pamu_isr_data));
> -		kfree(data);
> -	}
> +	if (data)
> +		kzfree(data);

kzfree() is doing its own NULL-ptr check, no need to do it here.

Regards,

	Joerg
