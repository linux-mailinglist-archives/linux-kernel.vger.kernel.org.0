Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B908338E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 21:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFCTIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 15:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C7723D66;
        Mon,  3 Jun 2019 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559588903;
        bh=w74VBwz1842V2tJi9EuRrmeSWfxtE46cMzBtjfw0gFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/eT6XScY5Rws2kTIl7Cz3Gg1mNSroVwPvZVUmME7rP/f85znhodsONqdjvULXZNI
         /4S4ZSt8VIXMJbSXeQ6tOa+CfbojdhT/hZeK08MUL1aapdC7QUzqS4OneNwan7crQq
         2jX/D7rfXDPXdr2CmghiambNCgH1gYr7mycigCKA=
Date:   Mon, 3 Jun 2019 21:08:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [RFC PATCH 03/57] drivers: coresight: Drop device references
 found via bus_find_device
Message-ID: <20190603190821.GB6487@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:29PM +0100, Suzuki K Poulose wrote:
> We must drop references to the device found via bus_find_device().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 4b13028..37ccd67 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -540,7 +540,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
>  
>  	dev = bus_find_device(&coresight_bustype, NULL, &deactivate,
>  			      coresight_enabled_sink);
> -
> +	put_device(dev);
>  	return dev ? to_coresight_device(dev) : NULL;

You drop the reference and then use the pointer?

Not good :(

>  }
>  
> @@ -581,7 +581,7 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
>  
>  	dev = bus_find_device(&coresight_bustype, NULL, &id,
>  			      coresight_sink_by_id);
> -
> +	put_device(dev);
>  	return dev ? to_coresight_device(dev) : NULL;

Same here, not good :(

Please fix this up and it can go in as a bugfix like any other normal
patch, outside of this huge series.

thanks,

greg k-h
