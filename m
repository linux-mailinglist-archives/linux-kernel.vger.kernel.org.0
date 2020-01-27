Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36D14A84F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgA0QsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:48:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40095 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0QsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:48:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so11451673ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ga8+AQLvFFd6qgmO7oS/OlOLpF/zAlkFwxPfiQu4fzM=;
        b=iS6N+V6/yjfmJ+cX5wU/06q/h68H/dzYW7YSnOHtqCvXDM1L3TdF8RLlD1ibbLLM7b
         2PSpZE8W3QJRwNxFu5+eEYx/cIqXXQzFwz2V+MZfOsuA8AYYj+JrYMzrRuYYi75Nloc2
         bVe86FJoM1mbsboQCcW9y556dM41lUf8bWFCOIcckHshmZana/jA7dxn0+kRMC8UXeJa
         mV41hz4ol8OI8fdaEG3d8IwiuwIkPmGwkphpAsYBv+/uHS3cTKDH9zZ8Vup/8wiJkxW8
         TEMFLuLdYOUu4RPN4v7MMbQ5aAIM8yyQi9b4ub/qifcMpLJH+PykQPLx47CJkUXlqyG/
         82Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ga8+AQLvFFd6qgmO7oS/OlOLpF/zAlkFwxPfiQu4fzM=;
        b=QaEJ2gLzo+5g7PzOTpnXJR/0jOLrVHkFT2tf0UunKhpn+B5xS1Cvj8EDRrgkxL8jVd
         POczfzXnEbMfXKWmN1InTvK5EOXMydZfr5Pn4xbGW2fGWTXBhCY9+5om2oZsck4QENtR
         nrMSf3Iafv/M2o0Zmcrgb5uuVc9OfAdNnIOMyaURfQiGdHcbFEA4MaxFxFoE4BGp2Lvp
         3LxO13Whq6ug0sVspvtcLJLA/qaNKUprOrY3ifhV7bM1XJ8jWpfeapzTceBNFRL2aDCT
         wLBMuf2hOQHADwLh0N5z3PrMrlDF2YLaOnxcXaQuLdkweqB+OA/gqK80ChzSEceylSXt
         zfCw==
X-Gm-Message-State: APjAAAXyQrkN7ez+aB0FJVtys4A39xpc9h5YocN6mSFHtxnEsYDjuEAJ
        kAUEpMr+0IZmluIXXvEzcSwhSZkIizZlV3t8gp5dzQ==
X-Google-Smtp-Source: APXvYqzyrkrq3JxSLPU4ez7HAOrd7MfbSRl0//H4GgLnSwcoCHIkFByV99XiGMT43TPlU+/ozeM800lOExr5c/gaoSc=
X-Received: by 2002:a2e:88c4:: with SMTP id a4mr11112826ljk.174.1580143681421;
 Mon, 27 Jan 2020 08:48:01 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
 <20200126085535.GA3533171@kroah.com>
In-Reply-To: <20200126085535.GA3533171@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 27 Jan 2020 08:47:50 -0800
Message-ID: <CAHRSSEwoBKGiimbAGKavKpcEZrPgo0GYWu7JZmiXjwWo6fxqeA@mail.gmail.com>
Subject: Re: binderfs interferes with syzkaller?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
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

If binderfs is enabled and binderfs is mounted, then it's compatible
except that the path to be opened is under the binderfs mount point
instead of /dev/binderX.

>
> > syzkaller strategy to reach binder devices is to use
> > CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
> > give each test process a private one):
> > https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671
> >
> > Then it knows how to open these /dev/binderN devices:
> > https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
> > and do stuff with them.
> >
> > Did these devices disappear or something?
>
> Try mounting binderfs and then you should be able to see them all.
>
> thanks,
>
> greg k-h
