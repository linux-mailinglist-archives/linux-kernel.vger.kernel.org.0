Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F077129C18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 01:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLXAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 19:40:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51614 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXAkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 19:40:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so1135145wmd.1;
        Mon, 23 Dec 2019 16:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfX3yVFIR62qBqQmyyt1q/9YQm+oZqZAtuSs7/zK2EA=;
        b=Z6n89UzyvJ7gWUDhO5Z2kYvca2egv7HHp/rjrH80qy1AWbpm32kZaLxx6V5GVsPIfE
         vnIkW0gF4kvU8YBnKBDA9KE6QXqIlkqvWt4cexy1iBpagLTVxrfvbXE0er2G6l6fJbpi
         FnekVzqw5pzd47JU3qdPmQPMYEzxyaMcDTB7a6DS3SjbXUwSfkn9Xt6x6v+D8ZK2jJWJ
         +M8SRoJYS2tBzdnm/8VO7ABDoPDKQLg0Uw/cgiIRBF9uJMGm/XpCbvddtcJzR8x5dn4t
         XLTg4qmIq9V+sZAO3pqhjzFk/N0boGxgbPLliQRW6EsmlhK9GL9F7a7xm2Z6FvaUV2Nl
         A7YQ==
X-Gm-Message-State: APjAAAVu2dLANiUkUWzh3hx5pV2MIbka50QipMIUO58fOZS3KX2Fh6ue
        SNQFBbi4aY/8QQCY+sQnr8OClgjvS5S/ib23GEc=
X-Google-Smtp-Source: APXvYqz7mT/mi7iguliWvqWQ9QTjatPRTJ9Vl2DyK9UUXmaUEJn4SzJQsH/6ytg8GbOHffvKhqKzeY414jujeNZm4bE=
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr1239598wmg.39.1577148015782;
 Mon, 23 Dec 2019 16:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20191223060759.841176-1-namhyung@kernel.org> <alpine.DEB.2.21.1912231235090.775@macbook-air>
In-Reply-To: <alpine.DEB.2.21.1912231235090.775@macbook-air>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Dec 2019 09:40:04 +0900
Message-ID: <CAM9d7cj06Hj3hOSdcyTpRWaoBY0wLjPpt7_+CbUqtsF-_08Czg@mail.gmail.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vince,

On Tue, Dec 24, 2019 at 2:35 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> On Mon, 23 Dec 2019, Namhyung Kim wrote:
>
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
> so is there a patch to the manpage that describes this new behavior in
> perf_event_open()?

Not yet.  I'll cook a patch once it's merged to the Linus' tree.

Thanks
Namhyung
