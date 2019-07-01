Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1572360DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfFEQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 12:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfFEQLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:11:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D0C2075C;
        Wed,  5 Jun 2019 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559751071;
        bh=DHGMgw+eZFadoBgNgRY+d4u+yvK0QBiz3Bpz93ekE80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bz1bKdq0xZjqv7v8IIC6SguSpaYD6TMiAq+cLdeaCb70Z6+MTXDvVooryCKAzoVer
         oLNmWVZDV2rjUAeIV0ELVfaayfkFKsbYLnsqDgAYPVKIiqVD3E3fJbpAvwfoo3nGzg
         PcVF5zfBWtrUBAOInSKhx+RlyJCFtNxftHZlZIus=
Date:   Wed, 5 Jun 2019 18:11:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Valerio Genovese <valerio.click@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: fix symbol
 'kpc_dma_add_device' was not declared.
Message-ID: <20190605161109.GA17272@kroah.com>
References: <20190605155711.19722-1-valerio.click@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605155711.19722-1-valerio.click@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 05:57:11PM +0200, Valerio Genovese wrote:
> This was reported by sparse:
> drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c:39:7: warning: symbol 'kpc_dma_add_device
> ' was not declared. Should it be static?
> 
> Signed-off-by: Valerio Genovese <valerio.click@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
> index ee47f43e71cf..19e88c3bc13f 100644
> --- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
> +++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
> @@ -56,6 +56,7 @@ struct dev_private_data {
>  };
>  
>  struct kpc_dma_device *kpc_dma_lookup_device(int minor);
> +void kpc_dma_add_device(struct kpc_dma_device *ldev);
>  
>  extern const struct file_operations  kpc_dma_fops;
>  

This is not how you fix this issue.

Look at the warning given to you.  Think about your C programming
knowledge and remember what the 'static' keyword is and does.

Then fix the issue properly.

thanks,

greg k-h
