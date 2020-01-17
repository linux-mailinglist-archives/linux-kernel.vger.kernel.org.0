Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B004A1413F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 23:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAQWP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 17:15:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44485 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgAQWP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:15:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so10391243plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YARhjqHfu3XnvFV7m022gWlMRwz6JsfilVyY5Ay7UrY=;
        b=NkZOrXzLv98pN3E39cEyacMcPnPLQFK9DJqD3IiZVnfNxTXyf6WyyJxn/TLdSoFKSb
         liWaUbRi6oZHlC+4BpeNt7EXfzMkYZcjfMlqcxqPv7IKK9gwEEW1JTBpopjQXt7QXFgm
         YU9H9S2KD/uMsUPfA4T2BGx3CkGXZ8MOpAzIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YARhjqHfu3XnvFV7m022gWlMRwz6JsfilVyY5Ay7UrY=;
        b=ghpjx05wHHjdfFzdenxPcX46ovwVuwDvlEmjQUJMaR7BPfmSnxbjyn6NnuFCDhLnrf
         PZs6wnge0vYXFhrKbgMCTqjzN+kE1F6gpLUHHpr51ThCwcB1trcVFNqp9aPlB9wfWAi7
         bI3B0GXnFBlW6BwuUphT6BKa3QfHqIyLgjVBji3QZ+l8eSH3VVJydAEY0JVlXd6jV9IV
         J3bgluwVlIfWJLJbfyoMkDNX+7VNy7d0ouRJEnuME5GQJzCdcffUycylsBCjb03oqwfC
         5GLoxWjBFfeBAXmi5cgQkMfsY3NGc0wYTb3uNRFWAmBWiH+nH0hXc/g6jDik0MahCdOD
         9YZQ==
X-Gm-Message-State: APjAAAUCesdc4nGYBObMPPI1xLXLaeQe2mAHsDGD4TVGQETPSRqBHnYz
        z2eioeEz3z5w+GzD7UOaxabA9Q==
X-Google-Smtp-Source: APXvYqxevNzacDfhqVUFU9WP0mcyHbwMOPtg3KBADlZVplAkcfA7QKZqfCvnYsEpqCMea8UV5hwyjA==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr8410990pjb.7.1579299356657;
        Fri, 17 Jan 2020 14:15:56 -0800 (PST)
Received: from chromium.org ([165.231.253.166])
        by smtp.gmail.com with ESMTPSA id dw10sm8424303pjb.11.2020.01.17.14.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 14:15:55 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 17 Jan 2020 23:16:03 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 08/10] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
Message-ID: <20200117221603.GA25978@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-9-kpsingh@chromium.org>
 <CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com>
 <20200116124955.GD240584@google.com>
 <CAEf4BzYa+m0OCZXqnNsab+q3+HLboL45eRdBrGdZD+6Z4CRSiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYa+m0OCZXqnNsab+q3+HLboL45eRdBrGdZD+6Z4CRSiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Jan 11:10, Andrii Nakryiko wrote:
> On Thu, Jan 16, 2020 at 4:49 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > Thanks for the review Andrii!
> >
> > I will incorporate the fixes in the next revision.
> >
> > On 15-Jan 13:19, Andrii Nakryiko wrote:
> > > On Wed, Jan 15, 2020 at 9:13 AM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > * Add functionality in libbpf to attach eBPF program to LSM hooks
> > > > * Lookup the index of the LSM hook in security_hook_heads and pass it in
> > > >   attr->lsm_hook_index
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > ---
> > > >  tools/lib/bpf/bpf.c      |   6 +-
> > > >  tools/lib/bpf/bpf.h      |   1 +
> > > >  tools/lib/bpf/libbpf.c   | 143 ++++++++++++++++++++++++++++++++++-----
> > > >  tools/lib/bpf/libbpf.h   |   4 ++
> > > >  tools/lib/bpf/libbpf.map |   3 +
> > > >  5 files changed, 138 insertions(+), 19 deletions(-)
> > > >
> 
> [...]
> 
> > >
> > > > +{
> > > > +       struct btf *btf = bpf_find_kernel_btf();
> > >
> > > ok, it's probably time to do this right. Let's ensure we load kernel
> > > BTF just once, keep it inside bpf_object while we need it and then
> > > release it after successful load. We are at the point where all the
> > > new types of program is loading/releasing kernel BTF for every section
> > > and it starts to feel very wasteful.
> >
> > Sure, will give it a shot in v3.
> 
> thanks!
> 
> [...]
> 
> > >
> > > > +               if (!strcmp(btf__name_by_offset(btf, m->name_off), name))
> > > > +                       return j + 1;
> > >
> > > I looked briefly through kernel-side patch introducing lsm_hook_index,
> > > but it didn't seem to explain why this index needs to be (unnaturally)
> > > 1-based. So asking here first as I'm looking through libbpf changes?
> >
> > The lsm_hook_idx is one-based as it makes it easy to validate the
> > input. If we make it zero-based it's hard to check if the user
> > intended to attach to the LSM hook at index 0 or did not set it.
> 
> Think about providing FDs. 0 is a valid, though rarely
> intended/correct value. Yet we don't make all FD arguments
> artificially 1-based, right? This extra +1/-1 translation just makes
> for more confusing interface, IMO. If user "accidentally" guessed type
> signature of very first hook, well, so be it... If not, BPF verifier
> will politely refuse. Seems like enough protection.

Thanks! I see your point and will update to using the
more-conventional 0-based indexing for the next revision.

- KP

> 
> >
> > We are then up to the verifier to reject the loaded program which
> > may or may not match the signature of the hook at lsm_hook_idx = 0.
> >
> > I will clarify this in the commit log as well.
> >
> 
> [...]
