Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BE159DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 01:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBLA3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 19:29:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgBLA3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:29:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so278092lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1zwim5bENoBH/YJdV0JdFYomer3zhgdaL9VRFgFbmk=;
        b=a0mAJB8SfJ9gaZZHweS2NdfMYUd1WCE17SI7XP87C6+Ff2gIDBgABMTm1Kx1Nsg1HY
         0ruUjl8AovwmwDeG0JrMTljpLYvq2f2NsCGILLfMorIKOj/gOtfvalctlgOMWWRjQ4hp
         XXLCJke+6ceL5jkjOhRCVzu1uXDQxR66FqD6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1zwim5bENoBH/YJdV0JdFYomer3zhgdaL9VRFgFbmk=;
        b=PJe6tcu6ZfGLG8AeDiHDMQAP8qxUjHmOwOWaY1P4F0QeihNv8Ax/ZJUKogD4w3YNrT
         HgUXLkZhKEoxVrj95iFQBkGm0M7oGRjw0Beoq2LRVcsualOtyerROyu1pRUkkPyCLORR
         BZkqCs5P9fO6pyqWp6O9wDZBs9/BfpmDY8PAwuPFdn554ROLGB2gy8YgntG8ZFkA2f7Y
         Gu9++VAxYZFoanpR9sqeLAgKeTzSOzi9QJGNOE0kfXLzb6J2r3EoybkoTJrT5bfTgWBS
         YSYazJ6+BzHlplGYQhF14hXuOK8BheeImyIzijm/6lxQfuv8zuakLIVVy+Oc+fkUHn3T
         Y9Tg==
X-Gm-Message-State: APjAAAVuFu35F24SapPPZ2w7N+fcTl22nf0miThf6TKgqi13Q/li1CbL
        EcnEg5HpY98W2EP2HdqpnVJVyRnfnm8=
X-Google-Smtp-Source: APXvYqxGlX8Cfesxlkcv4Fc4xNmr7SHgdTao5sh+KjKmEDG8sefHr4kDho6A2h/nYvpjMdKgqGxasw==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr5036715lfn.95.1581467339364;
        Tue, 11 Feb 2020 16:28:59 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w1sm2529009lfe.96.2020.02.11.16.28.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:28:57 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id y6so271886lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:28:57 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr6018875ljk.201.1581467335909;
 Tue, 11 Feb 2020 16:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
In-Reply-To: <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Feb 2020 16:28:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Message-ID: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Testing this will be a challenge, but the issue was real - a 7GB
> highmem machine isn't crazy and I expect the inode has become larger
> since those days.

Hmm. I would say that in the intening years a 7GB highmem machine has
indeed become crazy.

It used to be something we kind of supported.

But we really should consider HIGHMEM to be something that is on the
deprecation list. In this day and age, there is no excuse for running
a 32-bit kernel with lots of physical memory.

And if you really want to do that, and have some legacy hardware with
a legacy use case, maybe you should be using a legacy kernel.

I'd personally be perfectly happy to start removing HIGHMEM support again.

                   Linus
