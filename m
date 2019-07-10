Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E526279E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404065AbfGHRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 13:50:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35210 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfGHRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:50:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so18940570qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yL5BRmtaPbPkgux2h8HVt6KP5oApfrPeQ3tBLfzIdSU=;
        b=OZ5opmc6L7elFVmJBDlWcGFG6GY0fE1yQP+zwuSbeqLjB1kHLXdsmV8DcALWFrfzzQ
         hdQgY1/aHqJ5eESq5nOmZC2NjQ07Lc56IqoVFws+4z3rCrCC2ihceYwIR4FepwxfO9+H
         xdq3qtqBwjGp+/Hwrzn4UKWeJ+zwS3cN8dQyU8r3s1f3bAzUX/yOahA1k7dsezmxitjY
         8co8wChHtFo1MwvxewyiQyjGGpUuRgXO5yt7kSv0D8i8YDJtY6Tk2nJxBQK7N1G8EfjI
         sOR0uH6Bs192pfn6afB1ikq2npEt3ts7J1TovO03hujpILG51zqoSlyY/ox8tCW2QUhm
         a5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yL5BRmtaPbPkgux2h8HVt6KP5oApfrPeQ3tBLfzIdSU=;
        b=g5+/16gRugCY8C6G6jKkPnJHj6F1Vh5rSCYKvTE3QTlwPDy85eVZ3lLTej/x9obMIN
         zuahen1z2Jkf7ltESgCCtcDw2WoKy2g5QEPXLeLArkS+j6ZR+bXI4ok7uYAzNQspbbvD
         pId4IwlWCW5HdgcNnad4v8U8TzASaW4bEtdkAttWYJIZEmx0DbhdvA2oAJX/DndDC60Z
         tCEbs7V4GRvBv3NNScW93KKxTOYLlN289/xaGPO4795oiICAQttusRTVfTZDMdw9oPqZ
         5oYtShrGvyJ3ia5gxV/hVxCBFb1ioMGOqLYUD2wqv3E+oK+zbVpEaPCATMj6ihN5iGcP
         yMDg==
X-Gm-Message-State: APjAAAW6SkIdEh2CM6KI9a09sUqrYyGujTrNniIiAGCO0CswN64U1y3m
        +DTzGdf08zy3jX2MtMmFnURBLHJ5CHTMLg==
X-Google-Smtp-Source: APXvYqzyRwj+FvFh3OAmcgN2w65t+gP7/eJLQtjFQNIbuzr4Uzj62KUE+402oSxbzV2SqfCGQ1kPgA==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr15091775qti.72.1562608226174;
        Mon, 08 Jul 2019 10:50:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p4sm8298394qkb.84.2019.07.08.10.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 10:50:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkXmT-0001pJ-Ca; Mon, 08 Jul 2019 14:50:25 -0300
Date:   Mon, 8 Jul 2019 14:50:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     dledford@redhat.com, leon@kernel.org, parav@mellanox.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
Message-ID: <20190708175025.GA6976@ziepe.ca>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
> Use neighbour lock when copying MAC address from neighbour data struct
> in dst_fetch_ha.
> 
> When not using the lock, it is possible for the function to race with
> neigh_update, causing it to copy an invalid MAC address.
> 
> It is possible to provoke this error by calling rdma_resolve_addr in a
> tight loop, while deleting the corresponding ARP entry in another tight
> loop.
> 
> This will cause the race shown it the following sample trace:
> 
> rdma_resolve_addr()
>   rdma_resolve_ip()
>     addr_resolve()
>       addr_resolve_neigh()
>         fetch_ha()
>           dst_fetch_ha()
>             n->nud_state == NUD_VALID

It isn't nud_state that is the problem here, it is the parallel
memcpy's onto ha. I fixed the commit message

This could also have been solved by using the ha_lock, but I don't
think we have a reason to particularly over-optimize this.

>  drivers/infiniband/core/addr.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
