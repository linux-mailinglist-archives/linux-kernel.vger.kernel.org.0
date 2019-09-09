Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E968AAE031
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbfIIVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 17:14:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43151 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbfIIVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 17:14:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id d15so10088135pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 14:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWyrMvKoZeJUW2jP4aEz7GUGLNj1qlvRlvfndO0mMoU=;
        b=n/dhLxtIN4ODtKqmA0oAPdULbY5nCAefsuwhiWri29IT2iqWDPDfmAaLQnFIdhpG77
         zvT2u5JlUG36JPdNQwIAQ7m6WYev/uOxL1+8DLrue694/L+6S0RgwvwvGgpz5ILPz/Q3
         cAGwLymgmkNt49JM1aTwXIlFfG4Z3VSmS39p6ppM9H2534pwbWIeJnJpZ8Tlh289Pynq
         0Rg7pytasouwqHvI/z0mffZkOAwBAQnwNHUTulwZ4O+TRZYtsA3VqBeori3JVnaR9gJD
         Yh1exiYV6hBwGL7DXvlRd30A75CCYem0VmBoTmjGy4kaqz1Tneio3SsHHA3p2r3PfS2v
         7aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWyrMvKoZeJUW2jP4aEz7GUGLNj1qlvRlvfndO0mMoU=;
        b=XidsOsPJGCQ7Rz9TaXJPN9uTw+MnLXtMySFXSJM0iKE0ty5S96/4n1WkzoHeLtWpe3
         StMZzyiH2LjKFdprrylkOsiFI2LFdEu/9IL4MQdPG87yOLqR4+06uH4FcxQ8JVsMQJBV
         CpZhZyeQFk/Am6eNFjJrhZVFPghAhVZqxesA9GO9dXX2B96s1cKr+MGRGHfkH1Z9Icjf
         ROncXhBkyBqx4qomAg/QiguxF6xslakryjPO8aW65s6cOdqDkXbfz0IVBQzWZmhGb/fA
         6CGMrHCPqfbDMLxEizBEpDXA4blgpuKE0VtT6CeAfJMvupx457bXmfeQVOgN1RSPl3hG
         Slig==
X-Gm-Message-State: APjAAAUwLehx/Dn4CGLrBEHTzrJqRPGPriQd5p+bY8951nm+r1fbE/LK
        nf2Q+nbnmj5IaCqSksF2vM7p5SXA2XMhLxCcGPgXyA==
X-Google-Smtp-Source: APXvYqxkgk8vOif4+8dDVnGLiySdf3fh7WZMI0FF72SbNFcx1ZGNeTcmlZ2ofHtixjJ67n/0RGa9si6mjZLNF9PFjkQ=
X-Received: by 2002:a63:6193:: with SMTP id v141mr24350262pgb.263.1568063673765;
 Mon, 09 Sep 2019 14:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190909195024.3268499-1-arnd@arndb.de> <20190909195513.GA94662@archlinux-threadripper>
In-Reply-To: <20190909195513.GA94662@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Sep 2019 14:14:23 -0700
Message-ID: <CAKwvOdn5pR_j=NEUtrVSS_uZYtdwVuPAAd6CqF1BOL8akSFhcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mlx5: steering: use correct enum type
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 12:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Sep 09, 2019 at 09:50:08PM +0200, Arnd Bergmann wrote:
> > The newly added code triggers a harmless warning with
> > clang:
> >
> > drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1080:9: error: implicit conversion from enumeration type 'enum mlx5_reformat_ctx_type' to different enumeration type 'enum mlx5dr_action_type' [-Werror,-Wenum-conversion]
> >                         rt = MLX5_REFORMAT_TYPE_L2_TO_L2_TUNNEL;
> >                            ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1084:51: error: implicit conversion from enumeration type 'enum mlx5dr_action_type' to different enumeration type 'enum mlx5_reformat_ctx_type' [-Werror,-Wenum-conversion]
> >                 ret = mlx5dr_cmd_create_reformat_ctx(dmn->mdev, rt, data_sz, data,
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            ^~
> >
> > Change it to use mlx5_reformat_ctx_type instead of mlx5dr_action_type.
> >
> > Fixes: 9db810ed2d37 ("net/mlx5: DR, Expose steering action functionality")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I sent the same fix a couple of days ago:
>
> https://lore.kernel.org/netdev/20190905014733.17564-1-natechancellor@gmail.com/
>
> I don't care which patch goes in since they are the same thing so:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

GCC recently gained support (via me scanning the commit logs for an
unrelated feature) for -Wenum-warnings (though I think it's off by
default) so hopefully these kinds of issues will taper off over time.
-- 
Thanks,
~Nick Desaulniers
