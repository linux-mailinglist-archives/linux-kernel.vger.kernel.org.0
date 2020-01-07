Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37830132A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 16:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgAGPuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 10:50:05 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38566 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:50:05 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so46081719ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM+tQu6OkciIx8Fh2z8Ykuqej0TW6fLMjStC1bJEE7I=;
        b=gbdz0rmofSp363r0EzVMTy17sWDBslvGlYGctVZO81OyGq0IouxgVn5Lxh2+ABsLEa
         oMNNo9vvXeQQzj2xGg+AYuafuEFMsYmgC0VVs2vsNwV0cz1ufdlfWe+GWfH84y041Dye
         E+3sZLggrsV5Yw8+ORjIr0f1e9pZAlrbbNcmdRo/BsDUR+mYCBxcyzcgbtQGuJ5moBi5
         4SfxzVUvkftqvavqluEo9nRnNNV+19rqxUHZDi9/1Xc2nweL+7H1UKoMhiA/ribVYlwj
         7K+zgyxbPeWczDKOixusCrBfBB2N+g9rtSjakbAxi9CL1U40tj5L3azFw1XnyocmtKNq
         7gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM+tQu6OkciIx8Fh2z8Ykuqej0TW6fLMjStC1bJEE7I=;
        b=hL4BMqz1whh3TK/aITcN515phXCwU5ixsg9imKZP0//dqIdRasm/h+INC5tUNRCoLJ
         6Zx+ZKFGanmN5FbStUKKj7tfU2px7Ne9+BIz2C8Pq1fYsj1s8zQULK/IiaTGq1Ql4EbD
         xD1YMmiGpmV8YYUdwuykK7HLSaqOdxQ6YKWLmsboeiktkVx0bRWnLjiI4DkihGd4K6Ni
         HdflQtI35CLZh/oxm/FTzrIOI3tWwK/R6txG1qDAEc/DNrVcEn7Yu1q1XWvN7+bUwVYo
         1CYw2KtUx/1DI7SlCo7RhPh/w0unpLplBCEHP6xUy0KnlEE02pR4ozg249Rx3CIBb3wV
         MDVg==
X-Gm-Message-State: APjAAAU/ToPNkLgtcJh+6pQ74PFBN9ZnDVcsCbr/DJy5n2SFKImLNikF
        ILREaEqXN2+mlCCRrbNc/rKWrZOGgQsVAzcACVKOfw==
X-Google-Smtp-Source: APXvYqwtSiv4QVl4s0rBRLRrvIZh5ldy/c7Mu44zSQXNlW/uEb7q2Mf6MgtVf91SCmamEWosUmvRp+1ZqbmgKp8akac=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr93382387ill.71.1578412203147;
 Tue, 07 Jan 2020 07:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-15-jinpuwang@gmail.com>
 <bb668d4e-f768-a408-c541-d862d1a2f959@acm.org>
In-Reply-To: <bb668d4e-f768-a408-c541-d862d1a2f959@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 16:49:52 +0100
Message-ID: <CAMGffEmrHbw8wnsTD0BZV9O38-pJ0Yv7VLkNMJwGoRyOp9Yqfg@mail.gmail.com>
Subject: Re: [PATCH v6 14/25] rtrs: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 11:21 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-class-rtrs-client b/Documentation/ABI/testing/sysfs-class-rtrs-client
> > new file mode 100644
> > index 000000000000..8b219cf6c5c4
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-rtrs-client
> > @@ -0,0 +1,190 @@
> > +What:                /sys/class/rtrs-client
> > +Date:                Jan 2020
> > +KernelVersion:       5.6
> > +Contact:     Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > +Description:
> > +When a user of RTRS API creates a new session, a directory entry with
> > +the name of that session is created under /sys/class/rtrs-client/<session-name>/
>
> Thank you for having included this ABI description. This is very
> helpful. Please follow the format documented in Documentation/ABI/README
> and make sure that all text, including the description, start in column
> 17 and please use tabs for indentation.
will fix.
>
> > diff --git a/drivers/infiniband/ulp/rtrs/README b/drivers/infiniband/ulp/rtrs/README
> > new file mode 100644
> > index 000000000000..59ad60318a18
> > --- /dev/null
> > +++ b/drivers/infiniband/ulp/rtrs/README
> > @@ -0,0 +1,149 @@
> > +****************************
> > +InfiniBand Transport (RTRS)
> > +****************************
> > +
> > +RTRS (InfiniBand Transport) is a reliable high speed transport library
> > +which provides support to establish optimal number of connections
> > +between client and server machines using RDMA (InfiniBand, RoCE, iWarp)
> > +transport. It is optimized to transfer (read/write) IO blocks.
>
> Is it explained somewhere how the optimal number of connections is
> determined and also according to which metric the number of connections
> is optimized? Is the number of connections chosen to minimize latency,
> maximize IOPS or perhaps to optimize yet another metric?
RTRS creates one connection per CPU, optimize for minimizing latency
and maximizing IOPS, I would say.
>
> Thanks,
>
> Bart.
Thanks Bart.
