Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA1B3FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfIPRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 13:44:54 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:42811 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfIPRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:44:53 -0400
Received: by mail-lf1-f51.google.com with SMTP id c195so630685lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uipfU8HulVEUTGxV4YdJJv+JjF46ahJtoBSAjnbUb1c=;
        b=WOAENpjpGuUZ7Alp1ItN7/TmlL8bcS9/Z3/xKjjIfN0YI+SYYMoGtITKjTdjBG2d5a
         J0Cbfi+4Uwsz+z7yaG3a/IhY1bqDJQpmQGM2M5pJ/Xy8SFGFV9201+C9pU6KQyoTOGfa
         ZGgqDD3A0QEo81MYj1+6xzf+KpLWD6hKgAAx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uipfU8HulVEUTGxV4YdJJv+JjF46ahJtoBSAjnbUb1c=;
        b=SSkvey665NFKqZ2kaa3eYSrDCQL3HxVDVNLzGIsIbUBiEfqKUh/fQBWZzYK1KCR0OB
         As8C9JPF4n5ntPUuo6T7yucxptGdpmnbtHszL/rTBucPj75YF4hS64mQraIuahI/5YQW
         4j2XolOXQGqlOpzY+e4j8/mEpTd+schnCnRIkDMKAFHGXcRAhnXGvDL0y/pjs6AanlAC
         bE6id32MIuy38gsqQtJGU5WdaH8P9qJqqNVhkGPuFS7LQU+fzp2rquBT0Q9daSViT2Dw
         qn2uKbJSnTao5OsnQBFUgT1COBnAUMFc7dl34+Tc7BrxB/AwBCGEu+mN3aVPi5CfSRse
         tq+w==
X-Gm-Message-State: APjAAAXK2DywWzTvW6iOSyx7/rte92gnWsIMli2JbGH7txJV0Z/ANlgv
        A4p6+jWjra8h/RMj/ye3oMiep3XSzfg=
X-Google-Smtp-Source: APXvYqy0NHFhrl6AcHr/g5VVsUFAunZXh04vhqnxIcclYDp7wqbHLt27z1pEatRnCoOF81iKws8Q8g==
X-Received: by 2002:ac2:4552:: with SMTP id j18mr352687lfm.120.1568655890174;
        Mon, 16 Sep 2019 10:44:50 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z72sm8583343ljb.98.2019.09.16.10.44.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:44:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id u28so650287lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:44:48 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr339324lfn.52.1568655888261;
 Mon, 16 Sep 2019 10:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
In-Reply-To: <20190916172117.GB15263@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 10:44:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
Message-ID: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Willy Tarreau <w@1wt.eu>, Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:21 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> We could create a new flag, GRND_INSECURE, which never blocks.  And
> that that allows us to solve the problem for silly applications that
> are using getrandom(2) for non-cryptographic use cases.

Note that getting "reasonably good random numbers" is definitely not silly.

If you are doing things like just shuffling a deck of cards for
playing solitaire on your computer, getting a good enough source of
randomness is nontrivial. Using getrandom() for that is a _very_ valid
use. But it obviously does not need _secure_ random numbers.

It is, in fact, _so_ random that we give that AT_RANDOM thing to every
new process because people want things like that. Sadly, people often
aren't aware of it, and don't use that as much as they could.

(Btw, we should probably also mix in other per-process state, because
right now people have actually attacked the boot-time AT_RANDOM to
find canary data etc).

So I think you are completely out to lunch by calling these "insecure"
things "silly". They are very very common. *WAY* more common than
making a long-term secure key will ever be. There's just a lot of use
of reasonable randomness.

You also are ignoring that we have an existing problem with existing
applications. That happened exactly because those things are so
common.

So here's my suggestion:

 - admit that the current situation actually causes problems, and has
_existing_ bugs.

 - throw it out the window, with the timeout and big BIG warning when
the problem cases trigger

 - add new GRND_SECURE and GRND_INSECURE flags that have the actual
useful behaviors that we currently pretty much lack

 - consider the old 0-3 flag values legacy, deprecated, and unsafe
because they _will_ time out to fix the existing problem we have right
now because of their bad behavior.

And stop with the "insecure is silly". Insecure is not silly, and in
fact should have been the default, because

 (a) insecure is and basically always will be the common case by far

 (b) insecure is the "not thinking about it" case and should thus be default

and that (b) is also very much why 0 should have been that insecure case.

Part of the problem is exactly the whole "_normally_ it just works, so
using 0 without thinking about it tests out well".

Which is why getrandom(0) is the main problem we face.

Because defaults matter.

               Linus
