Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480F6653AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfGKJWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 05:22:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGKJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:22:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8so1358838wrj.9;
        Thu, 11 Jul 2019 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlwYflAq0smJi21KRy7k4mCMg2ux1t1pjB1v5UR/AcA=;
        b=ZMUfbc+lo/eM2LuIizHmmX3xB85uswxxsVQh/1jdqeXN1oEi1wVOI6kZ1IKFV1kxaN
         R8LXYQRJ6LG7okRNM9IeK4wPsGza3MX9GtnXM1pYk6qhEwGpRs/1kZkPev8fxIbfW1/3
         Tn2/mcAJZVq1G46LxhKiOfcD6bCEES2tRTWcdi4sYkvsJZQ4VkR+5n69Fw2LfUukh6XC
         SbdxahGhEajGb5/QPy2Cp5dVNnUuLbFsZxkLZIIGPxv5rvYlwovBHo++b//XGGcjLGmN
         zZaLfD/e+lmTmCZG8q4E6jlE1n04G253PSy+Wf3cr96vAi1DNF49SIAk3NRpalIZo2fb
         c6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlwYflAq0smJi21KRy7k4mCMg2ux1t1pjB1v5UR/AcA=;
        b=Q3u3gctdLiVIOuZe6YsQ+we2PyRq7MSg9nfEENfxZl+YUGBvCELETJmVpcUcUowwn2
         d9mO7sONjxRZxr6iN5wPrV6ZR8XTqkQhmMfaYW8mKG5UVpichX7sP4ZHinocoM8VusUx
         G+Smhf8lhTl5SQ/vOk9p6KxieE0hmBD9/2BuQcbVCBJjUc63TH7i6ZTXDkPyHERF7DrQ
         5tpsMTQNYo5Ek/s4cLqeNO/V/fhpnICFxo2UhE/KAl5desYJCm3BIEc9CMkvJRtkDv9Q
         UGTIAfm54YwUj/CHEKBbKs/PcshGLzxjJWEwJfCsGgY8jEtxaql4dKucsbtXYJ2EMeou
         17Xw==
X-Gm-Message-State: APjAAAVZJwZoBt9BumdMtBpvmoAgjfOgGFG6op6F2nJn8dL09WNZtuU7
        lfol1CAf/N09XsxpCGMvpLJgCuo0qnSgSHSiuE0=
X-Google-Smtp-Source: APXvYqwgHRM4EU5lxrlGRWVq+LF0HyGIoXyg9CVgIpOLVtJNBQrCJSBSq85hAvQ02NGS+ov0N3npjfAmTim3vtVhWsg=
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr3714252wrm.315.1562836926040;
 Thu, 11 Jul 2019 02:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1562830033-24239-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1562830033-24239-1-git-send-email-wang6495@umn.edu>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 11 Jul 2019 17:21:54 +0800
Message-ID: <CACVXFVO-gwVhZRajRx41_sYJKDTX2qZUnZVRXCB0NcegVVTGVw@mail.gmail.com>
Subject: Re: [PATCH] block/bio-integrity: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 3:36 PM Wenwen Wang <wang6495@umn.edu> wrote:
>
> From: Wenwen Wang <wenwen@cs.uga.edu>
>
> In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
> hold integrity metadata. Later on, the buffer will be attached to the bio
> structure through bio_integrity_add_page(), which returns the number of
> bytes of integrity metadata attached. Due to unexpected situations,
> bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
> needs to be terminated with 'false' returned to indicate this error.
> However, the allocated kernel buffer is not freed on this execution path,
> leading to a memory leak.
>
> To fix this issue, free the allocated buffer before returning from
> bio_integrity_prep().
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  block/bio-integrity.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 4db6208..bfae10c 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -276,8 +276,10 @@ bool bio_integrity_prep(struct bio *bio)
>                 ret = bio_integrity_add_page(bio, virt_to_page(buf),
>                                              bytes, offset);
>
> -               if (ret == 0)
> +               if (ret == 0) {
> +                       kfree(buf);
>                         return false;
> +               }

This way may not be enough, and the bio payload needs to be freed.

And you may refer to the error handling for 'IS_ERR(bip)', and bio->bi_status
needs to be set, and bio_endio() needs to be called too.


Thanks,
Ming Lei
