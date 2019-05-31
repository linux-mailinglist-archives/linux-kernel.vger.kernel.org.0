Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5730CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEaKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 06:41:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44313 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:41:09 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so394395iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7K/6YQSxV880DkgJ09eg6h5iBlyiK20sdzcSTZG0aM=;
        b=XGkP53SshfAPmjGlZUh6RXC8I0N9LNtD1Gjnv7hElsZCRY70TqFTw5zLekprBErZVZ
         kWW0cxpj4Vk8TtbhgL2/m+oJDO93uQmRsgY/3PUAHt72ui+eu+8iMoi0sbO9zp5mjhfA
         1GujwFE4vKK3kFHn8SsgGZLlVsT8v4F/yInGr08a92cncLzgqLyq6eBfsYPsWvYCZ0Ih
         Zwia03Ei1sgEs8sRg0TKkx6I68y9yoOrNuuq1r2Ve5+NvzhE/6WwPZedH24GZrPPwrEj
         U+tPejHGcQjYBJptZNJZri0w0gnND+Gb+fk6g/Kx+1B2BKjDwxaCQbbHjB796JljRktB
         FTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7K/6YQSxV880DkgJ09eg6h5iBlyiK20sdzcSTZG0aM=;
        b=Ix34o3BTgKw3vFAOUkZLBOpuum6VtuZO7T4tw34ojv7L33xbDbOH0P4W+5v84+BVWb
         sbYLL+kgklpQJqYptax2T8c4ZCGnrGjl6csamOdbgSPeNBHA+WE8h4qsFTdcYzJBwbtm
         5qrcG3bllTladZFgrIOxKU6qAYa09bKh43VpFYwJ0Ih5UTlQW/149YnbVLgccjC3LSms
         8ARDuGPPcST0gcPieicchRfOltws8GClNmo9gKHiSTaxPYsckwGpIu+3x9+gaDDULPTS
         eJGuoTXw4KH1cOcRbOm0q1Ssc/5aQ/noGieexk3lnyKIrGeUGm/Js8iwwqcYqR4ew0K9
         YMZQ==
X-Gm-Message-State: APjAAAXPNmh/SMKABf2XoDE7/KicxTp5QE8Ng6Ov812COiL/R6w0vYR9
        MoshzeIQ1xr9tm6DAu7MtZqNhzz6hIbT4e90Lw==
X-Google-Smtp-Source: APXvYqyXE1xefJ2rEEvK1/15mQpuixTmPfm9Ib8UnCkKZn3rkf3o8/n4IOBDBtlTAiwv3kEYQXoYI4jiTop8Ywfoefc=
X-Received: by 2002:a6b:e005:: with SMTP id z5mr4968657iog.161.1559299269094;
 Fri, 31 May 2019 03:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
 <20190530214726.GA14000@iweiny-DESK2.sc.intel.com> <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
 <20190530235307.GA28605@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190530235307.GA28605@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 31 May 2019 18:40:57 +0800
Message-ID: <CAFgQCTtFmK1=7a4ewb+Dy3JZk=rxthi6ZAJBkkMaTgW2DxtubA@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 7:52 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Thu, May 30, 2019 at 04:21:19PM -0700, John Hubbard wrote:
> > On 5/30/19 2:47 PM, Ira Weiny wrote:
> > > On Thu, May 30, 2019 at 06:54:04AM +0800, Pingfan Liu wrote:
> > [...]
> > >> +                          for (j = i; j < nr; j++)
> > >> +                                  put_page(pages[j]);
> > >
> > > Should be put_user_page() now.  For now that just calls put_page() but it is
> > > slated to change soon.
> > >
> > > I also wonder if this would be more efficient as a check as we are walking the
> > > page tables and bail early.
> > >
> > > Perhaps the code complexity is not worth it?
> >
> > Good point, it might be worth it. Because now we've got two loops that
> > we run, after the interrupts-off page walk, and it's starting to look like
> > a potential performance concern.
>
> FWIW I don't see this being a huge issue at the moment.  Perhaps those more
> familiar with CMA can weigh in here.  How was this issue found?  If it was
> found by running some test perhaps that indicates a performance preference?
>
I found the bug by reading code. And I do not see any performance
concern. Bailing out early contritute little to performance, as we
fall on the slow path immediately.

Regards,
  Pingfan
[....]
