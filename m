Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8A12360F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 20:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLQT4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 14:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQT4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:56:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5623620716;
        Tue, 17 Dec 2019 19:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576612576;
        bh=hd4cH8IbYkeM0tBUNDdElhYaMjG1+McopALX9rBJrMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i17VwzGB1Ibwv7zq4kFod+YOQHxxpYbh/kvmyLn5CrQDs4HtDy5Sbo+a0ImeH+K2t
         udYZKn3rX2Q6QXUInDEfI6DDeCfvauJ8YM+Vi+ymUfHShLUciaCyxE24isTCEX1Xgr
         opAD4BLYdLozUaZvK5ORYrYsXU7IUeXhOcpqypQI=
Date:   Tue, 17 Dec 2019 20:56:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: don't forget compat_ioctl on unrandom
Message-ID: <20191217195614.GA4124759@kroah.com>
References: <20191217172455.186395-1-Jason@zx2c4.com>
 <CAK8P3a00O6_XjUd33_4esaEXu4fEf4+3fvrttXMzx=-1ruFaAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a00O6_XjUd33_4esaEXu4fEf4+3fvrttXMzx=-1ruFaAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 08:36:48PM +0100, Arnd Bergmann wrote:
> On Tue, Dec 17, 2019 at 6:25 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Recently, there's been some compat ioctl cleanup, in which large
> > hardcoded lists were replaced with compat_ptr_ioctl. One of these
> > changes involved removing the random.c hardcoded list entries and adding
> > a compat ioctl function pointer to the random.c fops. In the process,
> > urandom was forgotten about, so this commit fixes that oversight.
> >
> > Fixes: 507e4e2b430b ("compat_ioctl: remove /dev/random commands")
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> Thanks for debugging this. I had already sent the same
> patch a few days ago after the first report:
> 
> https://lore.kernel.org/lkml/20191207185837.4030699-1-arnd@arndb.de/
> 
> Greg, can you please apply one of these and send it to Linus for 5.5-rc3?

Ugh, I missed your first one, sorry, I thought that was for Ted and
missed that it was due to a patch that came from my tree.  I've queued
Jason's patch up now.

thanks,

greg k-h
