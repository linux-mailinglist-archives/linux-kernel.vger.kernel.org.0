Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29BB16366E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 23:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBRWtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 17:49:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43890 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgBRWtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:49:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so26696499edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6bGLfW+S3PbTSNe7BlkqXOXTsrm4VZ4lQdamKUPW64=;
        b=Ih8OVG9omwJ6Rxw+SlKjwczxNf0k2Ng94CvXCZbV3YDaX3UQbLCeVFJCDBgE+/TbWa
         949c1MNdpMLpcyDXtROzVlkZqcqThZvj3dhD1ALAKRu2iuAubkhK1t55o+Mi/JGULJQA
         Do0mKi+fIwpeSajmK6ZtYgsGWtcp2ixmaSSIN7Z+3VM59asG03lUut8OZYU+OftobKN/
         FARxahH/c9osR5/SjqCdrfiIcl3zufcnKdJwz8aagy+PHbiKJZq82UM0DiByhRA429++
         amw4egh1MaKmoNsfmmEllJZPFRXMrhRAJ3PBPBSRTfXKHz76UknYvpsHjXKYCfr9H+iG
         sLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6bGLfW+S3PbTSNe7BlkqXOXTsrm4VZ4lQdamKUPW64=;
        b=sAH72xVubfAM7RJ5Wi+VDPnTuuIjN0Pw30DAOu2fDU3HUb/fHOBrGwp42xwMb0Ek0h
         4jzOsL7r6aQGw9QVYKrMmG4P6slOBoOYNHVvnBlDjpvIks6Bdud9QaGeEY5J57sAmPLM
         HRxJbtvD0RQmZQQi8MALljK/fQCjM3vtHit3L7s3kJSrfTvu/f0vccqmoGXl+Eq88i8B
         nSAI/gBtM09Tdz9U+HmtzJtj1eYrrCTQ9ItLhan1tV4dNdTGAwsnUlqe8e29wJW+7Ug/
         H9zVbDzb8MRnVnX75SZYjhVnP1vgoes4mudPqGsSDQPivNWoLmBLAaFvTKWgiAwo0Xtj
         FZCw==
X-Gm-Message-State: APjAAAXu399YH7cIpCinVNImsbTVovBiMCyZ6D+4lU4HmbiIJoxzYCgD
        bH33H1Ha1JIYkUourvf3ByvIgLbkHkqhXd4snHFVwty7dA==
X-Google-Smtp-Source: APXvYqyL9+hoGiE8tChYcCVk+t7iqdIxiz2N27oHXffytLSJrvsGhrrkoMyf4wu5HG59PmlYeN3uSH1WjtWg9WFGERg=
X-Received: by 2002:a17:906:f251:: with SMTP id gy17mr21225090ejb.308.1582066147205;
 Tue, 18 Feb 2020 14:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20200218181718.7258-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200218181718.7258-1-madhuparnabhowmik10@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Feb 2020 17:48:56 -0500
Message-ID: <CAHC9VhSzqccDgt2EAPqVmTFCcETrKrkUDRoL-2YzzSFGfYJGQg@mail.gmail.com>
Subject: Re: [PATCH] net: netlabel: Use built-in RCU list checking
To:     madhuparnabhowmik10@gmail.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 1:17 PM <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> list_for_each_entry_rcu() has built-in RCU and lock checking.
>
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
> by default.
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  net/netlabel/netlabel_unlabeled.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Not that this has much bearing since it's already been merged, but for
what it's worth ...

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..77bb1bb22c3b 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -207,7 +207,8 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>
>         bkt = netlbl_unlhsh_hash(ifindex);
>         bkt_list = &netlbl_unlhsh_rcu_deref(netlbl_unlhsh)->tbl[bkt];
> -       list_for_each_entry_rcu(iter, bkt_list, list)
> +       list_for_each_entry_rcu(iter, bkt_list, list,
> +                               lockdep_is_held(&netlbl_unlhsh_lock))
>                 if (iter->valid && iter->ifindex == ifindex)
>                         return iter;
>
> --
> 2.17.1

-- 
paul moore
www.paul-moore.com
