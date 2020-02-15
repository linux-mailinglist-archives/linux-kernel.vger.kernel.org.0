Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F8915FEDB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgBOOaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Feb 2020 09:30:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37467 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgBOOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 09:30:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id t7so3219757edr.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ShrD9ez7moVL0/KalK5SkFzM7anSQi4PH6FlFUNAEA=;
        b=d4/+fPTDgctzavwCqmuiCCpsgLpn+jIUknYPDSs61cauQl9+FYGv9YzmKn3Wrroo53
         F7dNMtXDA59M/xigNzrR/dV6BDUZvDXDQc39qjvJxBZ46kmsoJDFYuje49T6dTndd96l
         KXFpiNuELLr9x9rKX7zcpkE0LMbZeRM5uHuGI/CF00ur9fSUyDujltY2n0LnrWtzHNC1
         mK2FXEOJJZ4PL8ruMGoRgi245CpMlQkIUEMdE5bYPfbIsaHnJazTm2tUFWLm8bF1VHbW
         3L7YX2ODo1xoHmZ/ETWFjmEjejsYeJEHQf+AOIL1HRgkBSL2meHKgcbQFsvWY52pItYT
         W8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ShrD9ez7moVL0/KalK5SkFzM7anSQi4PH6FlFUNAEA=;
        b=lJ2hGIBg0Us7W1d4luP0NRpf2RK24Z8pJMfbAtPkXwq2havxbWLT4zTIz8N2DSrCIt
         8FvDvFZ/KzL71KBtPlYtxwWj+N6fNcCweV5KDAeFpC/dYetAEqgmgx/PKA0b4W9z4Mlc
         FRdy0tX48hnkxwu7sOBkQHYZb9DT6b+8Ar/OkIfmgwDo1pGMSDdc6FplQMikmws9fFFb
         nhEAp6fN8y+31gR9ozyLO5OW5UgcrVS600MZzIgzSNQlaLsHLFjC3WU5ZmwtQ97KuM5I
         I4KXr+ooy9wrQOkzTTad7UCACfNGH+w0SD6K5L6lUgq/g+X49qB+ZOkFGrXmmPaYggNM
         JpUg==
X-Gm-Message-State: APjAAAUqQevuuEzOmge81DM02AD2Aq/j9ciZ1J4ZFkG07rOH2MGNcnwg
        haRYCaHXDjRuGB4mKDZ8flo9A9DTUsOe/8MgI7Jhiw==
X-Google-Smtp-Source: APXvYqwxM323KPHil1X5yz/uLQsIal7NBKyJgPA1syNh9U9MbZ4PqkU9BAuUeOiWYJWGtnMTY9sCxcsEMQGtS493ka8=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr6917583edb.146.1581777012854;
 Sat, 15 Feb 2020 06:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20200214225849.108108-1-bgeffon@google.com> <20200214231954.GA29849@redhat.com>
In-Reply-To: <20200214231954.GA29849@redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sat, 15 Feb 2020 09:29:46 -0500
Message-ID: <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,
Thanks for the quick reply. That's great to hear that Peter has been
working on those improvements. I didn't try the entire patchset but I
did confirm that patch 13, not surprisingly, also resolves that issue
on at least on x86:
  https://lkml.org/lkml/2019/9/26/179

Given that seems pretty low risk and it definitely resolves a pretty
big issue for the non-cooperative userfaultfd case, any chance it
could be landed ahead of the rest of the series?

Thanks,
Brian

On Fri, Feb 14, 2020 at 6:20 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello,
>
> this and other enhancements have already implemented by Peter (CC'ed)
> and in the right way, by altering the retry logic in the page fault
> code. This is a requirement for other kind of usages too, notably the
> UFFD_WRITEPROTECT ioctl after which multiple consecutive faults can
> happen and must be handled.
>
> IIRC Kirill asked at last LSF-MM uffd-wp talk if there's any
> particular reason the fault couldn't be retried currently. I had no
> sure answer other than there's apparently no strong reason why
> VM_FAULT_RETRY is only allowed 1 time currently, so there should be no
> issue in lifting that artificial restriction.
>
> I'm running with this patchset applied in my systems since Nov with no
> regression at all. I got sidetracked by various other issues, so
> unfortunately I didn' post a proper reviewed-by on the last submit yet
> (pending), but I did at least test it and it was rock solid so far.
>
> https://lore.kernel.org/lkml/20190926093904.5090-1-peterx@redhat.com/
>
> Can you test and verify it too if it solves your use case?
>
> Also note the complete uffd-WP support submit also from Peter:
>
> https://lore.kernel.org/lkml/20190620022008.19172-1-peterx@redhat.com/
>
> https://github.com/xzpeter/linux/tree/uffd-wp-merged
>
> Thanks,
> Andrea
>
