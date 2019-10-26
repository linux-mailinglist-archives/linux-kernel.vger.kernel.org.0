Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA814E58A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 06:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfJZEk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 00:40:56 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:7919 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfJZEk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 00:40:56 -0400
X-IronPort-AV: E=Sophos;i="5.68,230,1569276000"; 
   d="scan'208";a="408354237"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 06:40:54 +0200
Date:   Sat, 26 Oct 2019 06:40:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: gasket: Fix line
 ending with a '('
In-Reply-To: <20191025233909.GA1599@cristiane-Inspiron-5420>
Message-ID: <alpine.DEB.2.21.1910260640340.2559@hadrien>
References: <20191025233909.GA1599@cristiane-Inspiron-5420>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2019, Cristiane Naves wrote:

> Fix line ending with a '('
>
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/staging/gasket/gasket_ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index 240f9bb..d1b3e9a 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -34,8 +34,8 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev,
>
>  	trace_gasket_ioctl_eventfd_data(die.interrupt, die.event_fd);
>
> -	return gasket_interrupt_set_eventfd(
> -		gasket_dev->interrupt_data, die.interrupt, die.event_fd);
> +	return gasket_interrupt_set_eventfd(gasket_dev->interrupt_data,
> +					    die.interrupt, die.event_fd);
>  }
>
>  /* Read the size of the page table. */
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191025233909.GA1599%40cristiane-Inspiron-5420.
>
