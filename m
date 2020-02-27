Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF71721A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbgB0Oxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:53:54 -0500
Received: from foss.arm.com ([217.140.110.172]:53154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgB0Oxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:53:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0540B30E;
        Thu, 27 Feb 2020 06:53:53 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DADA53F7B4;
        Thu, 27 Feb 2020 06:53:52 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A8D62682F2C; Thu, 27 Feb 2020 14:53:51 +0000 (GMT)
Date:   Thu, 27 Feb 2020 14:53:51 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        Brian Starkey <brian.starkey@arm.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 21/21] drm/arm: have malidp_debufs_init() return void
Message-ID: <20200227145351.GZ364558@e110455-lin.cambridge.arm.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-22-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227120232.19413-22-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:02:32PM +0300, Wambui Karuga wrote:
> As there's no need for the return value in malidp_debugfs_init() after
> the conversion of the drm_driver.debugfs_init() hook, (drm: convert the
> .debugs_init() hook to return void), convert the malidp_debugfs_init()
> function to return void.
> 
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks!
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 37d92a06318e..def8c9ffafca 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -548,7 +548,7 @@ static const struct file_operations malidp_debugfs_fops = {
>  	.release = single_release,
>  };
>  
> -static int malidp_debugfs_init(struct drm_minor *minor)
> +static void malidp_debugfs_init(struct drm_minor *minor)
>  {
>  	struct malidp_drm *malidp = minor->dev->dev_private;
>  
> @@ -557,7 +557,6 @@ static int malidp_debugfs_init(struct drm_minor *minor)
>  	spin_lock_init(&malidp->errors_lock);
>  	debugfs_create_file("debug", S_IRUGO | S_IWUSR, minor->debugfs_root,
>  			    minor->dev, &malidp_debugfs_fops);
> -	return 0;
>  }
>  
>  #endif //CONFIG_DEBUG_FS
> -- 
> 2.25.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
