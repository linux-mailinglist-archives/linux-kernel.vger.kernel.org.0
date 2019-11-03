Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6EED40D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfKCRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 12:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfKCRuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:50:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B643F2084D;
        Sun,  3 Nov 2019 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572803414;
        bh=PlOin1l6slPT5/U5vXvLzfTrvHg0QrB1rLhKWDlIkWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq8wmak45kO3jB3Frea8gx6xhrITGJ1OwasEFIYEoRmkjy+c/TEApVPZ3VSPxiOKu
         Dk4vZMh3aVmIbzn/AikMxU0KZgg1p1BG/iJdGU9rbLGmZLK1R2WEte69miitRFPf1A
         HLLvO3ZZiahEl89uP1Z4XGv48j2PMFH/O68i7X1o=
Date:   Sun, 3 Nov 2019 18:50:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht
Subject: Re: [PATCH] firmware loader: log path to loaded firmwares
Message-ID: <20191103175011.GA751209@kroah.com>
References: <20191103173837.1861-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103173837.1861-1-sir@cmpwn.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 12:38:38PM -0500, Drew DeVault wrote:
> This is useful for users who are trying to identify the firmwares in use
> on their system.
> 
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> ---
>  drivers/base/firmware_loader/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index bf44c79beae9..139d40a2f423 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -34,6 +34,7 @@
>  #include <linux/reboot.h>
>  #include <linux/security.h>
>  #include <linux/xz.h>
> +#include <linux/kernel.h>
>  
>  #include <generated/utsrelease.h>
>  
> @@ -504,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  					 path);
>  			continue;
>  		}
> +		printk(KERN_INFO "Loading firmware from %s\n", path);

And it's totally noisy :(

Also, if you have a 'struct device' you should always use the dev_*()
calls instead, which will show you exactly what device is asking for
what.

Please just make this a debug call, that way you can turn it on
dynamically if you really want to see what firmware is attempting to be
loaded.

thanks,

greg k-h
