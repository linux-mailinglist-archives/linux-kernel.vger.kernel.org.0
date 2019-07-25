Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDC74880
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbfGYHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 03:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbfGYHzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:55:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031F5217F4;
        Thu, 25 Jul 2019 07:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564041306;
        bh=+tV5n5sf9wkieKz1ys/rYJZbU4avHfRqWAEuAygUAsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vEWb+a0imLFCZ742kKF0nm457xfdd0Y/iYu3AqTmEO9s5mdB808vWdCtpKr6TQQiT
         5KJk9UGRUHLmuJNJk3wajuP0T5+voMa2iCRF612G27T1cv/teMYXUIX4Bveu5hATau
         euCAs+Mk6pOarNlfHG2u2b7/pP6+StS2+hy9HWUM=
Date:   Thu, 25 Jul 2019 09:55:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Disable procfs debugging by default
Message-ID: <20190725075503.GA16693@kroah.com>
References: <20190718092522.17748-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718092522.17748-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:25:22PM +0800, Kai-Heng Feng wrote:
> The procfs provides many useful information for debugging, but it may be
> too much for normal usage, routines like proc_get_sec_info() reports
> various security related information.
> 
> So disable it by defaultl.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/staging/rtl8723bs/include/autoconf.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
> index 196aca3aed7b..8f4c1e734473 100644
> --- a/drivers/staging/rtl8723bs/include/autoconf.h
> +++ b/drivers/staging/rtl8723bs/include/autoconf.h
> @@ -57,9 +57,5 @@
>  #define DBG	0	/*  for ODM & BTCOEX debug */
>  #endif /*  !DEBUG */
>  
> -#ifdef CONFIG_PROC_FS
> -#define PROC_DEBUG
> -#endif

What?  Why?  If you are going to do this, then rip out all of the code
as well.

And are you _sure_ you want to do this?

thanks,

greg k-h
