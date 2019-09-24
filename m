Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6490BD054
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394266AbfIXRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 13:10:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32816 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390772AbfIXRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:10:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so2822283wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzsvNzVxxGu66TV9JBcohv4aSCVQ9N+CrimQFbBQgd8=;
        b=q8jLYFvKk4f66UxCLZ8A63C0NiKhzpoKOMGfymSB0xnyU0frpoyznW6vLlXZspsNrz
         woNKByYLsgCno0jpUtp+oOINXF4B5sXpYsOx2K9OD8tOB3lX6dCKdnKd3KowRg4SYS7I
         hfaKWF4yQcP3yeX/e1NOqxR5mUe22hfqufrmnnNn8xnXq3vkjFs6Wg4yOPAPOA/Iarig
         m0tFswFbm6eKTo8I9pMfy/n25vyHvgVoLU5X9FhdlCUs+a9lpq4qAajMbOV09Z/26rjq
         OxgErw3/cO6SB/VvrBmGItIyNuj9g+s0R3tZh2Z4jKC7/R4rke+1OnXq4DA7QMYzNI80
         9D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzsvNzVxxGu66TV9JBcohv4aSCVQ9N+CrimQFbBQgd8=;
        b=NYNUhLwIF+cDtg5sE9+E3akjnx/O+wtlOZwBUz+OK05MP/EChKqEkCbhFyICPvLrWg
         PGdfEWgV7ho/clMAM/u9e2ReMgdo1VMZhZAeAnYt8sGygF4/mPTkZIuskvjSqDRPz0ZU
         tG3A6+1h5GRZLO5n9QGJ31ov8+0bA/M01huBqMe/0jjBQTBdSX+azI9QJPaugFzbjREi
         pkyT11hM7VyNktOBd8CLdfxZznouT1vkYTwnhCzbSjnZMwayTf96lFoeFBGQtD/CxjHB
         EH6ygao+3ExEwwoyMBR64ocemyC071GDLbJftnMgc/cELVPbbrFr24kU32FsEYcMoenh
         cMxQ==
X-Gm-Message-State: APjAAAWITUyibnIMqwE9OzusfSrONVeNd7k1EzLlrxgG+c+BIdYuYQ53
        naXP/beAScW3+2L3eAlA6grIetjw43/eDwLvuWdhaQ==
X-Google-Smtp-Source: APXvYqxqVk/Ef7tRuRa5yYg7CGYD5fX+26kMjdKG9iupv2TCNz/LcROsTFdXtBcLmdx5qsHKQ5/RBLYryihpfqE75YU=
X-Received: by 2002:adf:d08b:: with SMTP id y11mr3579300wrh.50.1569345013696;
 Tue, 24 Sep 2019 10:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-2-john.stultz@linaro.org> <20190923220807.zuqxthydxybjgoog@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190923220807.zuqxthydxybjgoog@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 24 Sep 2019 10:10:00 -0700
Message-ID: <CALAqxLVmG+wP5KQLY5hnxaYBXdET0Ub4t-hLP54pFhOGLi69KQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 1/5] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:08 PM Brian Starkey <Brian.Starkey@arm.com> wrote:
> One miniscule nit from me below, but whether you change it or not, you
> can add my r-b:
>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
>
> Thanks for pushing this through!

Thanks again for the review! I'll address your issues and resubmit.

thanks
-john
