Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5108B8D24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437837AbfITIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 04:48:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50219 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbfITIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:48:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so1507412wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBGhwYpczMZ+4bbiY7a42NStzWV0pGWs8gNhSj4LGds=;
        b=fftI4fnaW2sCTl2nEBtnAA7nZxSqiCU47XXU1YYBVLXSAbXeklUKoJKpxqgYg5gFXi
         rqxenAtKeI4LAebPOd9en30CYXv71JcbKEWejTw9ByL2E/8wqSKOltxQbhh2k+7EYqlP
         AqQ+TIWsij4dHV7ACyvuPKdepyNFOewJT93NZrHuUgHUPKUaZx36Wbp1mR0pzns2jyHC
         nEVwgx4H8j6aW46PtJojvxikeBc2g1hJjpWAELkhhyZu5ULvuwIs4T9JiscjBnPY7xLw
         PhIO63dscxdQ/pALjc5VeUwbjBqVqS9ndG8jThcaORP2ERidG9urVKiMFlFQ16Tthtsv
         gYiA==
X-Gm-Message-State: APjAAAVDBQK2iAE+1BMtBtvD/Z2YbuGg4xeav0xx5uOEDaHljGXWEpqO
        +40Qkq5dq4l9CEve56d44Gaeau8z7OTbFkw+2oM=
X-Google-Smtp-Source: APXvYqwqdEWgFCjb8JckQEfZzSexOWQLDOIYwWH9sJa7nTiOOVl4cRl8joKa+v2GQgC+t0K/jB/qE5TMJq6/Vnrxdgc=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr2366867wmi.160.1568969276944;
 Fri, 20 Sep 2019 01:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190828073130.83800-1-namhyung@kernel.org> <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com> <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com> <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com> <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
In-Reply-To: <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 20 Sep 2019 17:47:45 +0900
Message-ID: <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Song,

On Thu, Sep 19, 2019 at 3:43 PM Song Liu <liu.song.a23@gmail.com> wrote:

> Sharing some offline discussions with Tejun.
>
> ino in current kernfs is not a good unique ID for cgroup, because it doesn't
> increase monotonically. So we need to improve kernfs.
>
> For 64-bit, we can make the ino monotonic, and use it as the ID.
> For 32-bit, we need to make the ino monotonic. and use <ino> and <gen>
> as the 64-bit ID.

Thanks for the sharing information!  For 32-bit, while the ino itself is not
monotonic, gen << 32 + ino is monotonic right?  I think we can use the
same logic of kernfs id allocation, but not sure what the problem Tejun
mentioned before is.

Thanks,
Namhyung
