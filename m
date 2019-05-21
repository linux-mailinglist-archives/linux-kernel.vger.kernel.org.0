Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC925586
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 18:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfEUQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 12:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEUQYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:24:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2122D208C3;
        Tue, 21 May 2019 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558455893;
        bh=1yav93c3s0CW0jwkGaIeXDoQbXwlBhxXytODTxJWX1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rU6JQUoAvmja5YUK1L4lvVwie2IZyU7NF60VS2zSzfNmgakQiG6qX7emwLvpL1GUi
         dSPzCVfyMUzWcUHboAOMZdiGyLg7FSmy48Kf/G/s827BBRmiQdeuGRZLyTFVeDC6AQ
         ckdScagWlx0dbweEf00MmdEjEzPzRSX33M/4/sVY=
Date:   Tue, 21 May 2019 18:24:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space
 conversion
Message-ID: <20190521162451.GA19139@kroah.com>
References: <20190521145116.24378-1-TheSven73@gmail.com>
 <20190521151059.GM31203@kadam>
 <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
 <20190521154241.GB15818@kroah.com>
 <CAGngYiU_iK5=swD_DA5PcOeYFT0zTrdQ+30Db0YrahuEukEP_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiU_iK5=swD_DA5PcOeYFT0zTrdQ+30Db0YrahuEukEP_A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:53:15AM -0400, Sven Van Asbroeck wrote:
> On Tue, May 21, 2019 at 11:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Ick, if you are using __force, almost always something is wrong.
> >
> 
> What if I create a separate structure for the regmap context ?
> 
> struct anybus_regmap_context {
>         void __iomem *base;
> };
> 
> Then just store the base pointer inside the struct, and pass the struct
> as the regmap context:
> 
> ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> ctx->base = base;
> devm_regmap_init(..., ctx);
> 
> static int write_reg_bus(void *context, unsigned int reg,
>                   unsigned int val)
> {
>         struct anybus_regmap_context *ctx = context;
>         <now access ctx->base>
> }

Ick, no.

> Penalty is an additional dynamic pointer-size
> allocation. Pro: it'll be formally correct ?

what is so odd about this code that makes you have to jump through
strange hoops that no other driver has to?

Just set your pointer types up properly to start with, and all should be
fine.  Why are you trying to cast anything here?

thanks,

greg k-h
