Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F28A188
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHLOu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfHLOu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:50:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8031206A2;
        Mon, 12 Aug 2019 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565621426;
        bh=Fyy1cHG7OLQ50YJfdvzpSVl+ewYcIEnhuo+BGNnPczw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMtwFqxiGdSMBqAb8WYJoKoL8TTUEU0ifoOs/tMi2+VK0TGwJurcHubsJs7ZtEcja
         AuuYE0yNXluBItCb5JrcdRF9YOkNhiEWx7pB52/5fk9MSemu56aBihzJDFpUQ8l8AY
         1CwKn2nXPwIwrhO727rVr1sPsxsbMKgx7IM3TGL4=
Date:   Mon, 12 Aug 2019 16:50:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Dotan Barak <dbarak@habana.ai>
Subject: Re: [PATCH] habanalabs: explicitly set the queue-id enumerated
 numbers
Message-ID: <20190812145023.GA22363@kroah.com>
References: <20190812074144.12630-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812074144.12630-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:41:44AM +0300, Oded Gabbay wrote:
> From: Dotan Barak <dbarak@habana.ai>
> 
> When looking at kernel log messages and when debugging user applications,
> we only see the queue id. This patch explicitly set the queue id in the
> queue enumeration which will be helpful for finding the queue name when we
> have its id.
> 
> Signed-off-by: Dotan Barak <dbarak@habana.ai>
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  include/uapi/misc/habanalabs.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index a5a1d0e7ec82..6cf50177cd21 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -28,20 +28,20 @@
>  
>  enum goya_queue_id {
>  	GOYA_QUEUE_ID_DMA_0 = 0,
> -	GOYA_QUEUE_ID_DMA_1,
> -	GOYA_QUEUE_ID_DMA_2,
> -	GOYA_QUEUE_ID_DMA_3,
> -	GOYA_QUEUE_ID_DMA_4,
> -	GOYA_QUEUE_ID_CPU_PQ,
> -	GOYA_QUEUE_ID_MME,	/* Internal queues start here */
> -	GOYA_QUEUE_ID_TPC0,
> -	GOYA_QUEUE_ID_TPC1,
> -	GOYA_QUEUE_ID_TPC2,
> -	GOYA_QUEUE_ID_TPC3,
> -	GOYA_QUEUE_ID_TPC4,
> -	GOYA_QUEUE_ID_TPC5,
> -	GOYA_QUEUE_ID_TPC6,
> -	GOYA_QUEUE_ID_TPC7,
> +	GOYA_QUEUE_ID_DMA_1 = 1,
> +	GOYA_QUEUE_ID_DMA_2 = 2,
> +	GOYA_QUEUE_ID_DMA_3 = 3,
> +	GOYA_QUEUE_ID_DMA_4 = 4,
> +	GOYA_QUEUE_ID_CPU_PQ = 5,
> +	GOYA_QUEUE_ID_MME = 6,	/* Internal queues start here */
> +	GOYA_QUEUE_ID_TPC0 = 7,
> +	GOYA_QUEUE_ID_TPC1 = 8,
> +	GOYA_QUEUE_ID_TPC2 = 9,
> +	GOYA_QUEUE_ID_TPC3 = 10,
> +	GOYA_QUEUE_ID_TPC4 = 11,
> +	GOYA_QUEUE_ID_TPC5 = 12,
> +	GOYA_QUEUE_ID_TPC6 = 13,
> +	GOYA_QUEUE_ID_TPC7 = 14,
>  	GOYA_QUEUE_ID_SIZE
>  };

This is good anyway, uapi enums should ALWAYS be explicitly set,
otherwise you could have problems with different compilers setting the
values to different numbers.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
