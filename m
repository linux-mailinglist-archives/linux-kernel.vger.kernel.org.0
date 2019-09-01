Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DECA4A60
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfIAQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 12:04:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43615 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbfIAQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 12:04:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id h15so10652438ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh7hz3NgC+Jv820T/3FkhJrD5Mam3iRkCjzClMx/PpU=;
        b=n1wV2hfIWvMuv5eadiuhyFNOVuX4UKEqE+vChB8pt8lNZQ1ytAPrCO7bUOER5D6OrB
         bDtxOc47O7FwzGjbfgCKkMVJXM54JS/gbCssoxyNGkxsFVJPAeDcrzUeJH9AWMUbO9dm
         grI0uDkzoYYDIqH7vVCoIjmty6qTWkZIXxTLu6VxWko7Q+NO5qXLiKMYOIh7jMWRCkyj
         ed9/Ekdo6rwy6T8bJg9Lh5kKYKd2GSOd62Qi8pkJG2ZhHEAM1govI6Y8nB8k401rw4dt
         SrhrZNenzTSZ177rdcQ+m+9MjahaMgFzCBxNJLB0annCtvOpsy7WDjiACTUvxcROCXkg
         XRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh7hz3NgC+Jv820T/3FkhJrD5Mam3iRkCjzClMx/PpU=;
        b=PhKxktHzwEyn/zj6ZVT5MDzqtPqOahrbZdUHs3WVAU7ynIKyUPaFJlk8rJoDEiFQAb
         qLVX75CPyNWHKBR+2caVdPFPyEZQ6Y4vz7BJ5Qt0vf/F63eRQbdo18wAqSObokMzOCP1
         MQrCanYXNHxL9UzoByuSIYJH+eRmfZOpa1fxiajklpNT+hE5jcd6UDQBncVCWYVPYtT4
         SXQPKrhiRK96ZY2bN6bkLqu3pp5BASJUAc+BPa0yU5vImpbO0Oriw7tIYkWUO52gQMUu
         biwpWgS35Aizbh7AkupfQ7J6OmwIjDrudkErBin+tPSkKbrTIBMHWLOSEA7GPjolt7NW
         J2gw==
X-Gm-Message-State: APjAAAUg103AI0YNJa1622R+FeFwtVTmU4UomvqKxSWOFAxOhd7vKoVn
        aJIKm+3vwtpeGOQ+EUXk6zDg542c2uePDTvMt8XL
X-Google-Smtp-Source: APXvYqw/P92GX1SczFXfGPwLbUlbd1ji9qx65S/Qs3ZAKZYgZcSVD6Wya/9K+kkN3lM/ZA+i2FWNVcLd8GTgVLzLp6Y=
X-Received: by 2002:a2e:84c5:: with SMTP id q5mr13932977ljh.158.1567353875226;
 Sun, 01 Sep 2019 09:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190901155205.16877-1-colin.king@canonical.com>
In-Reply-To: <20190901155205.16877-1-colin.king@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 1 Sep 2019 12:04:24 -0400
Message-ID: <CAHC9VhSVKEJ-EBAry5fVN3Ux22occGQ5jxbFBecMsR+q7+UT5A@mail.gmail.com>
Subject: Re: [PATCH] netlabel: remove redundant assignment to pointer iter
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 1, 2019 at 11:52 AM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer iter is being initialized with a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/netlabel/netlabel_kapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch doesn't seem correct to me, at least not in current form.
At the top of _netlbl_catmap_getnode() is a check to see if iter is
NULL (as well as a few other checks on iter after that); this patch
would break that code.

Perhaps we can get rid of the iter/catmap assignment when we define
iter, but I don't think this patch is the right way to do it.

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 2b0ef55cf89e..409a3ae47ce2 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -607,7 +607,7 @@ static struct netlbl_lsm_catmap *_netlbl_catmap_getnode(
>   */
>  int netlbl_catmap_walk(struct netlbl_lsm_catmap *catmap, u32 offset)
>  {
> -       struct netlbl_lsm_catmap *iter = catmap;
> +       struct netlbl_lsm_catmap *iter;
>         u32 idx;
>         u32 bit;
>         NETLBL_CATMAP_MAPTYPE bitmap;
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
