Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49EE192974
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 14:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCYNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 09:20:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36600 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:20:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so3050461wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISEybfkjEFb/zuIPAIVpI+Os5qgMM1LlPxoaIqHKxaI=;
        b=dl65k6vf6NSQCxzVbw2JkdyaiKP/3F4VeT8gEhGlp6Fuwsg4WkDdgYCs8Fxm2To5Ql
         51PdsB0fHihuTZJwqgRvkAJAU5qZAA6qtICnpWIMOWdexfoZUJm+OYd4SMbMOn3QO10r
         lZS1MifOECVcXw4IlEKClN26qsiWIMk8Ogzvl7ltHd+k02Q+ALHvmeFnszegIxGzecLY
         zZXSDRPrPdAZNJs4xvHZY0nfQb6Xm7u6KDrA8A8g8fnSPS0RCG571L/1wfVNrrE2BY6l
         Y9ewVfEnMy8Zcc54jqKQf6Spy/nfl6wj8AkzoV9N7jMl4Az8D18arzlroou2KuPAZXBa
         5a5Q==
X-Gm-Message-State: ANhLgQ3GMLi3veGxFJpCFDniPMCNAbfvnhiXqAf/G4pN3zJ38VHBAAq7
        HjnnNSRI8omSOMw9oQKah7QHa6/i8zkOykv9a1o=
X-Google-Smtp-Source: ADFU+vtS6h7i4Srpmnt7256dw4I/5wiFmu9FpcWXuS6KRWR/8Gc9MZ03gX8Ecr3FyfCxpdlsKPrbIU/bKt+MEVIPwK0=
X-Received: by 2002:adf:a457:: with SMTP id e23mr3466334wra.21.1585142409132;
 Wed, 25 Mar 2020 06:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200325124536.2800725-1-namhyung@kernel.org> <20200325130548.GA14102@kernel.org>
In-Reply-To: <20200325130548.GA14102@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Mar 2020 22:19:57 +0900
Message-ID: <CAM9d7cj1RG0Do9TDSGpRScK+O0bYZ=EEwCdibScBkTbz=4f4Tw@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v6)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Mar 25, 2020 at 10:05 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Mar 25, 2020 at 09:45:27PM +0900, Namhyung Kim escreveu:
> > Hello,
> >
> > This work is to improve cgroup profiling in perf.  Currently it only
> > supports profiling tasks in a specific cgroup and there's no way to
> > identify which cgroup the current sample belongs to.  So I added
> > PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> > integer having file handle of the cgroup.  And kernel also generates
> > PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> > cgroup name (path in the cgroup filesystem).  The cgroup id can be
> > read from userspace by name_to_handle_at() system call so it can
> > synthesize the CGROUP event for existing groups.
>
> Thanks for the refresh, I'll test this today and all going well push to
> Ingo soon,

Thanks for doing this!
Namhyung
