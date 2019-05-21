Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2324E69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfEUL6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 07:58:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45796 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:58:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so20029749qtc.12;
        Tue, 21 May 2019 04:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG1Hs0ESwnRVet51hMjdxLPwpJh7ZatYL2HtJdlc+r8=;
        b=IMwxDwwr2miOaP1CeewH6LpikLF1W5Xo9zhcT3+12zTeekbq9Ls0RGDD2/rzCFOIUc
         IGGCDAZHXl1CU2Uka/WADFOZdLVOwDoBwjJ74/MhoiQpnlLS/rsk3A8GG4EWxdk7VJ0l
         6WBPBgHydRAZ9HB16bk7HFFIgiP/Ok01Zyd+S3rhnGIMlZV4vBVQoJMrPrAobUqU5CWO
         JsZyVFwREkQ9AkYtyxn8ErnYR7ol1J6DYWYs1jax+GeUa78iuWBFSOdy6TRjRdCfJLHJ
         XVLVlOe2ozuSwGwhIUUpXJdUAW8+6JNkyRcivALBWSOYnAJ3ocipu5PrsoS09Y6t9GYf
         TP2w==
X-Gm-Message-State: APjAAAVwMKC/3T5p7qKK1YDvqqvDSoQt8humGyXucyK0QZAnBBXqjkDa
        3dfHe5WHTrKOuz1lDFC3VbSjdbQYmeuC7/Vimh0nP9EJIvQ=
X-Google-Smtp-Source: APXvYqypDXVBS4ifbaE5zemqBahreul8x/ODVifparRdwfQ7naR5cZfsaWocJlLatNxgSqyZ9gsjCSMSIipNIKjRplI=
X-Received: by 2002:a0c:9e55:: with SMTP id z21mr65483709qve.45.1558439930891;
 Tue, 21 May 2019 04:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com> <1558383565-11821-6-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1558383565-11821-6-git-send-email-eajames@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 May 2019 13:58:34 +0200
Message-ID: <CAK8P3a0W=kUxTU7M5diSL3pcFQydXbB0ABwqj6NUhKj2hQC_wg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drivers/soc: xdma: Add debugfs entries
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:19 PM Eddie James <eajames@linux.ibm.com> wrote:

>  struct aspeed_xdma_client {
> @@ -656,6 +662,92 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>         return 0;
>  }
>
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static ssize_t aspeed_xdma_debugfs_vga_read(struct file *file,
> +                                           char __user *buf, size_t len,
> +                                           loff_t *offset)
> +{
> +       int rc;


I think it would be more readable to move the IS_ENABLED()
check into the function and do

         if (!IS_ENABLED(CONFIG_DEBUG_FS))
                  return;

in the init_debugfs() function.

> +       struct inode *inode = file_inode(file);
> +       struct aspeed_xdma *ctx = inode->i_private;
> +       void __iomem *vga = ioremap(ctx->vga_phys, ctx->vga_size);
> +       loff_t offs = *offset;
> +       void *tmp;
> +
> +       if (!vga)
> +               return -ENOMEM;
> +
> +       if (len + offs > ctx->vga_size) {
> +               iounmap(vga);
> +               return -EINVAL;
> +       }

The usual read() behavior is to use truncate the
read at the maximum size, rather than return an
error for an access beyond the end of file.

> +
> +       tmp = kzalloc(len, GFP_KERNEL);
> +       if (!tmp) {
> +               iounmap(vga);
> +               return -ENOMEM;
> +       }

Use 'goto out;' to consolidate the unmap/free here?

> +static void aspeed_xdma_init_debugfs(struct aspeed_xdma *ctx)
> +{
> +       ctx->debugfs_dir = debugfs_create_dir(DEVICE_NAME, NULL);
> +       if (IS_ERR_OR_NULL(ctx->debugfs_dir)) {

debugfs_create_dir() never returns NULL.

Usually if you have to use IS_ERR_OR_NULL() in your code, that
is a bug, or a very badly defined interface.

      Arnd
