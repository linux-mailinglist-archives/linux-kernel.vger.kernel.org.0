Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE6C0E22
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfI0Wvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:51:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0Wvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:51:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so3650511otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UestkIPELIjBFfWcMJudydMzKJ+gMFgCuI48K8BqrAY=;
        b=K1PMWaVARwRP8FL++1ErBgWx4Qdus1r4ONn9vNNwu89yrhxqFGuxr4DrOtAfy01N0A
         VNtv1sAmVr7Y1nn75qAdQz5i7/uPflDiVz2bFpvtrJyKqcf8gQeb7HSoYJ9z/I+3hhQ8
         +79su4rMPcLgmKpXa6KALw0ZHLKUqDmNY/5blt3LzapYnEOAwOA789BJrUCupeNuSm5u
         tWa6sQFHOzbjbghiNGMHKObasz/mUgKI98H6sz8k2+dyNaWyxN/lPAIYxtlnLubNwrc/
         JJsR6KcEHhR/XA9NbWHdrW4PNYHkW4DlrQTxNGTW5w48tnH1J8HuDXisU+yvK6QMhkU1
         N2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UestkIPELIjBFfWcMJudydMzKJ+gMFgCuI48K8BqrAY=;
        b=Bij6pMbxxkLmBYlaSujx4xyjwD8W9GdcmUTwM5T3EFOJVfGSw1XkeUYmZpmYVl5w1z
         mCkBGWW4hUvBKdRUjyPD/O9zfMpyOQm0mwEcEh2qyblW/sqHu0PJqiXArK7+5CASurV6
         1QiiW+//FB7uL83lOdhGAJj94Hr9sq3TdI/m8wI+kLNApzjUY7ayKLWZyVfjYsB/q1BI
         zA6mvbSxERfFZzIZZ8K/qWWV3PcUDIXwi71BoKGgSqe1PrOJKCPQs0airOmbaRyXX2Pt
         S+LUZ7WTs9sZxsGMVGWL+KZcaPcOj0B+BEb9SyHpB9muz6NvdcSGzlyN7h5BCypWWAaO
         8Yug==
X-Gm-Message-State: APjAAAXZEWnR6hCYThUMsS9DGjKSo2s9OOLmJNcIr+V3HUBAtPFPzH8g
        Iy09/yZ/jpb6UUz+bdMM5SmI0dV3IPwWTsLlbk3xuQ==
X-Google-Smtp-Source: APXvYqztJgW0BPdmBajhQzrtxxzRSauVev6OBtd6SsBpd7X8EfW0nxAdOJDaed4nJVCUyelbJcfqxSBn0PfalhIMNSc=
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr4925285otq.349.1569624695280;
 Fri, 27 Sep 2019 15:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com> <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
 <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com> <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
 <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com>
 <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com> <CAHS8izM3=ZDNukx5xhWmeJT+78Ekfff9J4s5Vqkqpx-DtH=C-A@mail.gmail.com>
 <794398cc-07a4-d235-a0da-0246f5a09f6e@oracle.com>
In-Reply-To: <794398cc-07a4-d235-a0da-0246f5a09f6e@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 27 Sep 2019 15:51:24 -0700
Message-ID: <CAHS8izMg4=mJd_d-f3ueiq6Q1AfTFBSjLXeNkkuZO0iV0Dk-iA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, David Rientjes <rientjes@google.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 2:59 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/26/19 5:55 PM, Mina Almasry wrote:
> > Provided we keep the existing controller untouched, should the new
> > controller track:
> >
> > 1. only reservations, or
> > 2. both reservations and allocations for which no reservations exist
> > (such as the MAP_NORESERVE case)?
> >
> > I like the 'both' approach. Seems to me a counter like that would work
> > automatically regardless of whether the application is allocating
> > hugetlb memory with NORESERVE or not. NORESERVE allocations cannot cut
> > into reserved hugetlb pages, correct?
>
> Correct.  One other easy way to allocate huge pages without reserves
> (that I know is used today) is via the fallocate system call.
>
> >                                       If so, then applications that
> > allocate with NORESERVE will get sigbused when they hit their limit,
> > and applications that allocate without NORESERVE may get an error at
> > mmap time but will always be within their limits while they access the
> > mmap'd memory, correct?
>
> Correct.  At page allocation time we can easily check to see if a reservation
> exists and not charge.  For any specific page within a hugetlbfs file,
> a charge would happen at mmap time or allocation time.
>
> One exception (that I can think of) to this mmap(RESERVE) will not cause
> a SIGBUS rule is in the case of hole punch.  If someone punches a hole in
> a file, not only do they remove pages associated with the file but the
> reservation information as well.  Therefore, a subsequent fault will be
> the same as an allocation without reservation.
>

I don't think it causes a sigbus. This is the scenario, right:

1. Make cgroup with limit X bytes.
2. Task in cgroup mmaps a file with X bytes, causing the cgroup to get charged
3. A hole of size Y is punched in the file, causing the cgroup to get
uncharged Y bytes.
4. The task faults in memory from the hole, getting charged up to Y
bytes again. But they will be still within their limits.

IIUC userspace only gets sigbus'd if the limit is lowered between
steps 3 and 4, and it's ok if it gets sigbus'd there in my opinion.

> I 'think' the code to remove/truncate a file will work corrctly as it
> is today, but I need to think about this some more.
>
> > mmap'd memory, correct? So the 'both' counter seems like a one size
> > fits all.
> >
> > I think the only sticking point left is whether an added controller
> > can support both cgroup-v2 and cgroup-v1. If I could get confirmation
> > on that I'll provide a patchset.
>
> Sorry, but I can not provide cgroup expertise.
> --
> Mike Kravetz
