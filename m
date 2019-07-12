Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5575662EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 02:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfGLAd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 20:33:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55832 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfGLAd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:33:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so7249278wmj.5;
        Thu, 11 Jul 2019 17:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIHtnUgbJAyk2Yt1SLus4FpvUvi7MmMfRwmrG6+39M8=;
        b=seQ+5x66XzW00Nii89UijNC7Z9v06mETi3In1Gs/azkO/cFi/A1CzoHdr2kjDGfPVv
         aJlHM+yNvSjw5TJjfOOjR7evoxrdJCSDjoQJQdQYJcQX3anKGkvoD4/sOoa8nTzOWy8D
         1A7LFikVyd4Ay01meCwi9cXe/KfsDcwTCTbZVI4CZ9MJ7njAYVzfe4Y9fzZVVw0mA/9J
         9WT3KPgngZ8LmbqEjQdspnGpeunujI5LLoR9HXTJP2/TumISn0MVPjYSchynH7MRHGCW
         H1N2JxQy26esHj7XHDPlGVgwkX/rcwUka5x7DbkLriaV2UPsqcrKiinzkPckv66lx8TQ
         Epug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIHtnUgbJAyk2Yt1SLus4FpvUvi7MmMfRwmrG6+39M8=;
        b=hgGDRmWekzujBc+xUrqNYE2udUsS98P2pEgmqSoKqaWOpS3i9LtWNIZZzTG9PyTj+V
         d0JRVZ2wW0/F7uM/90bKIzfd0esV9JsUnYF1fEuNXSMjn5OvSGnjKxyABbASVyhFO6v8
         joE+H6xRNxjL9zP5JeX8ABWTRsUQJdoy++GiGQic9N0gKA+gteU6EKqI0akCSQA8TFOD
         ejDSK/4FtAzqIhW+Id4XnduH6p6lTOk2+M63mBaWwRplfFLNnRNfiQNtEUHwdYwpSXYI
         1hrSa5QBluMPtgW/h0m7C5zdr5+29fRYn8SfPHHvepl/EO8qvHxlim7A3daaKhvtJMes
         krcw==
X-Gm-Message-State: APjAAAWcYjnuDVfao+RgO2xwo3DGT3dWtzEUjdO/vuXkhBeOMBZcch7e
        zbZ2AevFk74Csw+xkc5cwmVSgk8k9CI/yp+wEPg=
X-Google-Smtp-Source: APXvYqyaiGP9Do3Q1rjeo5x031nejhl4minL8MqBQLzYhAI2+hdialZRcypuUt8ZXf9soz2tQX++PZiX2Pw5AGx/y3M=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr5797761wme.173.1562891635861;
 Thu, 11 Jul 2019 17:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 12 Jul 2019 08:33:43 +0800
Message-ID: <CACVXFVNkdgxddQiJn1SMQSuOL8E_PCLRhkv8XPLUg=5tdmpiLA@mail.gmail.com>
Subject: Re: [PATCH v2] block/bio-integrity: fix a memory leak bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 3:29 AM Wenwen Wang <wang6495@umn.edu> wrote:
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
>  block/bio-integrity.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 4db6208..fb95dbb 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -276,8 +276,12 @@ bool bio_integrity_prep(struct bio *bio)
>                 ret = bio_integrity_add_page(bio, virt_to_page(buf),
>                                              bytes, offset);
>
> -               if (ret == 0)
> -                       return false;
> +               if (ret == 0) {
> +                       printk(KERN_ERR "could not attach integrity payload\n");
> +                       kfree(buf);
> +                       status = BLK_STS_RESOURCE;
> +                       goto err_end_io;
> +               }
>
>                 if (ret < bytes)
>                         break;

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
