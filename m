Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62ADC136F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgAJObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 09:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:58248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgAJObP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:31:15 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED0C2077C;
        Fri, 10 Jan 2020 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578666674;
        bh=HgPahpXdshZgo/Yb5Xs234RcEyVF4p1fdHTEKPXXC+A=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lS8xc2Q2D11wQrtJIm28CF2qqKfz4e3KiC3sYg0ZJ+ljp2QwIZt9Q/sOzi4ezn5Oh
         MQbOkgJWEWhw0NBLi9D/nERGeL6GkhdZn2RpJAjNclZVoG7XAFnY8EhVdQuqGIvVJU
         9+Upe3RLWUbSE/EDzsxYU8KNb0HiCTvUwwf0tt9c=
Date:   Fri, 10 Jan 2020 15:31:10 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Marcel Holtmann <marcel@holtmann.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID fixes
In-Reply-To: <CAHk-=wji9frEf=nkfBmekhZs7QofyhDuT7_Lqt=kkjEZVAktzA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2001101530050.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm> <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com> <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm> <nycvar.YFH.7.76.2001092137460.31058@cbobk.fhfr.pm>
 <CAHk-=wh_-q=MPtYmcb4gUHtQ2M96BVrzoDo3pauU-Ps9Q5uPtg@mail.gmail.com> <CAHk-=wji9frEf=nkfBmekhZs7QofyhDuT7_Lqt=kkjEZVAktzA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Linus Torvalds wrote:

> > Now, good source code presumably notices EPOLLERR and handles it. So
> > it _shouldn't_ matter what the kernel does if an error occurs. I
> > haven't checked what people _actually_ do, tnough. I worry sometimes
> > that user space just looks at EPOLLIN sees it not being set, and gets
> > stuck in a busy loop polling in case of errors.
> 
> Googling around for it, I find this, for example:
> 
>     https://github.com/scylladb/seastar/issues/309
> 
> and yes, I think that's technically a user space bug, but it's very
> much an example of this: they expect to get errors through read() or
> write() calls, and get confused when poll() does not say that the fd
> is readable or writable.
> 
> I don't know how common this is, but it didn't take a _lot_ of
> googling for me to find that one..

Right, I think it's quite a convicing argument, and the issue is rather 
easy to avoid. I'll fix that up in the patch and send a fixup pull request 
to you later today.

Marcel, please speak up if you have other plans.

-- 
Jiri Kosina
SUSE Labs

