Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1A181D10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgCKP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:58:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36629 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgCKP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:58:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so2943931ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsEQHYE0y+y5d13UNRJfwErW7gYfQrzha/Ji2nKV2Bs=;
        b=f70eOhsn4kSqi3NuTTLjoO+0Wc9NXo5nwZCyVCcqLPSEsncA2DAh2CuIxREXn5KSOl
         OHpNolXQuH5Jg2g/thOX9CzTzmWGZL/Q5/P36kufFk26yh34tjg9B5qfWo5ztc56e4u1
         SdIutscSxzCZADCUL9zQUcpJawXtUAEAdYyog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsEQHYE0y+y5d13UNRJfwErW7gYfQrzha/Ji2nKV2Bs=;
        b=V3em0/q3ga8wazP5stthxwP1tSWlFINtlEfHCyHONgk9z46rne2paxdu7b9il0meSy
         49gTcpxowBas4TYfKBXc+qssgVQBhRkv+gK+iZJO+FqcF5iEN4WcjGqs0Y5dKHbu6W9r
         42lj4Tm52e2B8anyHT4wiQn99FZIosW3N3S9dhvkCpF/EQgTcmUgTkyaHra8zXoWbsIm
         ++JApbr3gwwVlLQHs3XQYWonBkyxX1sMq1bfGJ+w6p/HXfIMaW+mKDw3LQ9xD/cJE0VZ
         oBsFC5woe5oLdnce1hPHCcYd86TEmcpDBefVb9F5qeyrUFIFD1j6BwrZHI055jn02g0D
         PzPw==
X-Gm-Message-State: ANhLgQ3VwwbL04fKnTftQEXYMTOAKPceQ/RrUyTh4Qcjg9o/lL8JWNLE
        e1he8nY0tQMo0GTFsevWVVL8ZH97GtQ=
X-Google-Smtp-Source: ADFU+vvMFyGdzdJ/pkCJRKuBqeP1NRUU+FlBn5WFeDuxMFEnzXGnL8MaHznppi90xqLDBxgn9Ow7nA==
X-Received: by 2002:a2e:8ec7:: with SMTP id e7mr2444055ljl.36.1583942294645;
        Wed, 11 Mar 2020 08:58:14 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h24sm13849546ljc.36.2020.03.11.08.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:58:13 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j15so2178624lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:58:12 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr2504756lfk.192.1583942292581;
 Wed, 11 Mar 2020 08:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <19498990-fb97-b739-cd19-6a6415ba88a2@gmx.com>
In-Reply-To: <19498990-fb97-b739-cd19-6a6415ba88a2@gmx.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 08:57:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=widmu42C4eTQ9uDM+njZE1s5ARmx7E+1SHH1XznTFOwyg@mail.gmail.com>
Message-ID: <CAHk-=widmu42C4eTQ9uDM+njZE1s5ARmx7E+1SHH1XznTFOwyg@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 8:53 AM Artem S. Tashkinov <aros@gmx.com> wrote:
>
> I'm not sure I can call or do anything because the system is dead and
> I'm looking at the kernel panic message. The console is dead. The root
> file system is not yet mounted. Initrd can't be loaded either. I have no
> COM port/console. I have no debugging abilities whatsoever. I can only
> compile kernels and try running them.

Christoph just wanted you to use the image you booted with - you can
do it while using a working and entirely unrealted kernel.

But I think Christoph's second email was right on the money: the
platform device code used to (accidentally) always use that special
kmalloc()'ed memory, and the "always use kfree() to release" then
happened to work.

But with the change, platform devices use that allocations inside the
platform device itself, and the kfree() now does bad things and
corrupts the kmalloc lists.

So that finally makes sense of why that commit would cause odd
problems for you. I'm actually surprised it didn't cause problems for
others, but it's an error path, and presumably it normally never
triggers.

                Linus

              Linus
