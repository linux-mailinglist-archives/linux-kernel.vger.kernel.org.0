Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A1511CDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfLLNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 08:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfLLNB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:01:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04152077B;
        Thu, 12 Dec 2019 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576155717;
        bh=pWgNvqXet4LH3PkcvGVfv98b+VUxCZbr2CtDYCpWV2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fkh6+EaOYXdSIVL3tHyJbC2KIrvFDI278JL4EcAXWkhjinavTusHEQa/zkvXGwR1h
         Rj8RxrtkHOOF/F/V1tI+BWLzHUm6s6m6Swo5ibqgJi2ixWQx/7XXcZm5+GDYGEp+C4
         aVWxzdCeijD0LiZuKKhEr6BEcYXCBCevAzkQUXHQ=
Date:   Thu, 12 Dec 2019 14:01:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, peng.hao2@zte.com.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pvpanic: add crash loaded event
Message-ID: <20191212130155.GA1544206@kroah.com>
References: <20191212123226.1879155-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212123226.1879155-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:32:26PM +0800, zhenwei pi wrote:
> Some users prefer kdump tools to generate guest kernel dumpfile,
> at the same time, need a out-of-band kernel panic event.
> 
> Currently if booting guest kernel with 'crash_kexec_post_notifiers',
> QEMU will recieve PVPANIC_PANICKED event and stop VM. If booting
> guest kernel without 'crash_kexec_post_notifiers', guest will not
> call notifier chain.
> 
> Add PVPANIC_CRASH_LOADED bit for pvpanic event, it means that guest
> actually hit a kernel panic, but kernel wants to handle by itself.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/misc/pvpanic.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 95ff7c5a1dfb..a8cc96c90550 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/kernel.h>
> +#include <linux/kexec.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -19,6 +20,7 @@
>  static void __iomem *base;
>  
>  #define PVPANIC_PANICKED        (1 << 0)
> +#define PVPANIC_CRASH_LOADED    (1 << 1)

BIT(1)?

>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -34,7 +36,13 @@ static int
>  pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
>  		     void *unused)
>  {
> -	pvpanic_send_event(PVPANIC_PANICKED);
> +	unsigned int event = PVPANIC_PANICKED;
> +
> +	if (kexec_crash_loaded())
> +		event = PVPANIC_CRASH_LOADED;
> +
> +	pvpanic_send_event(event);

Who gets this event to know that the above new bit is set or not?

thanks,

greg k-h
