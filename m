Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6405C16ED6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgBYSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 13:02:30 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31541 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgBYSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:02:29 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01PI2Jho001120;
        Tue, 25 Feb 2020 19:02:19 +0100
Date:   Tue, 25 Feb 2020 19:02:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225180219.GA395@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:22:47PM +0300, Denis Efremov wrote:
> I think that for the first attempt changing will be enough:
> -static int fdc;                        /* current fdc */
> +static int current_fdc;                        /* current fdc */
> and
> -#define FD_IOPORT fdc_state[fdc].address
> +#define FD_IOPORT fdc_state[current_fdc].address
> and for fd_setdor in ./arch/arm/include/asm/floppy.h

So after a bit more digging, that should not be correct because:
  - disk_change() uses a local "fdc" variable with expectations that
    it will be used by fd_inb(FD_DIR)
    
  - set_dor() uses a local fdc argument that's used by
    fd_outb(newdor, FD_DOR)

Here we have "fdc" hidden in:
  - FD_DOR/FD_DIR (referencing FD_IOPORT) on x86
  - fd_outb(), relying on fd_setdor() on ARM

I'm now looking how to change fd_outb() to pass the fdc in argument,
after all it's not that many places and that's exactly what we need.
Maybe afterwards we'll figure that some of them are still wrong :-)

Willy
