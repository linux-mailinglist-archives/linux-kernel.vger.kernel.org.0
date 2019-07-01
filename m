Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC62338E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFCTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 15:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCTMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:12:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E33240BB;
        Mon,  3 Jun 2019 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589139;
        bh=YYk6tQfzcy5HfRJKk/xr6aoJLq5kAuaNcjRYiKK7yMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uka7e/0guD/aBiDIRTMfQNvSYlsxv2+6HzoWXX2NHW2oDeFfzucbtT0UJnSfROllR
         pC2MBG9rXIeohKJ6Xg1UHPCiTCqMQ3paAnfyjbe1Ee2eY/Ze7zR5EsAAZ7zMD1dqtY
         YPF1XDatj593fH3YkSkQi3AwY4NAqGoi6+MSU3xs=
Date:   Mon, 3 Jun 2019 21:12:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Message-ID: <20190603191216.GF6487@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> Add a wrappers to lookup a device by name for a given driver, by various
> generic properties of a device. This can avoid the proliferation of custom
> match functions throughout the drivers.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 52d59d5..68d6e04 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -401,6 +401,50 @@ struct device *driver_find_device(struct device_driver *drv,
>  				  struct device *start, void *data,
>  				  int (*match)(struct device *dev, const void *data));
>  
> +/**
> + * driver_find_device_by_name - device iterator for locating a particular device
> + * of a specific name.
> + * @driver: the driver we're iterating
> + * @start: Device to begin with
> + * @name: name of the device to match
> + */
> +static inline struct device *driver_find_device_by_name(struct device_driver *drv,
> +							struct device *start,
> +							const char *name)
> +{
> +	return driver_find_device(drv, start, (void *)name, device_match_name);
> +}

Are any of the users you are finding for these new functions ever using
the 'start' parameter?  If not, let's just drop it, as it's normally a
rare thing to care about, right?

thanks,

greg k-h
