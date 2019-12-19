Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C390125E49
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 10:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSJyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 04:54:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34934 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLSJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:54:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id k4so2413134oik.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 01:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUKPu+3lzNZNRX0GPct7+0OF4dHxMBRWmyHMUXjgvFU=;
        b=dM9Dri73SBvMSb0MX1ghwOP6xNEYF5EtDsbBpOmR1Lva+bOM7B8n9PHhi/okQdn0OP
         +tAolcwYNoU3Mofv2EDgwS2h55JBQwctHSUCQ3WnL5FdDGauPJRFto0A3McVO7j3tuDq
         AohhVrGgpKe8/Wa8bnun2nN5nUX9m0zT2fmnq+HFnXxWInBYrwSO0Fc7g4CEZz7A5CNx
         8tq56bJwk0Bk7byPgvZaOKh4K2H1xJ34v9WFn8YcoZ5gMYZQgsW4pU3V8+gALe73Fvnb
         n4YsjOVvXoDeClqqlJfIjpXXcr8q/6un5thtHcN8Oix/YTM3+0UGQbVdXmC9ofJr2QNl
         YaTA==
X-Gm-Message-State: APjAAAXk/Py5QLyIYaKUBRcRcJeBvTgGTRMQmLbga3R+C1oB6IoUE30c
        A5EkxQDLgpUjc04jGDy8lPEhbQqBe/vc+3XenkA=
X-Google-Smtp-Source: APXvYqxGRCQ+HGG1eHMEhsUuHEO4jMulwydAvw7vvY4zmIqXYi1z525a9XEwSsmQKa80af+gnHaisBN2rlN7G8IGYk0=
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr1679787oic.131.1576749244150;
 Thu, 19 Dec 2019 01:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20191216062806.112361-1-yuchao0@huawei.com>
In-Reply-To: <20191216062806.112361-1-yuchao0@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Dec 2019 10:53:52 +0100
Message-ID: <CAMuHMdVvqccd_iwdz8khxYKUjrD-pnBYggagVCYZyNmbZxB9Tw@mail.gmail.com>
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 7:29 AM Chao Yu <yuchao0@huawei.com> wrote:
> This patch tries to support compression in f2fs.

> +static int f2fs_write_raw_pages(struct compress_ctx *cc,
> +                                       int *submitted,
> +                                       struct writeback_control *wbc,
> +                                       enum iostat_type io_type,
> +                                       bool compressed)
> +{
> +       int i, _submitted;
> +       int ret, err = 0;
> +
> +       for (i = 0; i < cc->cluster_size; i++) {
> +               if (!cc->rpages[i])
> +                       continue;
> +retry_write:
> +               BUG_ON(!PageLocked(cc->rpages[i]));
> +
> +               ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
> +                                               NULL, NULL, wbc, io_type);
> +               if (ret) {
> +                       if (ret == AOP_WRITEPAGE_ACTIVATE) {
> +                               unlock_page(cc->rpages[i]);
> +                               ret = 0;
> +                       } else if (ret == -EAGAIN) {
> +                               ret = 0;
> +                               cond_resched();
> +                               congestion_wait(BLK_RW_ASYNC, HZ/50);

On some platforms, HZ can be less than 50.
What happens if congestion_wait() is called with a zero timeout?

> +                               lock_page(cc->rpages[i]);
> +                               clear_page_dirty_for_io(cc->rpages[i]);
> +                               goto retry_write;
> +                       }
> +                       err = ret;
> +                       goto out_fail;
> +               }
> +
> +               *submitted += _submitted;
> +       }
> +       return 0;
> +
> +out_fail:
> +       /* TODO: revoke partially updated block addresses */
> +       BUG_ON(compressed);
> +
> +       for (++i; i < cc->cluster_size; i++) {
> +               if (!cc->rpages[i])
> +                       continue;
> +               redirty_page_for_writepage(wbc, cc->rpages[i]);
> +               unlock_page(cc->rpages[i]);
> +       }
> +       return err;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
