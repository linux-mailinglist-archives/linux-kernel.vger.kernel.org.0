Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA7E89AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfJ2Nii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:38:38 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10669 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388626AbfJ2Nii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:38:38 -0400
X-IronPort-AV: E=Sophos;i="5.68,244,1569276000"; 
   d="scan'208";a="409343048"
Received: from unknown (HELO hadrien) ([91.217.168.176])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 14:38:37 +0100
Date:   Tue, 29 Oct 2019 14:38:36 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning message from 'make nsdeps' when namespace is lower
 cases
In-Reply-To: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910291437450.2179@hadrien>
References: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2019, Masahiro Yamada wrote:

> Hi.
>
> When I was playing with 'make nsdeps',
> I saw a new warning.
>
> If I rename USB_STORAGE to usb_storage,
> I see 'warning: line 15: should usb_storage be a metavariable?'
> Why? I think it comes from spatch.

Yes, it would come from spatch.

> It should be technically OK to use either upper or lower cases
> for the namespace name.

What is normally wanted?  Uppercase or lowercase?

julia

>
> Just apply the following, and try 'make nsdeps'.
>
>
> diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
> index 46635fa4a340..6f817d65c26b 100644
> --- a/drivers/usb/storage/Makefile
> +++ b/drivers/usb/storage/Makefile
> @@ -8,7 +8,7 @@
>
>  ccflags-y := -I $(srctree)/drivers/scsi
>
> -ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage
>
>  obj-$(CONFIG_USB_UAS)          += uas.o
>  obj-$(CONFIG_USB_STORAGE)      += usb-storage.o
>
>
>
>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
>
