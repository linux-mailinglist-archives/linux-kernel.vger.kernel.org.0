Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CA1350A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 01:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgAIAvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 19:51:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgAIAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:51:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so980666wmc.3;
        Wed, 08 Jan 2020 16:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KU7xVZBK7eYT1FTG7oyMaPAZ7ecg5Lzxd6RIVfDarI=;
        b=eFEQggrLPWgMsvCupV1cwU/5IXUc5Y5D5KhbMdlorDjjrsXqvYj1pBsnVz2gQR9euh
         pmYELas13niKw8j4m7M5t1V0ZICkAf9iRQ24xAievWO1AmleB6pyNxhgkKoS3UNcaKTd
         MN4Vpd5ezU1IK5Ko+qgirmLDqM57ASyvj1iQflUO0uKQJz9l+pbIdDPB1ngwO1X1bhr7
         WeZjr2/w0u6MXxnODw9Mjm361XVKa+USEEZR+8+I7xpzZJBhutrr0J+gIrjQnSG5RHKX
         b4hcYJa2doMB4gjweIspjFkgzxk6wrBssPJXzn3v1G6YWqtORS+LXgkptk0b/BOBS4tR
         LF2A==
X-Gm-Message-State: APjAAAXKW0eSTNvhHMiahyIu4OyBIakLUkCEofOm8Kok7rUjItNv0Unw
        3NgtNwDtreOvP4xXpboJRdqTaFTxbmCA2bfwgiw=
X-Google-Smtp-Source: APXvYqxcNCt/1CA507Wc2aF24GXJSiH7YjJBPv93DPSmKNsAD7zdzQKkzH1tsCbQZcByXJs3+9gXN7jTmndvIGVQ7pY=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr1444802wmc.9.1578531108956;
 Wed, 08 Jan 2020 16:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava>
In-Reply-To: <20200108215235.GA12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 09:51:38 +0900
Message-ID: <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jan 9, 2020 at 6:52 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> > Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> > Hist entries have cgroup id can compare it directly and later it can
> > be used to find a group name using this tree.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/cgroup.h  | 15 +++++---
> >  tools/perf/util/machine.c |  7 ++++
> >  tools/perf/util/session.c |  4 +++
> >  4 files changed, 94 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > index 4881d4af3381..4e8ef1db0c94 100644
> > --- a/tools/perf/util/cgroup.c
> > +++ b/tools/perf/util/cgroup.c
> > @@ -13,6 +13,8 @@
> >
> >  int nr_cgroups;
> >
> > +static struct rb_root cgroup_tree = RB_ROOT;
>
> I think we shoud carry that in 'struct perf_env'

OK, will move.

Thanks
Namhyung
