Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6999519ADDD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgDAOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 10:32:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55154 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732856AbgDAOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:32:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so6854030wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsdI0VJCJ/wntYkaRR/WzYPZ90L50WDkb/Zf3FlHE2w=;
        b=f2tC6ek/EE43IDwfBntDTf6pjZVD6k/xJRrfYzbnkbqnigJ1nYlz83Jv3STXmFnWo/
         gRlnK7wAW6RszM0Q1Zh0P3JikcXm74f0DZiQmhflb5Ff4axHG9F04oQk4gpKNehx8C1E
         2OFmyDlEqiTUeLyUyTb+VlKxcKXfMvcvONruXS6Xpxut/5Li6hgfr7BeacbY34YSPkxd
         FjCKuPvxsLQJw9CjuewixnkOVIlTHRyH3lSZsMIVuzpwCXiDAdVTDtBXhw0wWCGQUoqN
         5mlUCUjFmy6+SeUFRPqnrKD9f8nKFxPXd7o7QVB07liMLJQ2yIJ7LtTcypARZTn7wG66
         0Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsdI0VJCJ/wntYkaRR/WzYPZ90L50WDkb/Zf3FlHE2w=;
        b=tynz2dYPXjLqcKRmYAGFgZC+9rnM65P6R9y2mhPpPc1zwqUhuPuScBUcX9IOLYJhJJ
         FzrdG6OaYxFDJCpesQnXz9PX3ZvIWpj6N3mgjtwrCYrMI/M2r7hMouFwvt73w7PX2RSv
         sLpphPzDUAs/Ql8BOaj728X/F6UpIUu+1ZbPAwYXoLvheqk6A/3xeARw/GSI15BJnFZL
         yyzSXQ2EPT7LWlAz7l1G8ZFDiPYm6/wti1uLu/H4+OzozdYFkDrTlOrZ+r+DjvrqGPXT
         r96eAdgz6zxfE7a2Mtb3DWNDmTMLxrVS4/YWalRVF/XrEXQMC3C+Pm8COnhg+HdsgBm6
         cBug==
X-Gm-Message-State: AGi0PubKBeyLQf82aK28e5CboF6KiMPOmWR3/nF7JxscbE1RFiYT/MvK
        +M4btgU2hrY5Gvnz9DGRuGlsU7cS2liBpBk+7Z1pdA==
X-Google-Smtp-Source: APiQypLkdPTpJkV/BrKScGqyYOgAoDx0VJ+ym0IXEyvvIu2pyUAipdryZ4OxgfA5NzNYpN9Npbyo+DzdlMD9pigo+1w=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr4634887wmj.30.1585751523108;
 Wed, 01 Apr 2020 07:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200401104156.11564-1-david@redhat.com> <596d593e-7f36-0e24-6c67-311bd6971e89@redhat.com>
In-Reply-To: <596d593e-7f36-0e24-6c67-311bd6971e89@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 1 Apr 2020 16:31:51 +0200
Message-ID: <CAM9Jb+hYPUZXVLr2T8x6Njcscw_+W0e2SCmr_B1fLZuOwgLZuw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge VMs
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 01.04.20 12:41, David Hildenbrand wrote:
> > Two fixes for misleading stall messages / soft lockups with huge nodes /
> > zones during boot without CONFIG_PREEMPT.
> >
> > David Hildenbrand (2):
> >   mm/page_alloc: fix RCU stalls during deferred page initialization
> >   mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous()
> >
> >  mm/page_alloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Patch #1 requires "[PATCH v3] mm: fix tick timer stall during deferred
> page init"
>
> https://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com

Thanks! Took me some time to figure it out.

Pankaj

>
> --
> Thanks,
>
> David / dhildenb
>
>
