Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA61FD83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfEPBqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33326 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEOXpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:45:51 -0400
Received: by mail-lj1-f174.google.com with SMTP id w1so1407042ljw.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvNT9HlDb1U3GFh1Fv/LSA0RjY1svVk5+rl3ZUL9cA0=;
        b=d4uPRGGPWp4sUCTPgCXRTo/SOy5wf3Fv3B24MNLSC/6oIZK+kGJ5H/g6Cy5bu0jwtC
         t12fdaj6McFSwM/i/4KHSkKe8Vk/GTvEffEy8RfjMxOfX6JTSsWMg0lOIBFg3sVIn4rh
         /wYdFilszy8spI2+EvIEbchFFAUvwvDelxLGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvNT9HlDb1U3GFh1Fv/LSA0RjY1svVk5+rl3ZUL9cA0=;
        b=UJDjvLk4lJf4BcgrxtyQpVBWb1aCFpudLi018E7rhGcLgl7DtdS4/1HzUpVvas9lDa
         fAP6MC224WjgACFKxz+VAF+4iKqSHvZG9OxYRlGtNQEitmcsRykdGAP4mqq6sGJDeroP
         /DdVfcuSflp7y0G/H2/s0iTERqdAx4MQGxR5kA3C/d2TB8sDr2m6wEVCZuSblVirDN0m
         yEVhwqQTR7L7Yb4mU66sxP8RFG0G9lS0FLWYF+Uzxmk3gfg8jZWCzSYYPxidwvshXDkp
         jtEnR4kTSjw7Xkx94NuT3f/yN13ehYyelFZ+tnCL7Q/0JWemBy0BaYZLHq+B9Fj4Uxmr
         bqxg==
X-Gm-Message-State: APjAAAWsAaunSoDAna0NbtZS/DYTYMGCRxKvpOkVIpCvCElUh+hrSbGq
        9ps2uCO0L1ZvAzN+04kMBJ+wLD15yJg=
X-Google-Smtp-Source: APXvYqyBGMxn4xej32gAKM4it4HZ+Ql9l49Zm893cbejpovwYvBjbLtFGZsYh9Q9m/pg/5ukVZzvJw==
X-Received: by 2002:a2e:5d49:: with SMTP id r70mr23441189ljb.102.1557963949035;
        Wed, 15 May 2019 16:45:49 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id e14sm652965ljk.45.2019.05.15.16.45.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 16:45:47 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a10so1367010ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 16:45:47 -0700 (PDT)
X-Received: by 2002:a2e:9a94:: with SMTP id p20mr11981537lji.2.1557963947423;
 Wed, 15 May 2019 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190515135602.2a6e6012@oasis.local.home>
In-Reply-To: <20190515135602.2a6e6012@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 May 2019 16:45:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
Message-ID: <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
Subject: Re: [GIT PULL] ktest: Updates for 5.2
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Warthog9 Hawley <warthog9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Updates to ktest.pl

Your pull request is showing stale data.

>  - Handle meta data in GRUB_MENU
>
>  - Add variable to cusomize what return value the reboot code should return.

These were already long merged, from your first pull request last Monday.

See

  68253e718c27 ("Merge tag 'ktest-v5.1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest")

and your own pull request

  Message-ID: <20190506133837.55832171@gandalf.local.home>

Hmm?

                Linus
