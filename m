Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B24C28C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfFSUvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 16:51:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44169 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfFSUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:51:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so514012ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr00XCalu9BxXvOgaKUwp/Tuo/EGDGjVmPbF4AysT5A=;
        b=Q1FREvAhfqHLPs7hiXDan54VkBHE5Oj2EVjFMwHkWWC7wX7DAacLPKkQYU+IIcSvWH
         x1sSpDVOPkn0QmS6iGkFCAWW0CpcasVSCZOovaaN/vpoiMsyshW78DIDZMUx6Yu0bxeI
         xqUOuX56dOc/mPuWrrgkbOgpt+3frD4UIqPjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr00XCalu9BxXvOgaKUwp/Tuo/EGDGjVmPbF4AysT5A=;
        b=OpSRyjcV2ONF9Ul8OCcO9VCOnZAueC7iP7HCuDCfWWDm6d8tWie7S8VVqNk+doWNVN
         uloxQgERzY89mmwEzVrUoJHfPKMHnYtiUXCTV5CQOwrxlXOO73EbE0FOnqruxK7HPL/V
         KxKCkZShqNwCTDzHfQiN7DBOLIp6h34iMxpOhDQBflWFLmqH/qRVi1781Bv7xJx/v7m2
         vL/y7DcjWfpoCTvuPzm/0MevJ9Sxxy4t1WaT88cDF63+LibwPKE2IC/G95Pc4qdkor+S
         phQ8BiOtZw2pnV1iNUJHMjyaLOh2gABccKlUlH9FybsRgqeL3P+X5pD4Eho6aPZmq/q/
         F46g==
X-Gm-Message-State: APjAAAXJmUuqDRr30s38NwnAAmKTOxFOjKGgAzUK5OlTxBd4tMvGrLAt
        F97A35QhXRyAOJsb9UKPe8WfghiIq0Y=
X-Google-Smtp-Source: APXvYqwk63cHx07QnyMkNzyTDjIwM3NndKaom3Dvk8WxgUIty/tgmzIGVNjQmpvc4/0OpqrJlMHm4g==
X-Received: by 2002:a2e:7c15:: with SMTP id x21mr4186216ljc.55.1560976990379;
        Wed, 19 Jun 2019 13:43:10 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id a17sm3169259lfk.0.2019.06.19.13.43.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 13:43:09 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 16so504449ljv.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:43:09 -0700 (PDT)
X-Received: by 2002:a2e:b003:: with SMTP id y3mr34133328ljk.72.1560976989040;
 Wed, 19 Jun 2019 13:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
 <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
 <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com> <156097197830.664.13418742301997062555@skylake-alporthouse-com>
In-Reply-To: <156097197830.664.13418742301997062555@skylake-alporthouse-com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jun 2019 13:42:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
Message-ID: <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:19 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> > Do you have the oops itself at all?
>
> An example at
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/dmesg0.log
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/boot0.log
>
> The bug causing the oops is clearly a driver problem. The rc5 fallout
> just seems to be because of some shrinker changes affecting some object
> reaping that were unfortunately still active. What perturbed the CI
> team was the machine failed to panic & reboot.

Hmm. It's hard to guess at the cause of that. The oopses themselves
don't look like they are happening in any particularly bad context, so
all the normal reboot-on-oops etc stuff _should_ work.

So it would help a lot if you could bisect the bad problem at least a
bit, if it is at all reproducible. Because with no other clues, it's
hard to even guess at what might be up.

The fact that you say "NMI watchdog firing as we dumped the ftrace"
means that maybe it might be some ftrace / stacktrace issue where the
dumping itself leads to some endless loop, but who knows.

For example, one thing that has happened during this development cycle
is the stacktrace common infrastructure changes (arch_stack_walk() and
friends). I'm, not seeing why that would cause your issues, but I'm
adding a few random people for ftrace / stacktrace changes.

                     Linus
