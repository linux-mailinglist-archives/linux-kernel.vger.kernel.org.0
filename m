Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFBB1978B0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgC3KR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 06:17:58 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40407 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgC3KR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:17:57 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so15229814ilr.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upalIYLMXEqgwroFLz8o7p1PD72FjazAP3WakghPkvM=;
        b=OB4YBY85n9imsGg6EVlp5X/dL5sesnMAd72Zo5+hI1ARiBUrhnAzxB/iJsUa8pYWZt
         uywkv307dGztvTZSdxthv7uCWf5rfs2oJ+vTEBgwL+gyV+AudjJkW59Zke2qHHtcuGUW
         xE71y94apvMy8hrexN1N2yhqBRsULLRvozIfYHz+1sIOQk68iZjzngdqzAmPvuQwmTHG
         ygMNdF+jcxrmm+zClKcjrdoT4GmCFSl+TJMk9Xg5EEEn0nplMGUlVVMGtibcdEhNIQzy
         fU8a56p2Q5VYcmgcwrWcDDH2Ny7XCSSOM8WVTR4volSYtDUVHg8/gDDt8jdmAGcADyHc
         2GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upalIYLMXEqgwroFLz8o7p1PD72FjazAP3WakghPkvM=;
        b=bG08zlTlfrFaCp8wPXm3G43ZhZr+GRJhbDcz0KwFtMU42ZvcXt+G0x+tZ7yRdkkKQk
         wocuUNOH0367qKsZcyoqtPYbHdzsnXDz0VzQEVqvMPg9R/kv7Nq4KNLXKs4P37wZ+UJG
         j7k5DX9QyEq5+uxV6rpmiF45ciT4z5HX0m0enCYAsdYD6Iskx1Vf53PJHryN4gVObqxt
         r3NixUKwQFoo/3xVrU/YLUpAmAYPYz1YjHsZV+LM8kUbJgnrxJWwb8wKqyM+WzH8kepa
         4tGxTXHxUR4CjHL+3OcSKkY7kjgjlUO6qnJDeRROZQevj2XkdkV42sflprOIb80BjiQu
         kDGQ==
X-Gm-Message-State: ANhLgQ1/qBfSULeLIiUZPv8YY/DEIu+yG2A0kclKTU2bZr8vQdEBU9yO
        JOiu8QRVhc0RGu9yXRegOa5Alw65zfLidlDv3hqA
X-Google-Smtp-Source: ADFU+vtM5O5MKf06RLTuQxKEjmU+bK0fCa5rUBlA50W1+2VdL5TlEICp27mWm8Phqc2kq+4f78AN0ULdS3rHbG9Lask=
X-Received: by 2002:a92:9f13:: with SMTP id u19mr10500655ili.111.1585563476283;
 Mon, 30 Mar 2020 03:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-26-jinpu.wang@cloud.ionos.com> <619d2dda-3c4e-a909-ab78-1201057b542c@acm.org>
In-Reply-To: <619d2dda-3c4e-a909-ab78-1201057b542c@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:17:45 +0200
Message-ID: <CAHg0HuyBtKRca=8k_O9ZvPREMry4L7pcmKsm=GUCq_w8Gtjd-g@mail.gmail.com>
Subject: Re: [PATCH v11 25/26] block/rnbd: a bit of documentation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 8:40 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +RNBD (RDMA Network Block Device) is a pair of kernel modules
> > +(client and server) that allow for remote access of a block device on
> > +the server over RTRS protocol using the RDMA (InfiniBand, RoCE, iWarp)
>                                                                    ^^^^^
> Isn't this protocol usually spelled as iWARP? See also
> https://en.wikipedia.org/wiki/IWARP.

Right.

> > +dev_search_path option can also contain %SESSNAME% in order to provide
> > +different deviec namespaces for different sessions.  See "device_path"
>              ^^^^^^
>              device?
Will fix the typo.

> > +option for details.


> Otherwise this patch looks fine to me. Hence:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thank you.
