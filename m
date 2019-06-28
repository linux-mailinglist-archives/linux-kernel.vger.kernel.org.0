Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D459050
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 04:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF1CNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 22:13:00 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45485 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1CNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:13:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id m16so2577655ywh.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESdzyALH+b44/HL+ukDoP4QdSzem8V/icNADS0o9wFw=;
        b=bNoMT+YuH7ItGziVtsdIPXsPVFdbcyoeQtMerqHWvQsnSinptdEeivENVNdUr7TGgH
         xs9S8RJdpFaJ/u8yifB/4AFCuclR6vey0K+VFkrCKxc7CD6VrygNTDddQFT8XoS2xY5k
         B0Azomfo3EFsSKBuzaSHT3/t1S7yKCBAYqaGhu+vKwVWDDYJcPXiRDEvfz3vBgwHqKPu
         UsV5N6XCFxj3SDFFkwHdx0PVbh5PMzCj1A6FXBI+G9ad/eqnis4qroBq2Ejk94ZhomLv
         /FcfOTAjaVHiMdNxlTpO4YuYAz9aatDHVh/RxmZCxsrQJrFPI3InGgc6lXuv/sSzNAfk
         SCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESdzyALH+b44/HL+ukDoP4QdSzem8V/icNADS0o9wFw=;
        b=RF3ma975mvc9MNW2uIErOUPsek7TQffwLNkxfQvwd/6O0C93q0STKVETvEGxEIrmtz
         ljm+qvPWYsgmSlvx3u1XLORn6Jfe8gjp9x6bHuHTxAXfNR31GPup7+9HIp5RV6BKOHBi
         T/KqfnIQQ9JtlOXP9x6Wt4PX7AwC33Mq8vzHTQ34X2CyCDJ9uCXIZ7uWIXjMjdKOM/J3
         dDsimWIXIJj2nPrArBhhqws5GImStd2zZg2Lfjs91EVkbBWswYFYx8Mp81/abeY+A6yi
         f2nSmKiKUhYZLHZkGOc4148bn01121ua2rpgMBaOnBkg/mPdSlZpwkez/b91i+oDa6YZ
         MtNw==
X-Gm-Message-State: APjAAAU6IyjjzCzOTb/9eO65NJmWtu3EBGCfxreQ/f6tN2RHTTROyNxa
        2Sd7aTbiBLGVja9udjLZiH9611yP7LeSd3wYoDwYEw==
X-Google-Smtp-Source: APXvYqz0Cii6IBq9YH7EmbunOU8BzavnHLsl7DRlxEB5WcJVW9lCfnYlLvilIE/eHTA8PvLerwqJhx3puAdd8M0dbfo=
X-Received: by 2002:a81:a55:: with SMTP id 82mr4680020ywk.205.1561687978995;
 Thu, 27 Jun 2019 19:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190624212631.87212-1-shakeelb@google.com> <20190624212631.87212-2-shakeelb@google.com>
 <20190626063755.GI17798@dhcp22.suse.cz>
In-Reply-To: <20190626063755.GI17798@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 27 Jun 2019 19:12:48 -0700
Message-ID: <CALvZod6_EDG=WMvrcrSFK4yJ69Mc-sqWJ3_HycCUdW=FpxzGVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, oom: remove redundant task_in_mem_cgroup() check
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Jackson <pj@sgi.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:38 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 24-06-19 14:26:30, Shakeel Butt wrote:
> > oom_unkillable_task() can be called from three different contexts i.e.
> > global OOM, memcg OOM and oom_score procfs interface. At the moment
> > oom_unkillable_task() does a task_in_mem_cgroup() check on the given
> > process. Since there is no reason to perform task_in_mem_cgroup()
> > check for global OOM and oom_score procfs interface, those contexts
> > provide NULL memcg and skips the task_in_mem_cgroup() check. However for
> > memcg OOM context, the oom_unkillable_task() is always called from
> > mem_cgroup_scan_tasks() and thus task_in_mem_cgroup() check becomes
> > redundant. So, just remove the task_in_mem_cgroup() check altogether.
>
> Just a nit. Not only it is redundant but it is effectively a dead code
> after your previous patch.
>

I will update the commit message.

> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks
