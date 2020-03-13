Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3B7183FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMDrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 23:47:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35977 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCMDrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:47:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id s1so6686048lfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZDSoQx95Ubh+HBfrSp1XYVgSVN4vHwFBPkS+obSa4E=;
        b=Kdmhl+ACaCBaiNEXRGmux/wGkICP1PetJy1ChTyCtljceocmEmO3tf89WV8uWoKH2d
         pWZI1u+MjlrMgxgmeDdyXFqfRCQ4OxjTofDEyXIDK7hupYqQDEk4cUhUnAnNN2LAQpuh
         +gczt4gPC3h6+WrKt/nA8L2HLmlgwaLi+QboL7uc5ERrAk4XVkTxXERJsq6EICHd4f2J
         TtbH59IfV6VvTqF07HP0ZwpGl69Tuo7DIyFRIQJgVAwv6ortFs6WFiQmePAU7CJm/da7
         RndmDsBVODLneg5Z4L24u0pp+/JV+sJdOldEjvio5gsJKPtabUpyiRKx+utbevsTxbkW
         EmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZDSoQx95Ubh+HBfrSp1XYVgSVN4vHwFBPkS+obSa4E=;
        b=HpghAOsZo8g/qI/nf2hG9PNrT6U9O/1sj4MHnPvsyNbMxco2qHK4IRVgTVlEuXFaBk
         X67/ZDhgcgt+DSFOnmOnta9D662u85TklfMDH7Sbi3i3fAWA1QVfEtc5HF3/Xo/Yks3C
         GiAMdgM57OBdFqrMUlUjw/VBXkLmQRe/Xnv3Ppm2xj2FpKU9fbxJKLC5HyPc37xf7gMx
         30v95Kg+nz02iAy5SR2GG025Seul4iSVgvljbWFFVoFNX8g7+DTQCQYzfG823OzH9YSE
         Z7WONY6NtRjl6GwFwjkHt8Yi7HDr/Dlrjy1DX0XMswmzVHq+KGfZC1YrkB0/KHFEsnyq
         iK0Q==
X-Gm-Message-State: ANhLgQ34T1He+LsXpBPeYbqOL3E7CANUR4+1AQPXylHl4ldlp4VzA4xZ
        biinnFQLktzbCZ+fKz8KtHhSYSkND5eMlj+qsKY=
X-Google-Smtp-Source: ADFU+vtaeosP6hJkETgIFM8xGMedLYGzWkquPOyhzA82L8Z2QNLxYdCinWQ9cUB0TEQ/Lqk5kHIjpEpjCNGpUgBgWfI=
X-Received: by 2002:ac2:522e:: with SMTP id i14mr3965188lfl.133.1584071261314;
 Thu, 12 Mar 2020 20:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com> <20200312195850.29693d4e55ec27ae11443c0f@linux-foundation.org>
In-Reply-To: <20200312195850.29693d4e55ec27ae11443c0f@linux-foundation.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 13 Mar 2020 09:17:22 +0530
Message-ID: <CAFqt6zZ4ceum_SHmQgub8EKJxNQ26_-UfzvK-kcejqH67QHHtA@mail.gmail.com>
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for lockdep_assert_held()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 8:28 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Mar 2020 07:41:00 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > walk_page_range() already has a check for lockdep_assert_held().
> > So additional check for lockdep_assert_held() can be removed from
> > hmm_range_fault().
> >
> > ...
> >
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -681,7 +681,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
> >       struct mm_struct *mm = range->notifier->mm;
> >       int ret;
> >
> > -     lockdep_assert_held(&mm->mmap_sem);
> >
> >       do {
> >               /* If range is no longer valid force retry. */
>
> It isn't very obvious that hmm_range_fault() is and will only be called
> from walk_page_range() (is it?)
>

Sorry Andrew, didn't get this part ?
* hmm_range_fault() is and will only be called
 from walk_page_range() (is it?) *
