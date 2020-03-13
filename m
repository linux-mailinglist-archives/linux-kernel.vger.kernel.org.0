Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F56183FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 04:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCMD5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 23:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgCMD5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:57:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9B72072F;
        Fri, 13 Mar 2020 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584071862;
        bh=w+ZZsFzaN02z4LjftM7wNgCAMWF+UZWUmlO2OdveGgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=igO6WyhXDpgdYdsk1Lro4MZ9Kz09lJRzqTA9EBGjn+aZktwUnpRiZ9PNyUYo98e65
         ymzJ0f1po2wfMTl+Xp4p7XbDObPJ8SO5dXdTZEk3Ss9M+2rWfMhSb5TX9LZ+4jOZet
         WA2j+tJuJdOcvRRUh/seQTOBB1Smmxy5aLYSDRMg=
Date:   Thu, 12 Mar 2020 20:57:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for
 lockdep_assert_held()
Message-Id: <20200312205741.e97a201037103bbf51e1df40@linux-foundation.org>
In-Reply-To: <CAFqt6zZ4ceum_SHmQgub8EKJxNQ26_-UfzvK-kcejqH67QHHtA@mail.gmail.com>
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
        <20200312195850.29693d4e55ec27ae11443c0f@linux-foundation.org>
        <CAFqt6zZ4ceum_SHmQgub8EKJxNQ26_-UfzvK-kcejqH67QHHtA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 09:17:22 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> On Fri, Mar 13, 2020 at 8:28 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 13 Mar 2020 07:41:00 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > > walk_page_range() already has a check for lockdep_assert_held().
> > > So additional check for lockdep_assert_held() can be removed from
> > > hmm_range_fault().
> > >
> > > ...
> > >
> > > --- a/mm/hmm.c
> > > +++ b/mm/hmm.c
> > > @@ -681,7 +681,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
> > >       struct mm_struct *mm = range->notifier->mm;
> > >       int ret;
> > >
> > > -     lockdep_assert_held(&mm->mmap_sem);
> > >
> > >       do {
> > >               /* If range is no longer valid force retry. */
> >
> > It isn't very obvious that hmm_range_fault() is and will only be called
> > from walk_page_range() (is it?)
> >
> 
> Sorry Andrew, didn't get this part ?
> * hmm_range_fault() is and will only be called
>  from walk_page_range() (is it?) *

The patch assumes that hmm_range_fault() will only ever be called via
walk_page_range().  How do we know this is the case?  And that it
always will be the case?

