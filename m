Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59C71295D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 13:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLWMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 07:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfLWMGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 07:06:53 -0500
Received: from localhost (50-198-241-253-static.hfc.comcastbusiness.net [50.198.241.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963112063A;
        Mon, 23 Dec 2019 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577102812;
        bh=UJGipIs3R0eAFs/+vxP9hO/yM5VYdXO2adysSDweAhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fz2yc8cDetWe4VFTEb9zU418nJ8+h2ixEHwK4M1+tCvv5q0EELvft/sEOBf9OgdBR
         g0fKDmEZbkFl2tFeMH9BQ1G7px1JKNKQDztlyAmvqszPwo/LkD3g/nqrzqTVfXE/rK
         hrYisPKy4oJF9GfEm80pUeULbSfvMr+fxK55XIWY=
Date:   Mon, 23 Dec 2019 07:06:51 -0500
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.5-rc3
Message-ID: <20191223120651.GC114474@kroah.com>
References: <20191220070747.GA2190169@kroah.com>
 <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whcLH7EXVZbD0g1Bw7McrofQ-7vwiL2GAeMn=z9PP4VEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 10:08:03AM -0800, Linus Torvalds wrote:
> On Thu, Dec 19, 2019 at 11:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > The last tty core fix should resolve a long-standing bug with a race
> > at port creation time that some people would see, and Sudip finally
> > tracked down.
> 
> Hmm, looks good. But it makes me wonder if we should now try to remove
> the second call to tty_port_link_device()?
> 
> Now we have a number of helpers that do that tty_port_link_device()
> call for the driver (eg tty_port_register_device_attr_serdev(),
> tty_port_register_device_attr(), and the just added
> uart_add_one_port()).
> 
> But we also have drivers doing it by hand, and presumably we now have
> drivers that do it through multiple paths? I guess it's harmless, but
> it feels a bit odd. No?

It does.  I'll try to look at this after the holidays unless Sudip beats
me to it.

thanks,

greg k-h
