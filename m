Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C528357559
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 02:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF0AUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 20:20:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44790 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfF0AUU (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:20:20 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so744944iob.11
        for <Linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0fxw6N73maQ02G9biYfnSH2j9AnglVamO/dzWb0ntQ=;
        b=P3G+XDC9VgTBzI6prnBC/uoupIscWeaFkykn0frPLnMoX27cY2wFBV4KE7fIl3B+5J
         0Fvi+As/bWtZj6GcKHwonh2Z/Gor1tPnxU6kd00O5xdUATX/7HvAI+TVp/lbRJUmGhBk
         vKmKNwNm9oLF9QFkwzhC/uTg8G6BG5naJs+h6NSi9EQCdelKoxb4dkW1luyMdMDL/eeU
         TqGCAZVJw8jRExmpDzTalZhG9hyKFvPVn9+MPtVAphy7aWsuBc50dlugLXzefc5TrD8C
         8h9it1TEvX7GNchKEq+QDfj/IT9DTWPDC7HvV36wmOD4SOTQRBRuW1Wneijl89RM0HzN
         n6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0fxw6N73maQ02G9biYfnSH2j9AnglVamO/dzWb0ntQ=;
        b=odAbU4s40OFuNj0fI27q96PCWc833Sus6rkvEdraPin7swXltZ6ck1Q0bqV7KrC1/q
         vycVvXWdEu1N2XUYGAAOBuuD/3afbOykswXhy9Y8P8QWlTPvBtjYAOboWkyUXluJ6pBM
         Be5k82EFkbb+9va1kfdSKN9OHquD3yVS3XIdqu+2lpRXMqgFeu+TOVAQWXDIY5/GZweW
         7KZcdZUD1oqjphRtcpIOzJM3XN5anFCLkRkxY/aJmNII8G3y25xdPEXrbCNoIR+6OTA9
         +DtJ/7DgOL/5I1Q3kKkfiMJXHgwg4IUczzor8R1EXxj0rnELQbm5Bdu2DSUtNWEBZhVf
         KMMA==
X-Gm-Message-State: APjAAAVPtsjOogBPgvBpfzDWJ2tXDlW7t5+V+McDaOYIXLri/B0sYqvm
        05xjrK2yFpaWKoIMxMdjkwDsQMlxL7ItoW4Z6w==
X-Google-Smtp-Source: APXvYqzZUD3KYaX5KnFZWHBBrVKwteLRfw/EGBDdzcHQz8rb2VLtjI8X4yhzXDL2yWbtb851BY9X/DPvVjlSOBVxMIg=
X-Received: by 2002:a6b:6f06:: with SMTP id k6mr1220728ioc.32.1561594819720;
 Wed, 26 Jun 2019 17:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <1561554600-5274-1-git-send-email-kernelfans@gmail.com> <20190626161537.ae9fcca4f727c12b2a44b471@linux-foundation.org>
In-Reply-To: <20190626161537.ae9fcca4f727c12b2a44b471@linux-foundation.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 27 Jun 2019 08:20:07 +0800
Message-ID: <CAFgQCTubW0GsYmJUfitd=B_a0JhiyFXHXx9sGzq-AWDP2hg+nA@mail.gmail.com>
Subject: Re: [PATCHv4] mm/gup: speed up check_and_migrate_cma_pages() on huge page
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <Linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 7:15 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 26 Jun 2019 21:10:00 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:
>
> > Both hugetlb and thp locate on the same migration type of pageblock, since
> > they are allocated from a free_list[]. Based on this fact, it is enough to
> > check on a single subpage to decide the migration type of the whole huge
> > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > similar on other archs.
> >
> > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > hugetlb_lock many times, and meanless remove/add to the local link list
> > cma_page_list.
> >
> > ...
> >
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >       LIST_HEAD(cma_page_list);
> >
> >  check_again:
> > -     for (i = 0; i < nr_pages; i++) {
> > +     for (i = 0; i < nr_pages;) {
> > +
> > +             struct page *head = compound_head(pages[i]);
> > +             long step = 1;
> > +
> > +             if (PageCompound(head))
>
> I suspect this would work correctly if the PageCompound test was simply
> removed.  Not that I'm really suggesting that it be removed - dunno.
Yes, you are right. compound_order() can safely run on normal page,
which means we can drop the check PageCompound().

>
> > +                     step = (1 << compound_order(head)) - (pages[i] - head);
>
> I don't understand this statement.  Why does the position of this page
> in the pages[] array affect anything?  There's an assumption about the
> contents of the skipped pages, I assume.
Because gup may start from a tail page.
>
> Could we please get a comment in here whcih fully explains the logic
> and any assumptions?
Sure, I will.

Thanks,
  Pingfan
>
