Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB732152274
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBDWsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 17:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDWsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:48:37 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F33E20730;
        Tue,  4 Feb 2020 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580856517;
        bh=OuBNb9pRCpr2aDz2m+y/8WceLO92IqRoNNnHD6SjPsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OueAhdlrHM04/MMfJF5IvTWRaNgVlXLhCWSIM97Xp4TDa4uDG7GSsiIGYZug0csC1
         07bn/3iS5EDwbt+tj9FrlVKcZpn1AP+rx/L8aRnSYFBTNlSXoFW1pTYFsH03QBCGZ+
         /CL1vWMNryLAMZ5X7TE6B5QTY0EdxsMclki5xVlw=
Date:   Tue, 4 Feb 2020 22:48:35 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: constify properties in mfd_cell
Message-ID: <20200204224835.GA1128093@kroah.com>
References: <20200204201651.15778-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204201651.15778-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 10:16:51PM +0200, Tomas Winkler wrote:
> Constify 'struct property_entry *properties' in
> mfd_cell and platform_device. It is always passed
> around as a pointer const struct.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  include/linux/mfd/core.h        | 2 +-
>  include/linux/platform_device.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49d..7e5ac3c00891 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -70,7 +70,7 @@ struct mfd_cell {
>  	size_t			pdata_size;
>  
>  	/* device properties passed to the sub devices drivers */
> -	struct property_entry *properties;
> +	const struct property_entry *properties;
>  
>  	/*
>  	 * Device Tree compatible string
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 276a03c24691..8e83c6ff140d 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -89,7 +89,7 @@ struct platform_device_info {
>  		size_t size_data;
>  		u64 dma_mask;
>  
> -		struct property_entry *properties;
> +		const struct property_entry *properties;
>  };
>  extern struct platform_device *platform_device_register_full(
>  		const struct platform_device_info *pdevinfo);
> -- 
> 2.21.1
> 

This really is two different patches, can you split and resend?

thanks,

gre gk-h
