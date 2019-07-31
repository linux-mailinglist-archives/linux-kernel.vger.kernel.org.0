Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C17BA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 09:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGaHVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 03:21:49 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44105 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfGaHVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:21:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2B8F24C8;
        Wed, 31 Jul 2019 03:21:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 31 Jul 2019 03:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=IASG/165vAg3lwsVChfA/H8GkGe
        uDko3lIAWgtbJGI4=; b=PIv2yYBZYvO0S+68n05r9KRRWcsyVfvvoPFlqCRPydZ
        fx3Bh8PEeEbeF3KO8GqmvAJVqNBuYlpWhmALinkSWpfnFHAFGnBBhmFz0B6ISpG5
        r45Ii/CuRHvzAqTIiU5bWky7OZekagI8LYR57U5SeI3WBBFoJXD6xt47UGw0ZACK
        eiwthLoVhNsT7PUosfpveLMhVxoWleXugazPgGISb9zaWe9lEirXy0NXJwmEzWRe
        bmtOgXTm0Cb3ae5kWspzclItEhN7eRX0ERA5Vc1Ctkmb1Eoi94S9fsuDchKeIycK
        uydyCVwZnKccgVSH+gXQEptHvtYtDmz2YqgiCJnk8pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IASG/1
        65vAg3lwsVChfA/H8GkGeuDko3lIAWgtbJGI4=; b=SRKKDG1urRyuHo93IiOkrH
        hfzeWa4B5S+9tMO/pGVDS1Q33EqjgnCmKJafL9VPksisu/P1qKVgqOCqdCd7G703
        NkXaWLJQyDE52pesEphr+A9OvxWUA6TuiW6v67kMJwNgf/fC0WEfxQHT3NEa8H/W
        b+pYOwXvEiS/zbNRZElfskdphLFWmu63FAbMpYqnXiqSpCVBbw7VTq2A368EICrG
        EKZN3/wta1GQlOiL/80rByPHAfXweTS8nygTjdF0Ic+RkQRfhyciE7rcN0zGyxG+
        7Q40ViiXKjOBH0MQNVKpAw1LA+Ts8Vhv1ICxgwnor/pcCmj7m33DSFEwXI1KC8ZQ
        ==
X-ME-Sender: <xms:iUFBXQYNXJpVDM3levlCUBFTxTPdYMnGIwSMzlVt__q-1Yxxz15MKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:iUFBXdGeuocRsbbLEmKFlmJFpYwpX8_gLrbH2uBf1C_XZIXypzMNIw>
    <xmx:iUFBXaYKXIs6HiSjB8X865L1_T5Ie3OuW9KK7szh-GkW5YnTM56fBQ>
    <xmx:iUFBXURiKBIDxxaYc_wGLC0QIW_noYyp1Vr-cQZ7P73CDrjNUJeOVA>
    <xmx:iUFBXZKkuoylR3rpLeR7s25DVfUQvPQ1jXvUnVcO3UyRPDZOPFvEug>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1DD2380076;
        Wed, 31 Jul 2019 03:21:44 -0400 (EDT)
Date:   Wed, 31 Jul 2019 09:21:43 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the tty tree
Message-ID: <20190731072143.GA24490@kroah.com>
References: <20190731171221.326095e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731171221.326095e9@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:12:21PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   fa04d8c1c150 ("tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs")
> 
> Fixes tag
> 
>   Fixes: a5fa2660d787 ("tty/serial/fsl_lpuart: Add CONSOLE_POLL support
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Sorry about that, let me take your script and finally incorporate it
into my review scripts so this doesn't happen again.

thanks,

greg k-h
