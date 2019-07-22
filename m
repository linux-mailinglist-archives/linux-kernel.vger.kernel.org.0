Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C09709F6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfGVTnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 15:43:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43499 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfGVTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:43:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so14181406ljk.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDcZGwhuKZu3iHdLJjjZrDjT2mDiJYa3/PCuflSwhmE=;
        b=JH+WTPvGR1uJXOfkLig+2OnrW2RKgN80CBOlHfHzmzd4O+bmVrzCRVv79MtxWactpN
         5AQJgh8/hKUCP0JLKzw9h/Ia3Zucxwt24sq0z1NWzgC9D7F9JM39IuPnlfeD8HuVZjgZ
         df1gbXNdbJqX60F6+Y/PKNW/1fE0l4GJwD+5qqqbYRcIBhraAj8DB6QvLVW+D4BcwoSy
         XbY47a81+I07ouFEfhrSnksjfYHY98ImOhSJYDBYtWMQ1Mjelr3fU9T1Oy9gC9xOVFkv
         9z7hQlZHI374PYI2T6OQwIYP1EKvSEMpTqTekwepqb6IjDkwfgi3/YVva8PPoL2m8Qmh
         Yl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDcZGwhuKZu3iHdLJjjZrDjT2mDiJYa3/PCuflSwhmE=;
        b=sblPfUvAa/MT6jMvR7WUZNV4axxyXbS5ggkxOKloJ7LuKt08FZMsY3tyTMV55ms1IH
         y4SDonN3j1iVE+ib4dC+uYKKX2gfkGXW0WCjc9+akLrQA7JvgY7xXzexx6dazb9MhfEm
         Wft6r7Yi7146TS9ZIm0LZSEsfV1VGIPcBSyr5fBaxvYNWM3fS/v9EqNbLuv9jbt+KGJ/
         jNFggXbYVrKr1r3LTgPE9yCsJM7Mv08Fb3uBSA+UlHrdX/7nwB25/vdVLvAScI/LjBzC
         /39Hn/iP7LeWviu1uctB05KNpc0Fy9hewp/5SpHthRjKvwKUOVslFa7LEaWHAtUHeWoi
         ylEA==
X-Gm-Message-State: APjAAAXhLlQHGuKmTWzF8u2B230lkRYfKYouICi+FPXnsCU3u5B0KyNF
        p//lQn+G7CWFOE6Ygsi1BnA7tcuLeWfhy8vbQTs=
X-Google-Smtp-Source: APXvYqxYj26MsmsL+EUr6K7HJeh4VOAk6pAdE7CkRMdt0FiDft3k4b/ODkmGcqVb0AGyHNqMuSc+O0XivAmJeX8kyWM=
X-Received: by 2002:a2e:3604:: with SMTP id d4mr36892450lja.85.1563824585693;
 Mon, 22 Jul 2019 12:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <1563820482-10302-1-git-send-email-cai@lca.pw> <20190722.120901.1770656295609872438.davem@davemloft.net>
In-Reply-To: <20190722.120901.1770656295609872438.davem@davemloft.net>
From:   Saeed Mahameed <saeedm@dev.mellanox.co.il>
Date:   Mon, 22 Jul 2019 12:42:54 -0700
Message-ID: <CALzJLG81NvsSbv7Qv11QnX3pvogeSmO-vsn1uYP13p5T14irig@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: fix -Wtype-limits compilation warnings
To:     David Miller <davem@davemloft.net>
Cc:     Qian Cai <cai@lca.pw>, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:09 PM David Miller <davem@davemloft.net> wrote:
>
> From: Qian Cai <cai@lca.pw>
> Date: Mon, 22 Jul 2019 14:34:42 -0400
>
> > The commit b9a7ba556207 ("net/mlx5: Use event mask based on device
> > capabilities") introduced a few compilation warnings due to it bumps
> > MLX5_EVENT_TYPE_MAX from 0x27 to 0x100 which is always greater than
> > an "struct {mlx5_eqe|mlx5_nb}.type" that is an "u8".
> >
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function
> > 'mlx5_eq_notifier_register':
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c:948:21: warning: comparison
> > is always false due to limited range of data type [-Wtype-limits]
> >   if (nb->event_type >= MLX5_EVENT_TYPE_MAX)
> >                      ^~
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c: In function
> > 'mlx5_eq_notifier_unregister':
> > drivers/net/ethernet/mellanox/mlx5/core/eq.c:959:21: warning: comparison
> > is always false due to limited range of data type [-Wtype-limits]
> >   if (nb->event_type >= MLX5_EVENT_TYPE_MAX)
> >
> > Fix them by removing unnecessary checkings.
> >
> > Fixes: b9a7ba556207 ("net/mlx5: Use event mask based on device capabilities")
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Saeed, I am assuming that you will take this.

Yes, will take it.
The patch LGTM, though not applying it yet so others get the chance to
review it.
will apply it in a couple of days.

Thanks,
Saeed.
