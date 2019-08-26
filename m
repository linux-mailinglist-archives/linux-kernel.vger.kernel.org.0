Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0596C9C88C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfHZExT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 00:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfHZExT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:53:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4C92070B;
        Mon, 26 Aug 2019 04:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566795198;
        bh=Y3mEduzKt2IMLRPCc/9d2tQAduv/qs1pdxGcl2GFft0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyAooLrKGZoXcgtWaM75AD61npujRwChi/03co9+kSqt1+0c8py9dZJehKnajJKkx
         rJaHOMobdxkVin8ch8Uy+uOInt7rqFwiFEve5XVFLuxtEmqsNewr12DiBcQSUKwfY3
         znLCKoyLVivek0GCr1uDhRSvtPLzE9b30oxff7QU=
Date:   Mon, 26 Aug 2019 06:53:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: storage: ums-realtek: Rename module parameter
 auto_delink_en to auto_delink_mode
Message-ID: <20190826045315.GC1678@kroah.com>
References: <20190826044630.21949-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826044630.21949-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:46:29PM +0800, Kai-Heng Feng wrote:
> The option named "auto_delink_en" is a bit misleading, as setting it to
> false doesn't really disable auto-delink but let auto-delink be firmware
> controlled.
> 
> Rename it to reflect the real usage of this parameter.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/storage/realtek_cr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index cc794e25a0b6..4d86cfcc0b40 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -36,9 +36,9 @@ MODULE_DESCRIPTION("Driver for Realtek USB Card Reader");
>  MODULE_AUTHOR("wwang <wei_wang@realsil.com.cn>");
>  MODULE_LICENSE("GPL");
>  
> -static int auto_delink_en = 1;
> -module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
> -MODULE_PARM_DESC(auto_delink_en, "enable auto delink");
> +static int auto_delink_mode = 1;
> +module_param(auto_delink_mode, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(auto_delink_mode, "auto delink mode (0=firmware, 1=software [default])");

We can not just rename module parameters, as that will break working
systems that have their startup scripts using those names :(

sorry,

greg k-h
