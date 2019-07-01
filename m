Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36A847167
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2019 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfFORbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jun 2019 13:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFORbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:31:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8812183F;
        Sat, 15 Jun 2019 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560619911;
        bh=ki57qw7fa8b6x/4E3LJnw7yuNUaGH8nau7t+aC1ZAH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aeFnGqUIDNpedj/qDPE4wh7ak9hIYNjSBa3kWK5VyzOnnxc+xVwloYeLy3Cm+i0uP
         utmqIVBnbOH3PlmlHY19qfyLFZ9T9ZEvr81M4lyNG/QOom3p1dM3fT6hF2ffYyAGvu
         a40JBYA7ekfR/IZVekqD05iWqfD2D0UWKoZTm5dw=
Date:   Sat, 15 Jun 2019 19:31:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] staging: android: fix style problem
Message-ID: <20190615173149.GA4914@kroah.com>
References: <20190614194156.GA21401@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614194156.GA21401@ahmlpt0706>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 01:11:56AM +0530, Saiyam Doshi wrote:
> checkpatch reported "WARNING: line over 80 characters". This
> patch fixes it by aligning function arguments.
> 
> Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
> ---
>  drivers/staging/android/ion/ion_chunk_heap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
> index 3cdde9c1a717..6aceab2e77e4 100644
> --- a/drivers/staging/android/ion/ion_chunk_heap.c
> +++ b/drivers/staging/android/ion/ion_chunk_heap.c
> @@ -107,7 +107,9 @@ static struct ion_heap_ops chunk_heap_ops = {
>  	.unmap_kernel = ion_heap_unmap_kernel,
>  };
>  
> -struct ion_heap *ion_chunk_heap_create(phys_addr_t base, size_t size, size_t chunk_size)
> +struct ion_heap *ion_chunk_heap_create(phys_addr_t base,
> +				       size_t size,
> +				       size_t chunk_size)

Just break the line at "size_t size,", no need for 3 lines when 2 will
do.

thanks,

greg k-h
