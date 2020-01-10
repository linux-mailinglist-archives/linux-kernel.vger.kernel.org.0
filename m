Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36381136CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 13:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgAJMYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 07:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgAJMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:24:37 -0500
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1C52077C;
        Fri, 10 Jan 2020 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578659077;
        bh=HCvJP+UdwCX6Q2crGVwKn7N7yPIf75Fk5SPzBBin100=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kk0BBdWnW5aZ1JZ6Bcv8/vIsAgIMssATKbTDPONtWkM/Cgi7cxGtGWEXBOoieyrvg
         Zj1aE3c6SqAmUSHHkXwNZOhcnMGRVV0iBdWd/cnqUR4lKSjCL5Ko79R7x32ydPB4U7
         Ee8QKutkNtOIosejv/SM5hQu39TB3vjjFxTzbWxw=
Date:   Fri, 10 Jan 2020 13:19:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vc04_service: remove unused header include path
Message-ID: <20200110121951.GA1047840@kroah.com>
References: <20200104162829.20400-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104162829.20400-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 01:28:29AM +0900, Masahiro Yamada wrote:
> I can build drivers/staging/vc04_services without this.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/staging/vc04_services/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index afe43fa5a6d7..54d9e2f31916 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -13,5 +13,5 @@ vchiq-objs := \
>  obj-$(CONFIG_SND_BCM2835)	+= bcm2835-audio/
>  obj-$(CONFIG_VIDEO_BCM2835)	+= bcm2835-camera/
>  
> -ccflags-y += -Idrivers/staging/vc04_services -D__VCCOREVER__=0x04000000
> +ccflags-y += -D__VCCOREVER__=0x04000000
>  
> -- 

This patch breaks the build for me:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:6:10: fatal error: interface/vchi/vchi.h: No such file or directory
    6 | #include "interface/vchi/vchi.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

So maybe you did't select all of the modules to build?

Sorry, I can't take this as-is :(

greg k-h
