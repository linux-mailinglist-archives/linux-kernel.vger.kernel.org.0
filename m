Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA4123E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 05:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLREdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 23:33:01 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:52115 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLREdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:33:01 -0500
Received: by mail-pj1-f49.google.com with SMTP id j11so272355pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhWhhJRvas1fX646WnNBdCig25ysHcJ+tN6mdIOPt0s=;
        b=OwsxUf3j+WHDhf/lx/mcXYPECFgQNqJTOKGWSgjWY92F0l4lmrMfeClfU/8Moo+7rT
         BluGEDiqFgK5LbhLtSryyUErnSCuycEbGYFTT20x70BzHYbf41GRWCSRTprG7Lrso8PW
         wS49W4quNIgP1iHyjsN3NaaH6W/ZMcwTLXVEgRPMN4dBkHwn9sgrLAmjmuee0kPAt600
         uAKLwFSzfNoOAk5Da4IjRM2D6oFapj8EzSxX0+KcnWfhRvMWJh3/+y5Szc9H90OGaZPW
         kE2WN29zBE/5mFMuKeVbGj3NfDHBjZivrNj0g/FY4COFvtXC/r4UqsEZGsR8kb+cPDBp
         yWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhWhhJRvas1fX646WnNBdCig25ysHcJ+tN6mdIOPt0s=;
        b=GP1o5bOTPC9v9os4GFn6ghPvLWE3QgS9hiDwJqN5nqueFXBVzIQB4sR8DN7sew3HcG
         TBZSmfYVatPTpjcyngym0395me9Rj/21wRCKExQMFTXxOkQPTMsFhE0bu5fG8OQhsxPU
         KtoXa9w6d0TgjSBsxT5V69geJMjeCYjZd/PGYovkvnIqtz3GOLXM+tw/RI0BGKTui3ID
         pWz31UPBop2Qe3LD5S7fFchwSa+yghg1KoSpWhCy6haWxP0lxWNTqW+0uWN/+CsLxbM4
         wAVmQVe2Av5syBQ/TmEAp0HoNj19Z62q4dD8bg+ZW9wrp6O/nMBjUI350iK2DnLUGhy6
         1hlg==
X-Gm-Message-State: APjAAAU3XhKmrJ/xt/vL79XCk91vJX2AbBdleQnVezqhGPcMneucJuQJ
        DANblgaHIqnZzkr1i+Y5X4FXqprnhTfIXA6ttAfXneTNljs=
X-Google-Smtp-Source: APXvYqw8lz68SMylW0jxDOP6eWVeHHMSeZzt8gFyiu11XP1sXj1jCm2+RD4n/3QfpBnn58DskFF3h88vSdbt8VM7GJI=
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr439589pld.316.1576643580541;
 Tue, 17 Dec 2019 20:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com> <20191217094304.GF8689@8bytes.org>
In-Reply-To: <20191217094304.GF8689@8bytes.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 17 Dec 2019 20:32:49 -0800
Message-ID: <CAM_iQpWGa55xuKV_4hMNNcktNt9MC2XvJU3E8pvFEqja53nmzg@mail.gmail.com>
Subject: Re: [Patch v2 0/3] iommu: reduce spinlock contention on fast path
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 1:43 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Thu, Nov 28, 2019 at 04:48:52PM -0800, Cong Wang wrote:
> > This patchset contains three small optimizations for the global spinlock
> > contention in IOVA cache. Our memcache perf test shows this reduced its
> > p999 latency down by 45% on AMD when IOMMU is enabled.
>
> Sounds nice. Can you please re-send with Robin Murphy on Cc? Robin, can
> you have a look at these IOVA changes please?

I will resend V3 with Robin Cc'ed.

Thanks.
