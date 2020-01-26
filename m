Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5788F1499AB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 09:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgAZIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 03:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgAZIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 03:55:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102E32071A;
        Sun, 26 Jan 2020 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580028937;
        bh=n2nIzaSKhRLa1kWmgJ3uBhJ4DhQVJLVuCuYtEtMl7ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zrTfA3F4bkp7cB9QtVrBzAFPiesqw1fwFv7dkwpGgQSIMyD8XRU6JhMpbeZ13PZig
         pwJvqvC+3U8/IKhEdZK9Nbx6MfciCWkyrUiy6AE04uYitUOoVrMxDxLYk2Jgiov6iy
         87eMDtaAqLn1gmhdttbmT/KOcuu8DXhQ2NR6J4wk=
Date:   Sun, 26 Jan 2020 09:55:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: binderfs interferes with syzkaller?
Message-ID: <20200126085535.GA3533171@kroah.com>
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 06:49:49PM +0100, Dmitry Vyukov wrote:
> Hi binder maintainers,
> 
> It seems that something has happened and now syzbot has 0 coverage in
> drivers/android/binder.c:
> https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> It covered at least something there before as it found some bugs in binder code.
> I _suspect_ it may be related to introduction binderfs, but it's
> purely based on the fact that binderfs changed lots of things there.
> And I see it claims to be backward compatible.

It is backwards compatible if you mount binderfs, right?

> syzkaller strategy to reach binder devices is to use
> CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
> give each test process a private one):
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671
> 
> Then it knows how to open these /dev/binderN devices:
> https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
> and do stuff with them.
> 
> Did these devices disappear or something?

Try mounting binderfs and then you should be able to see them all.

thanks,

greg k-h
