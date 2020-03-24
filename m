Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4295519180C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 18:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCXRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 13:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgCXRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:46:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA4AF206F6;
        Tue, 24 Mar 2020 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585072007;
        bh=obBvXsfoQJaST8AIFXbfAeXEKbif9Cn9RfiyBsQ/NFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RX+rGI3K47uTHTYh9mjgx6P98/NTxlH0v7deLQCa1q3A251+Igvzk4GZRlV0y0M4n
         YTsDVH3JpsYT5//WkmN1iLiiNkSQYBnzRRK2cOv7sZXuvMObNl0RDADVPJ+3dJy37y
         SReYguBGIQCAYFymlsdwE7PkC/TUbejJkXlcTv9g=
Date:   Tue, 24 Mar 2020 18:46:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au
Subject: Re: [PATCH 3/3] nvmem: core: use is_bin_visible for permissions
Message-ID: <20200324174642.GA2524667@kroah.com>
References: <20200324171600.15606-1-srinivas.kandagatla@linaro.org>
 <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324171600.15606-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:16:00PM +0000, Srinivas Kandagatla wrote:
> By using is_bin_visible callback to set permissions will remove a large list
> of attribute groups. These group permissions can be dynamically derived in
> the callback.
> 
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/nvmem-sysfs.c | 74 +++++++++----------------------------
>  1 file changed, 18 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvmem/nvmem-sysfs.c b/drivers/nvmem/nvmem-sysfs.c
> index 8759c4470012..1ff1801048f6 100644
> --- a/drivers/nvmem/nvmem-sysfs.c
> +++ b/drivers/nvmem/nvmem-sysfs.c
> @@ -103,6 +103,17 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>  
>  	return count;
>  }
> +static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
> +					 struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct nvmem_device *nvmem = to_nvmem_device(dev);
> +
> +	if (nvmem->root_only)
> +		return nvmem->read_only ? 0400 : 0600;
> +
> +	return nvmem->read_only ? 0444 : 0644;
> +}

I don't know why this is so hard for me to read, but how about this
instead:

static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
					 struct bin_attribute *attr, int i)
{
	struct device *dev = container_of(kobj, struct device, kobj);
	struct nvmem_device *nvmem = to_nvmem_device(dev);
	umode_t mode = 0400;

	if (!nvmem->root_only)
		mode |= 0044;

	if (!nvmem->read_only)
		mode |= 0200;

	return mode;
}

Did I get the logic corect?

thanks,

greg k-h
