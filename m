Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32E1499D1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgAZJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 04:35:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgAZJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 04:35:10 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iveJt-0008EY-VK; Sun, 26 Jan 2020 09:35:06 +0000
Date:   Sun, 26 Jan 2020 10:35:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: binderfs interferes with syzkaller?
Message-ID: <20200126093506.oa2ee5kbptur4zhz@wittgenstein>
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
 <20200126085535.GA3533171@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200126085535.GA3533171@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 09:55:35AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 25, 2020 at 06:49:49PM +0100, Dmitry Vyukov wrote:
> > Hi binder maintainers,
> > 
> > It seems that something has happened and now syzbot has 0 coverage in
> > drivers/android/binder.c:
> > https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> > It covered at least something there before as it found some bugs in binder code.
> > I _suspect_ it may be related to introduction binderfs, but it's
> > purely based on the fact that binderfs changed lots of things there.
> > And I see it claims to be backward compatible.
> 
> It is backwards compatible if you mount binderfs, right?

Yes, it is backwards compatible. The devices that would usually be
created in devtmpfs are now created in binderfs. The core
binder-codepaths are the same.

Christian
