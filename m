Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7F105968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKUSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 13:20:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38380 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKUSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:20:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id z25so3810387oti.5;
        Thu, 21 Nov 2019 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCfUSv52eiUWMLPBJj0nq4OLtNTuDcv2jWsD2BjsB/0=;
        b=e0R5gisyJgyLCnlMyn3O5/sxcDF1Sl0W+m4dNeuZ+h5YPQLfRdcDhVg7HEIBOYw/Zh
         TurbJWrW98HX923BXWs7W+WFGC9OyKKVvUpb51OsadLDTTisPeiGHep1OrLJVz47b8XV
         YOQPqHWGIeniJX7Nw52xExwjcrw2xkJ89gWVewkNjTSDNcO8BlHfkO1pQZR2Lbv1PBFt
         p7EtCoAFrgrZTHq4HFH0YymK305y7G38XNuYMd37ePm70Fq8hbCKGL3uiMTXMuSGbg0c
         AU5p/n88MKFgIBIAyQqvxdCCdqu+CEh9ertuuyEVz9DoToS7mmTQqiv+1r0GALQGNGgi
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCfUSv52eiUWMLPBJj0nq4OLtNTuDcv2jWsD2BjsB/0=;
        b=oWuhMin8amA0o6CJVU3Lad1Raj/DYBVPttB+iAzCUj+BJrmyY4fVP0CuZOaV6IJRwa
         28H8kx4XmoGgecZsZBZyDZo2Ow42nAftpn0F+uSubO46+dcsSaZQPf+O5Iw5I2HuKHBf
         KG4uxEEEytFUP5N8jAYf/DBXVclTueRU4C5dHzaXNWACQ+VjlwBjFod55pTNCSe2zFRz
         2PLmYBHHzvEIhzvyG7Z3R67MH6m0a2qRSmixA+K5No5GBYTa1d7508xRPWrVvydAD6W1
         Z6IHlly6aPlb5XjMtIDm66uDyzDVVvkKbte+MD3GqK8NTKJjKQbEn6liwNPAmn7ZoErQ
         tPmQ==
X-Gm-Message-State: APjAAAWtSknnLV8NDWSasV/hMeYJJdKonhHBuQ670n6ZTrjhAE5bG+8U
        pATU4z9cGzOJKp909PWIUrrARotp9YsE4kbDJp0=
X-Google-Smtp-Source: APXvYqwwxt8Kw4oZIu6S9MIqgLS62/bLF1hm5c63BgX5cZ0Ls+JGbIgOWw5csfkjv7VRuwRR1m+IK8NbffniEhvZ+Z8=
X-Received: by 2002:a9d:37f6:: with SMTP id x109mr7562136otb.165.1574360429958;
 Thu, 21 Nov 2019 10:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20190917033124.1077-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190917033124.1077-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 12:20:19 -0600
Message-ID: <CAEkB2EQTO3wtCrZgLv068xGpxJYwir_SuMUBK0jGaTU6KdCRNg@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: char: release allocated memory
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:31 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In rpmsg_eptdev_write_iter, if copy_from_iter_full fails the allocated
> buffer needs to be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Would you please review this patch?

Thank you,

> ---
>  drivers/rpmsg/rpmsg_char.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index eea5ebbb5119..c655074c07c2 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -227,8 +227,10 @@ static ssize_t rpmsg_eptdev_write_iter(struct kiocb *iocb,
>         if (!kbuf)
>                 return -ENOMEM;
>
> -       if (!copy_from_iter_full(kbuf, len, from))
> -               return -EFAULT;
> +       if (!copy_from_iter_full(kbuf, len, from)) {
> +               ret = -EFAULT;
> +               goto free_kbuf;
> +       }
>
>         if (mutex_lock_interruptible(&eptdev->ept_lock)) {
>                 ret = -ERESTARTSYS;
> --
> 2.17.1
>


-- 
Navid.
