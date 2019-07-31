Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51197C71D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfGaPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:44:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33363 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:44:48 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so18415451iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsX4XfgYHIx0Ks8iO8OgXUq5IkTUq6aae68f1+yjlQI=;
        b=WxvIw2iyPVeIC/iNqk7I2SIHISdvuL90JO15ijRYglvi7BlFkdCQcF6FpMSHtw9dht
         Jz34vclpuQCNmGLOzlSWm4/DhBnIeTDcgJeajGCyhjsTsICrv14fQI1J7LZ4+vJ0qeyr
         araBDazAnWOXtK000jiQtp6ObIomOwJ8NRqJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsX4XfgYHIx0Ks8iO8OgXUq5IkTUq6aae68f1+yjlQI=;
        b=VvNGH+tFu4iN3Pfq34I7w2m39HRRPt9w0YGKsSc8QHdEofqs2qNBrc40VeV48WT9fG
         YfaIWdaY0V9ieQkrKCChX7U8ZZvpAuDuByrOwwIhTQV2vUkj3TyyJx4viz10iEXc3r/3
         rizAB07RtcE/1z5SHZ7gxsGefQrcOvkjWxPBHz8LTQnafwIfo7SXPhDotl+K42QGOX38
         +swUFjUFHfQd+WQ8P8CuyDpwm24z1doZ0CCez9iczGtnIdENGpJhbTt4cVoMpd3cV3qp
         ixguSZnXaGEiphBNjCquSw2IhY9XVDGwnSIpIjQz6oTXQOI6lsPW4SlQDoDV2VH9S2m6
         rKKg==
X-Gm-Message-State: APjAAAXyiiaFtK5EL89TM/SGVRfgQQjYgI6MI2twRXV1tHNXGfQrmVov
        v6WmSNwf3qgmB+Ug1mnObcyL+QeVMTg=
X-Google-Smtp-Source: APXvYqy841jkJXcHpp2zTTBIJp9XGuSzndxevu7c/5qqt32T1HhlBAXCHJVDdRRaZ/LFUF/WImHO7g==
X-Received: by 2002:a5d:964d:: with SMTP id d13mr18753599ios.224.1564587888026;
        Wed, 31 Jul 2019 08:44:48 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id z17sm90894300iol.73.2019.07.31.08.44.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:44:46 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h6so12093657iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:44:46 -0700 (PDT)
X-Received: by 2002:a5d:885a:: with SMTP id t26mr4018292ios.218.1564587885757;
 Wed, 31 Jul 2019 08:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190730234052.148744-1-dianders@chromium.org> <34bbd6b5-2e37-159a-b75b-36a6be11c506@siemens.com>
In-Reply-To: <34bbd6b5-2e37-159a-b75b-36a6be11c506@siemens.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Jul 2019 08:44:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uqa79UyFFj6zrr_B=rrwfmJAFLLatf8wQ73V70U-frvA@mail.gmail.com>
Message-ID: <CAD=FV=Uqa79UyFFj6zrr_B=rrwfmJAFLLatf8wQ73V70U-frvA@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: Handle split debug
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 31, 2019 at 7:24 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 31.07.19 01:40, Douglas Anderson wrote:
> > Some systems (like Chrome OS) may use "split debug" for kernel
> > modules.  That means that the debug symbols are in a different file
> > than the main elf file.  Let's handle that by also searching for debug
> > symbols that end in ".ko.debug".
>
> Is this split-up depending on additional kernel patches, is this already
> possible with mainline, or is this purely a packaging topic? Wondering because
> of testability in case it's downstream-only.

It is a packaging topic.  You can take a normal elf file and split the
debug out of it using objcopy.  Try "man objcopy" and then take a look
at the "--only-keep-debug" option.  It'll give you a whole recipe for
doing splitdebug.  The suffix used for the debug symbols is arbitrary.
If people have other another suffix besides ".ko.debug" then we could
presumably support that too...

For portage (which is the packaging system used by Chrome OS) split
debug is supported by default (and the suffix is .ko.debug).  ...and
so in Chrome OS we always get the installed elf files stripped and
then the symbols stashed away.

At the moment we don't actually use the normal portage magic to do
this for the kernel though since it affects our ability to get good
stack dumps in the kernel.  We instead pass a script as "strip" [1].


[1] https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/master/eclass/cros-kernel/strip_splitdebug


-Doug
