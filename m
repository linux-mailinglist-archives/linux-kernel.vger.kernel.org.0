Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156421353E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgAIHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:51:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38693 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgAIHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:51:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6274721wrh.5;
        Wed, 08 Jan 2020 23:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7jKAd2k6zMLFNHzbXJbak8vuc1kQgCbhm39LF3QafA=;
        b=ltCQSNLCHch5K1kxyYNVnQ/lV4KRHa2zUPHC5/JY7WXWg8FlZ8Ut65ASBiJ04TRNl1
         e6eBhoR8vxFPTPSqrIN1s2fUPWkuzy8Tt0gwHONNX16jjYIbNDF+Nzg6tnawYSmVWnkW
         0AmhkphZjQlDwl94ARBSF1yThUZoPxGG4frPREiugAokNeL1VZsIiIiV3HSzfjX75sxv
         fCZwScv9vsCYcpNZQLfk3cgkMgB5DFOVdNIja5oQS5T+SqmYpabYNt6dogNN4sXSWyJi
         SAInn8cL+pT7FHgynkLq23VIvANDub/QOhAwbl1e95IVj7OvfRiScW5rdqrGIvQpnqHB
         1iwQ==
X-Gm-Message-State: APjAAAVS5WzykKKH2P5n78/kxi6pgManDu9G3EJ8J5B9toTNSlF9e1Jc
        L8DLpnPmvp2lFLojxNTT8kukla2IB23e5VEx5lLmaw==
X-Google-Smtp-Source: APXvYqzZa/dLk/C0E+za19OrHOhco7sEr5NWaZA6GxB3Or3aoyqUEONi1OoE5UpRl/9tcMVVo/SWkRaUqx3IFzKGDQk=
X-Received: by 2002:adf:ef10:: with SMTP id e16mr8801931wro.336.1578556294102;
 Wed, 08 Jan 2020 23:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-7-namhyung@kernel.org>
 <20200108222156.GE12995@krava>
In-Reply-To: <20200108222156.GE12995@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 9 Jan 2020 16:51:23 +0900
Message-ID: <CAM9d7ci-LfDtjX-e343pUMeMB4BD+bbyduYW8LM0Pweus8yarA@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
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

On Thu, Jan 9, 2020 at 7:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:34:58PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > +     closedir(d);
> > +     return ret;
> > +}
> > +
> > +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> > +                                perf_event__handler_t process,
> > +                                struct machine *machine)
> > +{
> > +     union perf_event event;
> > +     char *cgrp_root;
> > +     size_t mount_len;  /* length of mount point in the path */
> > +     int ret = -1;
> > +
> > +     cgrp_root = malloc(PATH_MAX);
> > +     if (cgrp_root == NULL)
> > +             return -1;
> > +
>
> hum, we normally use bufs with PATH_MAX size on stack..
> is there some reason to use heap in here?

No specific reason, will change.

Thanks
Namhyung
