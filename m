Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FD575B31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfGYXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:21:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46516 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfGYXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:21:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so25108886ote.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38jxRDTFNsBuvXEWmRhAENl7Dn2UdsUzhcb9070VNP0=;
        b=pOq4jwIH28H2b1iSOQrWo32IdYYxXTbBo3q1WI1pQZh+wScKbCT6GcyOW+Ai5qId/E
         WxRSp38HTlhmMKBUZhyHF0kthb3Hfu2IAtovYxX3MB+9XmSpeRl3KStvol8PJTMEdu98
         hfSx+yBsxsA8MEwwx5UZKvguuEmqulFrDiDgOS9bu0eF0HJwBpIX5ATf10OuETHiSiW0
         UcL1d3XJrzlfQSNNKQdj9XZ5ne/2qHm4vgh5tNIsqfI47F60RJfLOYSn3N8WDyA4V3iR
         ko3LLIDAbctiv1VW95oe08P4AR2xba15afj1ayy+/picFE4mCeH95DA03AoDUFwzchv8
         f83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38jxRDTFNsBuvXEWmRhAENl7Dn2UdsUzhcb9070VNP0=;
        b=d1mK9K14U/h/+F2EHSVbfcg3oVU7rGn2JQz2apK5NFlLFHzM2O6BFgi7xXUqcJEV0N
         X9NMVm4610pwGZdVeE9FVBRlLBtRfdmCf36lCSu4JL3FU53y5TTxikryr2QstECbBC9C
         eJu32BMsk1asVfr0iDgDL7EWQL0lgCz47bB79f6wkeZGXYkjRHkbleNtxitJcfYd0eLO
         Tnjulz2z3F4zJBXDDSehJxUJF8Lmn4pG1ia+DJGnZjGfm2blB0sy3OGBXfit3w6VhIIR
         Tr4IYTWdEzgxcWpFK2NVUkujAwxz0XouSmkxPSA1929/TvMae0sOi+i4AXC4Tbby2tk7
         4fEw==
X-Gm-Message-State: APjAAAWyE8Y5zaqVBX7P92HwvN+QybbXHGVKMdc44k31zhwcLknkS0zJ
        JrVJNLuglMOHwRRr+k/n3FKzTZAAUmYXmQkSB08=
X-Google-Smtp-Source: APXvYqzQt9JrA2rxwFLAC9k6gQgnEsbS5znL3NvqMmP5TLvNTgxwXAFj1N37C1EmlQjCItCvjUiFYydQVj6azSLq8fk=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr25146806otq.173.1564096871998;
 Thu, 25 Jul 2019 16:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184253.21160-1-lpf.vector@gmail.com> <20190725184253.21160-2-lpf.vector@gmail.com>
 <20190725185800.GC30641@bombadil.infradead.org>
In-Reply-To: <20190725185800.GC30641@bombadil.infradead.org>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Fri, 26 Jul 2019 07:21:00 +0800
Message-ID: <CAD7_sbG+nv-PxnMAxsU25BWQz1EMQx3V0CT7W9XTdfY1HvZfFw@mail.gmail.com>
Subject: Re: [PATCH 01/10] mm/page_alloc: use unsigned int for "order" in should_compact_retry()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:58 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 26, 2019 at 02:42:44AM +0800, Pengfei Li wrote:
> >  static inline bool
> > -should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
> > -                  enum compact_result compact_result,
> > -                  enum compact_priority *compact_priority,
> > -                  int *compaction_retries)
> > +should_compact_retry(struct alloc_context *ac, unsigned int order,
> > +     int alloc_flags, enum compact_result compact_result,
> > +     enum compact_priority *compact_priority, int *compaction_retries)
> >  {
> >       int max_retries = MAX_COMPACT_RETRIES;
>
> One tab here is insufficient indentation.  It should be at least two.

Thanks for your comments.

> Some parts of the kernel insist on lining up arguments with the opening
> parenthesis of the function; I don't know if mm really obeys this rule,
> but you're indenting function arguments to the same level as the opening
> variables of the function, which is confusing.

I will use two tabs in the next version.

--
Pengfei
