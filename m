Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B989C5D2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 21:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfHYTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 15:36:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41825 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHYTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:36:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id m24so13124497ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAswaA+5kfAJ/8Xl6w/3NSvkuweofFlH8yoI56Fa/nI=;
        b=Vu6husFeGUaigOJXCqEcSBrt04gWZ1s+iUlkA0koyfGUSNXHjUSnWnayL6tT/h+8Sk
         PWx8ZOZWbbSgKhYytJHG91IFsyzEL6IBYgLJuDe6pNDP8PhRLKnKlg9qzu1UvrVieDGI
         vMi+e80N+H6Dqd7F8bauQkAZ0fTAgijYRS0Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAswaA+5kfAJ/8Xl6w/3NSvkuweofFlH8yoI56Fa/nI=;
        b=OaQJXGFiO9s51FElAyGjIHuwdTYGAJuR7xIN0AyRUtZFQoJTU5HlUhs8B7lmRiWvRu
         1QLEh+8h/R7LGQZ0Uz8Jitpe9CB6Y2vPyjbu1WlM6p9yEaerptNcJsf174OeT/SZ1bew
         nBLDshEyBaAQevLfSUktM5dlqfmn9hvqWCOvQAcST1ZFLnyKOYCwmZicEzXkmLAcfN4r
         +19EuzznqiEpkb36+aKmLmcoips91rNRQWonpQdQE1xko4pFYYSeh5ogFyuY6WmKIr3l
         VpfouD6+8qU1EOlzHGzLoaVhK2HBcfWxR91iy5VTargOXCWnOcFTGSzf9rXwkGiLrJZR
         /3SA==
X-Gm-Message-State: APjAAAV75Ww9//XqL0/rlnp5ZFRkj9m9AsFTAfW1jupIk4b/JIbNDHlb
        M6Gqt8omKTRptqt6CSSehi66LyJ6g44=
X-Google-Smtp-Source: APXvYqzvIuEkPY+HZifFw9Y/qDsJVNtX2KTa2BDP5DukTdVZ5YTKGNUTe1GGyIX6sSy9CIf4SF7Iog==
X-Received: by 2002:a2e:2c09:: with SMTP id s9mr8612845ljs.222.1566761770727;
        Sun, 25 Aug 2019 12:36:10 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id s21sm1697066ljm.28.2019.08.25.12.36.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 12:36:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z17so13191584ljz.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:36:09 -0700 (PDT)
X-Received: by 2002:a2e:7018:: with SMTP id l24mr8519623ljc.165.1566761769215;
 Sun, 25 Aug 2019 12:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic> <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic> <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
In-Reply-To: <20190825193218.GD20639@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 25 Aug 2019 12:35:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
Message-ID: <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
To:     Borislav Petkov <bp@suse.de>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 12:32 PM Borislav Petkov <bp@suse.de> wrote:
>
>
> and also on all the remaining 15 CPUs of the guest. Then, suspending to
> RAM and resuming right afterwards says:
>
> and the remaining 14(!). Yes, this doesn't run on the BSP during resume.
> I think the better thing to do would be to stick this in a CPUHP
> notifier...

You know what? The days of UP are long gone, and we really only want a
one-time warning, so I think your thing is fine as-is.

It would be good to test with a known-bad setup, of course..

                   Linus
