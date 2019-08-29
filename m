Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435F5A0EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfH2Amb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 20:42:31 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35449 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH2Amb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:42:31 -0400
Received: by mail-yw1-f68.google.com with SMTP id g19so568578ywe.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 17:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGRwNGErn4fgKcrUQ6xiTdFGa/UMxL0bW7u4f7HW4+s=;
        b=pBO9kFI77gE/gtpKbWkDAhKyiVvqdGWPANz9tNI0ulLcwYHoReFSfdXsKvIH5b2ukK
         WGnn+9GA91GX0cvQr5BUecBkiW3S29/Rw0gTWQUMFlFjv518j/HXADFAj+4761buG12B
         iyiEMUsd42x8e+ChjWSlMASRf9onmoRTvLke52aYFW5iHXS/bcePN11ElmPPs2wEHwr+
         +lo9WwG12RwAezKZNZnE+4D2qf1ZmnQwI4Yefcvpkkl6fjQclDsYV6Df+hzX3xOmZ8Wm
         w625t6PosUftPeW/9D5oDaSYkeGL4TR12mZ+mdAvFl3FLIEjoe+eb+wrL1d7u+9yz/dL
         GWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGRwNGErn4fgKcrUQ6xiTdFGa/UMxL0bW7u4f7HW4+s=;
        b=VycfQ41e1q/7f49zrDID0AZ+qBCDlpK9p39/VvzSvxxRESQIJBxWLaleCOhSacbbYE
         Tfpvf17FKK6WU2/iuxNoux0g0EIuX/KmTec4AtPoeS+2pPuMjO/DvudGD0yAv49lisqA
         3M2S+Yz/0xTI3u4+nEx50pnaT46OLi44V4g5K3r/CEWk6dyLrlDHe34rNSEoPNS/t4sL
         K7JCwjWAeg0ah+RQjuuMjlBJ4UVibw7yGZa5vLo8BX9B5P2YUwkmSXIGf8/mh83cBLnm
         a0ihZgqaxxE+vjeZuIYRnWnkhlL/tM7xT8mH/KpyOv2OpgEjXK5hzK3CQB3iWBV5dSyr
         osFw==
X-Gm-Message-State: APjAAAWcStzKdaQ6siktP+ohMz9p5yk1UAGK/ClFF4rvT6J5dXIZlydM
        NlKV10YBJe/t4YGwTDKbZy/fIjobiqk4fcQ53+wwwQ==
X-Google-Smtp-Source: APXvYqy5sKfSQACB2NAIiSOftUd7x4Lw2pJ4Aa//yGOwNk/VbNo7vi6L+kgnsQlyUjh9vJq+0hA9wmBNIT5b9wnNNlk=
X-Received: by 2002:a81:6643:: with SMTP id a64mr4939106ywc.205.1567039350010;
 Wed, 28 Aug 2019 17:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com> <20190828112340.GB7466@dhcp22.suse.cz>
In-Reply-To: <20190828112340.GB7466@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Aug 2019 17:42:17 -0700
Message-ID: <CALvZod50oU2M6uhUU1JsBz+qWYgSCb9brMVVnxmGnzSRY+1k_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>, mike.kravetz@oracle.com,
        shuah@kernel.org, David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Cgroups <cgroups@vger.kernel.org>,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 4:23 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 26-08-19 16:32:34, Mina Almasry wrote:
> >  mm/hugetlb.c                                  | 493 ++++++++++++------
> >  mm/hugetlb_cgroup.c                           | 187 +++++--
>
> This is a lot of changes to an already subtle code which hugetlb
> reservations undoubly are. Moreover cgroupv1 is feature frozen and I am
> not aware of any plans to port the controller to v2. That all doesn't
> sound in favor of this change.

Actually "no plan to port the controller to v2" makes the case strong
for these changes (and other new features) to be done in v1. If there
is an alternative solution in v2 then I can understand the push-back
on changes in v1 but that is not the case here.

Shakeel
