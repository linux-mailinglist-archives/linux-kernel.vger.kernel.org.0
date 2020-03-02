Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AD1751D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 03:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCBCil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 21:38:41 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37372 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgCBCij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:38:39 -0500
Received: by mail-il1-f195.google.com with SMTP id a6so7997995ilc.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 18:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMBtZKtRWZnuY7I2gHV8O0aP4O5vGYjUt387++HUGg0=;
        b=GoJ/hSIhtzmyK1XJGrqO7MByCX/BqrUWQv4z+ueuUJNbrzqFtG8bW4JIDPsvIncAeW
         3EjWVRw8A9l0UnxL4ahWx2hqUN45nEZCU0OrNvHP2Rmr4yAczOyEco3SmvhCzIRTEWzg
         2nWiizNIf/13Mdewd0VigJmlCLnX6T+A19iPEjrGeXSjp7R2r5tku7Dy/mIQmD3Q0e4n
         HaNXKT9TAXhpb4zovKnrtzB7MwPxHau+Ie8umdopdU79mjJCMTI+uorDlbTVm/jKs0Ys
         bcuX6zU2BaabHoKiplMLkDK99a906rlv7NDo0MsARJNMPSPQKdDvsr+/KYWm0yH4Avn/
         dzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMBtZKtRWZnuY7I2gHV8O0aP4O5vGYjUt387++HUGg0=;
        b=YNFxdzXHMlOahUFS4twPy8MUBZ1knC5F3HfXtW5JPIZWUPdiD1ZK17pdotZ5tOSYcd
         SsWd8JhHGiByNNz5/tdoTtQ+CcfZMXziWCFpRpbwIBouUpF2lRTNnNrvxOC871WULqT3
         Hic4Cx/bL1hDH8MiM02KcV/pdbO/b2CbEBWCsrnZWdBNVeMRRX7udG25BE16pj25PCRV
         aUKosbk+dNwprE/w5N9YcNYxVl8Q8vJY/Hyixv4Kf7XVcb9Q5TMho0nzkurFXb9hHeZ4
         SszaaI3hNil8sdp6PwI7YdUQW8gpRbqC8Y2OPE3TbG3CAW0TU4ucGVXZlu2Q8ioWDp8u
         6OxQ==
X-Gm-Message-State: APjAAAU7proOACj19+/bebz0RHmhhwTwLZbktoJAl+fiBD6j4nfEsv6f
        IzQFu8wdkkgCCqOF8UnUFC59xfgJtVJCNNUXcQ==
X-Google-Smtp-Source: APXvYqwDyaP6Qn0pUWmDTtkqgW8emavOCeHLkeDP9XbwTbCJicqdnj0l+jIsvnqly0DAdgsCYBkmoZe1/psRu3keFaE=
X-Received: by 2002:a92:194c:: with SMTP id e12mr13324399ilm.12.1583116718718;
 Sun, 01 Mar 2020 18:38:38 -0800 (PST)
MIME-Version: 1.0
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
 <1582889550-9101-4-git-send-email-kernelfans@gmail.com> <CAKgT0Uc5cqJ5yhdi7HkyFTuiYQiPt9rGFPd42qAGSa7+d9ZQgQ@mail.gmail.com>
In-Reply-To: <CAKgT0Uc5cqJ5yhdi7HkyFTuiYQiPt9rGFPd42qAGSa7+d9ZQgQ@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 2 Mar 2020 10:38:27 +0800
Message-ID: <CAFgQCTtQL7Dub8csVn-EDs8EBtsSSjsRobJLnXrrosTDnZhj4w@mail.gmail.com>
Subject: Re: [PATCHv5 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in
 gup fast path
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:43 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 3:35 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Introduce a GUP_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
> > path.
>
> The title of the patch has a typo in it. There is only one 'e' in "benchmark".
Yes, it should be GUP_FAST_LONGTERM_BENCHMARK
>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > To: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/gup_benchmark.c                         | 7 +++++++
> >  tools/testing/selftests/vm/gup_benchmark.c | 6 +++++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> > index 8dba38e..bf61e7a 100644
> > --- a/mm/gup_benchmark.c
> > +++ b/mm/gup_benchmark.c
> > @@ -8,6 +8,7 @@
> >  #define GUP_FAST_BENCHMARK     _IOWR('g', 1, struct gup_benchmark)
> >  #define GUP_LONGTERM_BENCHMARK _IOWR('g', 2, struct gup_benchmark)
> >  #define GUP_BENCHMARK          _IOWR('g', 3, struct gup_benchmark)
> > +#define GUP_FAST_LONGTERM_BENCHMARK    _IOWR('g', 4, struct gup_benchmark)
> >
> >  struct gup_benchmark {
> >         __u64 get_delta_usec;
> > @@ -57,6 +58,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
> >                         nr = get_user_pages_fast(addr, nr, gup->flags,
> >                                                  pages + i);
> >                         break;
> > +               case GUP_FAST_LONGTERM_BENCHMARK:
> > +                       nr = get_user_pages_fast(addr, nr,
> > +                                       (gup->flags & 1) | FOLL_LONGTERM,
> > +                                        pages + i);
> > +                       break;
>
> If I am not mistaken the mask of gup->flags is redundant. It is
> already masked by FOLL_WRITE several lines before this switch
> statement.
Yes, you are right. Thanks for your kind review.

Regards,
Pingfan
