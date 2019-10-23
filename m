Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A02E1AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbfJWMkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 08:40:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40116 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:40:36 -0400
Received: by mail-vk1-f194.google.com with SMTP id c10so275521vkm.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td+5v62luaK17DIKgu/9K0KKwUeMkYA5SFVZr/oyThI=;
        b=yXA4ZIexYjDv6xjTogTSzL8qNIBnICOTejFxIsogplkGY9rZZvlKxfrQ1tvWD09wAH
         zK2fdhfb49NQoXmU/h8XnJpCgMBUXBjMJEvV+vO/9dZN1H9dkB4jiOEt07JTilW1f1Mx
         S08afyvRCC9QHTSKc/VUC1CSktyW+k6JdBG89PjfGips8PwWkcOndXlq5V33J3shwcyB
         LlkTk138Vl3tPSAtrv/wawbqbF4Szj4thndqDvbfx5lsFofsRx+70QGGLqbcbBMCU/V4
         nFk3esz9zSvRkQNI4VgPcvnumXSjsjXRB8Xb6d16tnFudr+OhKLHGlzul54qt0NMKH/g
         IDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td+5v62luaK17DIKgu/9K0KKwUeMkYA5SFVZr/oyThI=;
        b=p2Re5zQ5P54NopKT+1eNZR5iOr764OxXPbhxoN/yNJ34Ap4EHvosc431V+dtynsx8o
         HvpY3VJoLjKacVNHFwDC9qEzNC2JbEfKJYMNuveOcrOC+ebFd0XO0qm/BrgcIVX3Snsh
         h23lboM0MGFvz2FE3rwqsIwc2Hz1Ie+SD0Fmth2ncwWfAxhV+7DVp75dkuIFQn8jFRPd
         1Pvhkt2+WxqxriShMkmlk9sLZHcoPGv5teZetGeKKgsO6zaX8B4D9/oDv2suKr1xWHjR
         T1ZwaOKixrGzUryraRLi2GyPFrh358wx4BkMAU1B4Wtd/X/n0uHgULnWIrGyouhaRT43
         qG2g==
X-Gm-Message-State: APjAAAXN9U+PDYqVhakafWJ/w23j6E7NUR5hssebQ7j+wxrXRZvAxhnT
        yP1sDPNZjoFY1AmSC8Kihr/trHa/NvL18EQYpx99bg==
X-Google-Smtp-Source: APXvYqyUEbyxZWyaXWyV5JPcNuCh0d7/ckbTtrpa/6d+Zxyq4SYJk8fsTgLhUdZwfCES2l0zOc254VMD7BJwF8ToAv8=
X-Received: by 2002:a1f:ae0a:: with SMTP id x10mr5154470vke.25.1571834435305;
 Wed, 23 Oct 2019 05:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20191022130036.23877-1-sudipm.mukherjee@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Oct 2019 14:39:57 +0200
Message-ID: <CAPDyKFq7_Obp2Qc2iZDC4wCokMt9-ttuZ0A8A1CYR+b4=JbqOw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: remove unused variable
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 at 15:00, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> The use of 'status' was removed but the variable itself was not
> removed and thus adding a build warning.
>
> Fixes: 05224f7e4975 ("mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response")
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

This has already been taken care of, by amending the original patch.
Thanks anyway!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ee1fd7df4ec8..95b41c0891d0 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -497,7 +497,6 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>         struct scatterlist sg;
>         int err;
>         unsigned int target_part;
> -       u32 status = 0;
>
>         if (!card || !md || !idata)
>                 return -EINVAL;
> --
> 2.11.0
>
