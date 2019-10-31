Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E261DEB7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 20:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfJaTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 15:15:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46982 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfJaTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:15:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id c2so6150284oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNh+j6pA1KmV8YywH2nQex9CnNTdcwO1xxMow6k+Zbw=;
        b=m1JydU/odIa+Q+auu5QpdeF+yYeRW+6Fj2x5Qo2bHfYNiNzfKXj9+U/G52wZxzL0b+
         pDPOXJ2aq7HAFw3fr0tH7nkyETk9Bl1gW56AxYqb4hH2c963w2db+2RohQggmYOH7hqm
         hRSehp9Hu2ixU9iISOjGhkTsDD0uL3HOUIVMIVl3tfgEpQv76InKJIdxMHVk4TAySGXV
         jlkmIxFI2XoyLdEzdz25Yhrbj+qum0vD3XqU2bVIplEr2i0xmzjy4N+ye/SdyGvJ5Qxm
         o1M/nwZQyg2mRwsWbHtTs40wbgzf3cbFiQci1dY5GXsfHh9kXA2UB+HkJkflCJJcKq0l
         HJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNh+j6pA1KmV8YywH2nQex9CnNTdcwO1xxMow6k+Zbw=;
        b=ZpoS4HyoG9l4BGRyuRQ8UJgS9dtIFPw7Fo9jMmB9tw549CuphR1gX3gkJmPuS1CP79
         ZzT4QmtJX+iwH+9Z+JCG0mVg6VXuF4OAsM+svXXWOzbNkzVkOUs4vO1Vjh2EMnKRpxT6
         Y0p9uohG8chyESFDRx+4y1uVWKsq/wsrfwJ1UAwfm9U4KoEYXAUJsD74tHTEGkWHCs3j
         7dfbh+1NolosvP5PLodT8P2xBA/By3m5b6Gc/5dSwZuqNAa9PRAwSz5dANzOk432DpNf
         g7jiNRE5FvPNf8QoLSfjPKHnzWUrCQxUE5HDooNPsfClRq3nk2TmpIoIpYzjV7OJp5mS
         j4/Q==
X-Gm-Message-State: APjAAAVs9Zm/DpYXZOpw5PBHIBgcgHRffs5Q0vrJcbn+mW6ssQ0HJmod
        OgR6C42kMaBULQoV9ggToOcrR2tXUDG6PIwi4y1Cog==
X-Google-Smtp-Source: APXvYqz/3RCmY54bYd2Tyj3jL/j3n1V2ZeDMRll4hkTi6GDOn5p7oxA8M3keFDRMqbuQt6q1PC0em3NTyKKS0v+ZXE4=
X-Received: by 2002:aca:180e:: with SMTP id h14mr1907505oih.142.1572549312404;
 Thu, 31 Oct 2019 12:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191019170141.GQ18794@devbig004.ftw2.facebook.com>
 <20191024205027.GF3622521@devbig004.ftw2.facebook.com> <CALvZod6=B-gMJJxhMRt6k5eRwB-3zdgJR5419orTq8-+36wbMQ@mail.gmail.com>
 <11f688a6-0288-0ec4-f925-7b8f16ec011b@gmail.com> <CALvZod6Sw-2Wh0KEBiMgGZ1c+2nFW0ueL_4TM4d=Z0JcbvSXrw@mail.gmail.com>
 <20191031184346.GM3622521@devbig004.ftw2.facebook.com> <CALvZod7Lm5d-84wWubTUOFWo4XU2cgqBpFw84QzFdiokX86COQ@mail.gmail.com>
 <20191031190053.GN3622521@devbig004.ftw2.facebook.com>
In-Reply-To: <20191031190053.GN3622521@devbig004.ftw2.facebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 31 Oct 2019 12:14:58 -0700
Message-ID: <CALvZod5U5yEZPhURYffEtDto6sL8JG+3ZSRtv3uOait8yBn=EQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix sk_page_frag() recursion from memory reclaim
To:     Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 12:00 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Oct 31, 2019 at 11:51:57AM -0700, Shakeel Butt wrote:
> > > Yeah, PF_MEMALLOC is likely the better condition to check here as we
> > > primarily want to know whether %current might be recursing and that
> > > should be indicated reliably with PF_MEMALLOC.  Wanna prep a patch for
> > > it?
> >
> > Sure, I will keep your commit message and authorship (if you are ok with it).
>
> I think the patch already got merged, so it may be easier to do an
> incremental one.

Oh ok, I will send the incremental one once I have this patch in the mm tree.

>
> Thanks.
>
> --
> tejun
