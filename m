Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570A7189494
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 04:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCRDrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 23:47:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44458 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:47:13 -0400
Received: from MININT-65B7IF6 (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA0DC20B9C02;
        Tue, 17 Mar 2020 20:47:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA0DC20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584503232;
        bh=xuZCDNN9pSELQakSvlPTRXTcC0ocNTGcUO4DMHnp700=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwACtE1oSIFgPLCqqh+/lqbnKmxr+UmqzX/8pQ7cwoE8qipna5V5iDQgsm3Sb/ItF
         MHg1r1UhO4WMynly1O14MzMVXSyTlH0hLfG4V04ureOoptrG/pqt/uZ1Lj6Uxspw2o
         +Vl+d6NgmYtVwzYoJrhRmnj1Q1a+xflsmz7Bz7iw=
Date:   Tue, 17 Mar 2020 22:47:06 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v2 1/1] maillbox: bcm-flexrm-mailbox: handle cmpl_pool
 dma allocation failure
Message-ID: <20200318034706.GA4904@MININT-65B7IF6>
References: <20200318033055.5335-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318033055.5335-1-rayagonda.kokatanur@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 09:00:55, Rayagonda Kokatanur wrote:
> Handle 'cmpl_pool' dma memory allocation failure.
> 
> Fixes: a9a9da47f8e6 ("mailbox: no need to check return value of debugfs_create functions")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Thanks for adding the Fixes tag.

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
> Changes from v1:
> - Address code review comments from Tyler Hicks,
>   Add missing Fixes tag.
> 
>  drivers/mailbox/bcm-flexrm-mailbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index 8ee9db274802..bee33abb5308 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1599,6 +1599,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>  					  1 << RING_CMPL_ALIGN_ORDER, 0);
>  	if (!mbox->cmpl_pool) {
>  		ret = -ENOMEM;
> +		goto fail_destroy_bd_pool;
>  	}
>  
>  	/* Allocate platform MSIs for each ring */
> @@ -1661,6 +1662,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>  	platform_msi_domain_free_irqs(dev);
>  fail_destroy_cmpl_pool:
>  	dma_pool_destroy(mbox->cmpl_pool);
> +fail_destroy_bd_pool:
>  	dma_pool_destroy(mbox->bd_pool);
>  fail:
>  	return ret;
> -- 
> 2.17.1
> 
