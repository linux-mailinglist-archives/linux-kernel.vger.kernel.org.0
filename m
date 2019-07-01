Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37ACA37491
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFFMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 08:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfFFMzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:55:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CF12070B;
        Thu,  6 Jun 2019 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559825752;
        bh=1hbBwnqN56Y/JMha8383D60Ivnk7r8lWw9qY3990Jx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQpFEkxj1lVEGqH1VbTPjTunTeW0nCtQANi+nuicZUsJauqdNJ6LrfBOvY7TIppIY
         0eCdtd/Z5WQjDDJRHCCBROkGkflZjOXduAveM+IdB/jZIqUSAzd2U2Hr64J1rhzKo1
         vqvI2Y6bl8KdcfE2ZsuiXyq89F78+22vSWcLE70k=
Date:   Thu, 6 Jun 2019 14:55:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] staging: kpc2000: use __func__ in debug messages in
 core.c
Message-ID: <20190606125550.GA11929@kroah.com>
References: <20190603222916.20698-1-simon@nikanor.nu>
 <20190603222916.20698-5-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603222916.20698-5-simon@nikanor.nu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 12:29:13AM +0200, Simon Sandstr�m wrote:
> Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
> '<function name>', this function's name, in a string".
> 
> Signed-off-by: Simon Sandstr�m <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
> index a70665a202c3..6d4fc1f37c9f 100644
> --- a/drivers/staging/kpc2000/kpc2000/core.c
> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> @@ -312,8 +312,8 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
>  	unsigned long dma_bar_phys_len;
>  	u16 regval;
>  
> -	dev_dbg(&pdev->dev, "kp2000_pcie_probe(pdev = [%p], id = [%p])\n",
> -		pdev, id);
> +	dev_dbg(&pdev->dev, "%s(pdev = [%p], id = [%p])\n",
> +		__func__, pdev, id);

debugging lines that say "called this function!" can all be removed, as
we have ftrace in the kernel tree, we can use that instead.  I'll take
this, but feel free to clean them up as follow-on patches.

thanks,

greg k-h
