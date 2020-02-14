Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9715F92E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 23:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBNWBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 17:01:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:40180 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726099AbgBNWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:01:13 -0500
Received: (qmail 7837 invoked by uid 2102); 14 Feb 2020 17:01:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2020 17:01:11 -0500
Date:   Fri, 14 Feb 2020 17:01:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Joe Perches <joe@perches.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Use const to reduce object data size
In-Reply-To: <60559197a1af9e0af7f329cc3427989e5756846f.camel@perches.com>
Message-ID: <Pine.LNX.4.44L0.2002141700390.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020, Joe Perches wrote:

> Make structs const to reduce data size ~20KB.
> 
> Change function arguments and prototypes as necessary to compile.
> 
> $ size (x86-64 defconfig pre)
>    text	   data	    bss	    dec	    hex	filename
>   12281	  10948	    480	  23709	   5c9d	./drivers/usb/storage/usb.o
>     111	  10528	      8	  10647	   2997	./drivers/usb/storage/usual-tables.o
> 
> $ size (x86-64 defconfig post)
>    text	   data	    bss	    dec	    hex	filename
>   22809	    420	    480	  23709	   5c9d	drivers/usb/storage/usb.o
>   10551	      0	      0	  10551	   2937	drivers/usb/storage/usual-tables.o
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> compile tested only
> 
>  drivers/usb/storage/usb.c          | 10 +++++-----
>  drivers/usb/storage/usb.h          |  5 +++--
>  drivers/usb/storage/usual-tables.c |  6 +++---
>  include/linux/usb_usual.h          |  2 +-
>  4 files changed, 12 insertions(+), 11 deletions(-)

It all looks quite reasonable.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

