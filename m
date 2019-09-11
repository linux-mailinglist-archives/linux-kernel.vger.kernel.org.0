Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC85AFEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 16:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfIKOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 10:21:54 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42349 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIKOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:21:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id m22so13817987vsl.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LcH4mrEpWIl63AIHI/pwRNdziNLwRjJrkFFY14YbeE=;
        b=zo8DYVWgeCK/iLPF2aX29aG9tzw8iZslqJ6oYMTejjzaf4nQ2JDyVZhC+9uE9la4S/
         cRrMJYxaM4X7ZJRYrkEkQgnTz/XJ37/6VXvSRGlhNX992myto9o+0i4dYfmj0+Sh0UMm
         f9EXj3jIRavtrwbif0I0o2PJ3D6AY2BMQSw3tzuvSPoow8/CyGVBazCLyT114QMTaIkz
         /Issinhqo36IzD/A8M5W//FhM+UOZ92qNdREJR874qO3ED8yLqHSc7TlM5IuLeuxnlkx
         kfzeTTPqbtA2MtTCudmNA0Pak0yh3LztLn8IFgsURwF+5jQDqlsnBpnkRUP0VIJBgAy9
         WmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LcH4mrEpWIl63AIHI/pwRNdziNLwRjJrkFFY14YbeE=;
        b=BWws5B8nlKd8mQ3y7n6w4nfGIHBTw+lt+Dug8vXLRnEIPVJzAom5GTG6uyoKqO14HH
         6bir3rrhIpoe/vldCqRtFEqLjsBzdjCW7LSB7cV+kj8jEMrORnFpjUSWRtHAvIlsQG2l
         YKJ7hHC9LUWN6UN0HTMsOful0i0mkgWymJ7+wRrE7xv2nGSptjIlpGcIZymcpSTXsigG
         DPkUzsZwPtx3EGXXh/6O+Cp+phQmmS/NFV5Hkk9+j5U3d8YsLBMt2qKRf0TbbgizhVRS
         4aRo1D48yrBB/RepWg2hdJq+oWMwDEBmlTB1duIfZ4KB8x93pUlg+wPTCWsVbx7CS1RW
         H+iQ==
X-Gm-Message-State: APjAAAVRXkaGSs0nbj6s8EfRpR5C2reUyoePcFuDuzF86ckJf5WUaRhv
        0FvUmfnUOGdC2EM+ViHyqOR5oAcGl3XcJLAY60P1VQ==
X-Google-Smtp-Source: APXvYqwiZkdeK7FWgsnjGW9l7hY2CMI/Bo9ZfSKRAEanLN6oP51gZK/FoIoE47h2B6/zX+wKzvi3OXj3omxdGL9DjwQ=
X-Received: by 2002:a67:eb51:: with SMTP id x17mr10765838vso.34.1568211711983;
 Wed, 11 Sep 2019 07:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190911103357.1744-1-colin.king@canonical.com>
In-Reply-To: <20190911103357.1744-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 16:21:16 +0200
Message-ID: <CAPDyKFrLOEQkv4SrBfYQo=EPRgcFs7XH3ez22ZyDerMqGDiZFw@mail.gmail.com>
Subject: Re: [PATCH] ms_block: fix spelling mistake "randomally" -> "randomly"
To:     Colin King <colin.king@canonical.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 12:33, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dbg_verbose message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 384927ebde74..d9ee8e3dc72d 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1087,7 +1087,7 @@ static u16 msb_get_free_block(struct msb_data *msb, int zone)
>
>         pos %= msb->free_block_count[zone];
>
> -       dbg_verbose("have %d choices for a free block, selected randomally: %d",
> +       dbg_verbose("have %d choices for a free block, selected randomly: %d",
>                 msb->free_block_count[zone], pos);
>
>         pba = find_next_zero_bit(msb->used_blocks_bitmap,
> --
> 2.20.1
>
