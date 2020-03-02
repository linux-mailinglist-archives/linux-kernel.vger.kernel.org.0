Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50775175652
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 09:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 03:54:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32835 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:54:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id x7so11470546wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcY8uAoMmF9oPjf8la7A7KSa8FWV9Bilp23gxzOHZ7Q=;
        b=euznFhb2tLlnOqb+aC0lZTtc9IPKZksse6Gbmtw087QomR/zYNeNblnIluE34zduLr
         P2UinbWk73yfsT8akFxz69iEwmeWsgPAA2CU73cYcoNFAuNvGnPN4umo/lT11wWhrWZr
         L6snZxyl2CFOIlocJ3+i5emtR3TM0KJ6N1ts0RHWym41oOseWxhJhV/+3VVuPFkkCKkV
         yhfhTE2ro4IqNeyaS5Vwne9gCi1L9JKfpHxUSXuOXcW45eJc2zqxNAL9QyW+dGTbT342
         qZm1tJIhhpD0xEKAIhRu0O0ihw3YaBB/C5WL4h3Jq9swgLLk+9djyfQylssTfMyjEwEL
         UQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcY8uAoMmF9oPjf8la7A7KSa8FWV9Bilp23gxzOHZ7Q=;
        b=AtDrPz4zBDEUyXcim7RxFShq3D7e5Tpf6uIv/oW38hfLIvLMkVBNcgUCz3Q6b2I8un
         zTtTXnYdLhFwZH4h6iLMRC0Tngl731LnOSMwv5zHtfc8JPlhL3bvWIyuYvGyi/qH6Fdn
         ngZYe7LBLdD2jeuiynTctZbQrlR8YIQU0l0Rxhx0zcBEfncLvMlq/t187zifnBMApT+i
         ZjUu/i+MW3cGNifF0HzwMl1KQEu+CDQ8wae6FHJI4jj8pXVUW9g9Xf4fWSEBpls2QdQ9
         cEu33jeyGwxcrgezfiqGz5V7xffB2mfKgfFkzgYrsiPwTHZgX0kiFKqNKql6UVJKYaHV
         sCRw==
X-Gm-Message-State: APjAAAX9wHMBRCNXAq1Efe0XI3Xxx1GcdnUvefTHZfAvnWGw9oqYOB9D
        QKKdzMt8QappyjynwqkNdmYwUUUpZ2tv3YNv5B8=
X-Google-Smtp-Source: APXvYqyH9uPrYTI9EcU6q0qWpH1FPeqFwmIpaXV4DbdNPahu6bc5sTQrWiQ9qrudrCDWDmR/HxP4TIPdilN/Oaa+jvQ=
X-Received: by 2002:adf:f604:: with SMTP id t4mr21632196wrp.96.1583139278737;
 Mon, 02 Mar 2020 00:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20200301152832.24595-1-mateusznosek0@gmail.com>
In-Reply-To: <20200301152832.24595-1-mateusznosek0@gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 2 Mar 2020 09:54:27 +0100
Message-ID: <CAM9Jb+g-LR+XRE5sGwM9VTT13jwzyvwWTqDbeZEmPCJv2aY-2w@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem.c: Clean code by removing unnecessary assignment
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, hughd@google.com,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mateusz Nosek <mateusznosek0@gmail.com>
>
> Previously 0 was assigned to variable 'error'
> but the variable was never read before reassignemnt later.
> So the assignment can be removed.
>
> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  mm/shmem.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 31b4bcc95f17..84eb14f5509c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3116,12 +3116,9 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
>
>         error = security_inode_init_security(inode, dir, &dentry->d_name,
>                                              shmem_initxattrs, NULL);
> -       if (error) {
> -               if (error != -EOPNOTSUPP) {
> -                       iput(inode);
> -                       return error;
> -               }
> -               error = 0;
> +       if (error && error != -EOPNOTSUPP) {
> +               iput(inode);
> +               return error;
>         }
>
>         inode->i_size = len-1;
> --
> 2.17.1

Acked-by : Pankaj Gupta <pankaj.gupta.linux@gmail.com>

>
>
