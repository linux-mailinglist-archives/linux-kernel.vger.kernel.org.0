Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E429A180AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 21:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfEHTwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 15:52:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33942 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfEHTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 15:51:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so8253894eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 12:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqOZEzLE6WwTiA3Dz7Gqq2Tv3AW7Mi8HGq1qcRsSpRU=;
        b=ic9kgFYTuNAejn8z3ijaImES3euvwLMxKuHnbDhW+cLWy978kwY8Rdw6C0rdjfVyKZ
         Mtl9aIxqnvIreQ/L4CR6WbVKmYnWC/mFzh+978+snbbqRo6R5OKjYr1URPdpnMouaTbj
         YdKH3lwTRHrrJ3UIw9L3oYm8ODhlpEJuthd4noD1lOXm8dIljlTzzMW49Q9W+qeHhRWR
         Yu0tvujMwhPZCWtarlVUx/kTIyXmySwkuWuswyvCPuOAgIaXFF108Hr0UMYQMehe/cxA
         XMxqhO7Ch6Qx6uqYw1VfYT0lOwcr2RyR0WH9zgCNx38rQXsYbE+gzdxuwp1AJjkndNR+
         ADsQ==
X-Gm-Message-State: APjAAAXnOjazddML8l/30dQ6PGXHJy5ohUL2KJRf+rBe6wQS97AqFs/a
        gXZQc4DW/pq3q+fbAPhMs4TKtHCYqGUuvRO2sS989hLT
X-Google-Smtp-Source: APXvYqy5e8vTqJHsWt6cyK83x4oPyJXZcetqXs7QvD0GksqAD0Zo3RLFLjlKFEZy5RfYHx/mEWEjtMjGdyipkjXxLMM=
X-Received: by 2002:a50:9203:: with SMTP id i3mr23971200eda.172.1557345118108;
 Wed, 08 May 2019 12:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <1d7c4d47cfca91c11b0e078d86a8f7f7da6d862a.1557177585.git.len.brown@intel.com> <20190507122219.GN2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190507122219.GN2623@hirez.programming.kicks-ass.net>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 8 May 2019 15:51:46 -0400
Message-ID: <CAJvTdKm_hsHT7nSi3YwNbZ6gYbHGksQKo_WBaFWSFiN0xJ7peA@mail.gmail.com>
Subject: Re: [PATCH 16/22] perf/x86/intel/uncore: Support multi-die/package
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 8:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 06, 2019 at 05:26:11PM -0400, Len Brown wrote:
> > @@ -1223,7 +1225,7 @@ static int uncore_event_cpu_online(unsigned int cpu)
> >       struct intel_uncore_box *box;
> >       int i, ret, pkg, target;
> >
> > -     pkg = topology_logical_package_id(cpu);
> > +     pkg = topology_logical_die_id(cpu);
> >       ret = allocate_boxes(types, pkg, cpu);
> >       if (ret)
> >               return ret;
>
> 'pkg' != 'die'

To keep the patch with this functional change minimal and obvious,
the rename of this variable was segregated into patch 22, which is
re-names only.

Len Brown, Intel Open Source Technology Center
