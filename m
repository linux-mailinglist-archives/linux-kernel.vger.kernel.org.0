Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F83635BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGIM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:26:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41517 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGIM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:26:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so19968703qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wcigI1ZGeo8eeTEnwECE+YFE0TGljJQaiCrYDUmdPoY=;
        b=WVLNrS8kRPuxvyBdWG7zDP6SEPUBYofpJ2EvO8ewlhlmj+JtcYvU+ubEfXnLaR+pYF
         00h1TFt7LTW/PVmJNM8kIBVI1rELrWpvy6BaUCc3wbUEXrb8YASn1gF1T4ngpXJyiL7K
         m0fniPYck0eAKIwb0Jn/kABVeifrxxb/tRyZR68eGTBKyUqSqAGe1cnO4/HFD4yF4Ur8
         H7WlIOTWZuwjoyjkE2yb9SIoLVCOwef4y9zoimZSKZfb3Rug5X4MmF1DHLEHWClUG/wP
         97+9Gr/p9To7e6DsinFumDPpx3c5rxWuY5AV9h3E6IHOqFT5d5nCU77+Yphj3xs6Ca4p
         jS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wcigI1ZGeo8eeTEnwECE+YFE0TGljJQaiCrYDUmdPoY=;
        b=hZymbcfWiqn0XSl2qCJ5/tzCWxi62iqXHPDyUKCGMjDzVKefFvGGTOqypUT4HLPdg7
         JpS8XxV0iL0RcR+8ZLlrS6FFRreNwLi/M3tnopxcv2M7Xj7LEjYo0eTc5c/SvOevJ74G
         KJ5gpF17PEExp3RllNH4WZdG6+YuGfY1HaohiHGK5Z/U62kPH3OHw48eC8mOSLf8Pxde
         iXob1xCp87Xi1857HMZ9AkwISocMN3/H3G4+GBot0lWbVTTmtKMQaB/xqH+H5LxnLzpV
         8d+qTv++mOVQdqpFGlhF6Up36iJiq9TQ3GW1T3piUGoKPYgx4aOeABlqcB2Yi5cn+V9x
         ts7w==
X-Gm-Message-State: APjAAAUu5HBPc/gISv42GX2BD05nbEQhTybfyU3ad3gsbOKVWrtKD4fr
        e7SpP+sSjsvmIqQOCiDsqCjufQ==
X-Google-Smtp-Source: APXvYqwmHmW4GNgj2/bw7KDrHJUCO1ymp1USSwOdh8JdsUvhsapUIhpm65qVHY72kCQumxVyPi372Q==
X-Received: by 2002:ac8:1a9d:: with SMTP id x29mr18851142qtj.128.1562675167390;
        Tue, 09 Jul 2019 05:26:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c18sm8566404qkk.73.2019.07.09.05.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 05:26:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkpCA-0001GG-Hq; Tue, 09 Jul 2019 09:26:06 -0300
Date:   Tue, 9 Jul 2019 09:26:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Parav Pandit <pandit.parav@gmail.com>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/core: Fix race when resolving IP address
Message-ID: <20190709122606.GB3422@ziepe.ca>
References: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
 <CAG53R5VQqqr0S6OU+13tcuxcvz922iuqoP-mWbaQERPc48964A@mail.gmail.com>
 <20190705040950.GO7212@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705040950.GO7212@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 07:09:50AM +0300, Leon Romanovsky wrote:
> On Fri, Jul 05, 2019 at 07:49:06AM +0530, Parav Pandit wrote:
> > On Fri, Jun 28, 2019 at 2:20 PM Dag Moxnes <dag.moxnes@oracle.com> wrote:
> > >
> > > Use neighbour lock when copying MAC address from neighbour data struct
> > > in dst_fetch_ha.
> > >
> > > When not using the lock, it is possible for the function to race with
> > > neigh_update, causing it to copy an invalid MAC address.
> > >
> > > It is possible to provoke this error by calling rdma_resolve_addr in a
> > > tight loop, while deleting the corresponding ARP entry in another tight
> > > loop.
> > >
> > > Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> > > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> > >
> > > v1 -> v2:
> > >    * Modified implementation to improve readability
> > >  drivers/infiniband/core/addr.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> > > index 2f7d141598..51323ffbc5 100644
> > > +++ b/drivers/infiniband/core/addr.c
> > > @@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,
> > >         if (!n)
> > >                 return -ENODATA;
> > >
> > > -       if (!(n->nud_state & NUD_VALID)) {
> > > +       read_lock_bh(&n->lock);
> > > +       if (n->nud_state & NUD_VALID) {
> > > +               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> > > +               read_unlock_bh(&n->lock);
> > > +       } else {
> > > +               read_unlock_bh(&n->lock);
> > >                 neigh_event_send(n, NULL);
> > >                 ret = -ENODATA;
> > > -       } else {
> > > -               memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
> > >         }
> > >
> > >         neigh_release(n);
> > >
> > Reviewed-by: Parav Pandit <parav@mellanox.com>
> >
> > A sample trace such as below in commit message would be good to have.
> > Or the similar one that you noticed with ARP delete sequence.
> >
> > neigh_changeaddr()
> >   neigh_flush_dev()
> >    n->nud_state = NUD_NOARP;
> >
> > Having some issues with office outlook, so replying via gmail.
> 
> Your replies from gmail looks much better when you used Outlook - proper
> spacing between quoted text and your reply.

Why not use thunderbird or something?

Jason
