Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5230FA2D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 05:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfH3DrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 23:47:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52798 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH3DrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:47:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so5751489wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 20:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBmq40OFeClslDTSVLeJzWGim75xvI1MiiotpLmLOOc=;
        b=Ze1/pobxpbOij6xoRo8sAfz/5+bxyPq8xOcuwYSnjP15wufh1QreoZdMZE4U8yNxPA
         651MVdqkm+ucKFG/Zh4H/vfH7NFhuQi38woAftoWSQDxQ/y4HTmMoruxqQ5arArBXwHz
         uNQf1vNaMSUMWHyoS8cNb+kN/mHaxeJwK0t79TEhqfy0iZ34ll+vbBfZ8zwT4ShqUn+2
         0xWWxrxPlj1/ed6c4FXvf0luBTKWyFkIqIWfqaL9ETeXkzohRJUVpYh91gSQ1SGCgB1f
         pub1axRla4W18Z3kAPcxRUnt8x1nSYQIZPLVEi85JWsxatznCIZfHeSwQvTPhm0F9l9u
         6b6A==
X-Gm-Message-State: APjAAAU1V+h/6XV+7kGmshuX+OqjvntzSOvfW2KOzEgn4C3JFSdnKgSV
        73KFopCumNn0LZNS7mwcJuV+WHf+0sepbiS5z9E=
X-Google-Smtp-Source: APXvYqxkCqUsQpMbxBn3qTkjDD/YYRQNAPSo+siYbobX3CSvnj7FwLZHvvWL1iLF/BeQZOD5sRW1kbnZLJJUvWTuRnY=
X-Received: by 2002:a1c:e008:: with SMTP id x8mr3167431wmg.85.1567136823029;
 Thu, 29 Aug 2019 20:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-2-namhyung@kernel.org>
 <20190828094459.GG2369@hirez.programming.kicks-ass.net>
In-Reply-To: <20190828094459.GG2369@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Aug 2019 12:46:51 +0900
Message-ID: <CAM9d7cja=jh9ASa4ffCca34AHcB-aRkyWj9hAQbEoQf8qOcg9w@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Aug 28, 2019 at 6:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> > To support cgroup tracking, add CGROUP event to save a link between
> > cgroup path and inode number.  The attr.cgroup bit was also added to
> > enable cgroup tracking from userspace.
> >
> > This event will be generated when a new cgroup becomes active.
> > Userspace might need to synthesize those events for existing cgroups.
> >
> > As aux_output change is also going on, I just added the bit here as
> > well to remove possible conflicts later.
>
> Why do we want this?

I saw below [1] and thought you have the patch introduced aux_output
and it's gonna to be merged soon.
Also the tooling patches are already in the acme/perf/core
so I just wanted to avoid conflicts.

Anyway, I'm ok with changing it.  Will remove in v2.

Thanks
Namhyung

[1] https://lkml.org/lkml/2019/8/6/586
