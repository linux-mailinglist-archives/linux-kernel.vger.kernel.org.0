Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8016EB02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbgBYQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 11:12:42 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31532 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbgBYQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:12:42 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01PGCUr0032043;
        Tue, 25 Feb 2020 17:12:30 +0100
Date:   Tue, 25 Feb 2020 17:12:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     efremov@linux.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225161230.GA32037@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
 <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
 <9c22a4ce-1108-d1aa-49c3-5fe7c3bb74f1@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c22a4ce-1108-d1aa-49c3-5fe7c3bb74f1@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:39:05PM +0300, Denis Efremov wrote:
> On 2/25/20 6:22 PM, Denis Efremov wrote:
> > As for now, I can see that only floppy.c includes fdreg.h file
> > with define FDPATCHES. If it's true then #define FD_IOPORT 0x3f0 
> > branch is never used and we can try to fix remaining FD_* macro
> > in the next round.
> 
> Ah, I forgot that fdregs.h is uapi. Thus, we can't simplify FDPATCHES.

Yep, that's why we can't do it. I also agree with the other change of
fdc->current_fdc in floppy.h, I think it's the most reasonable. And if
it breaks anywhere, it will simply have uncovered new latent bugs
because it will mean that it was using the wrong fdc.

Willy
