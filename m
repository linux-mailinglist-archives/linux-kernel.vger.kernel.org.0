Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322CF173DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1RFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 12:05:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37485 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1RFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:05:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so4132156ljm.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBP7QsMdsRzii497sQdvXMivqxHUi8KnMTi6DqPb4vI=;
        b=ac7tlk8Cze2jl3gZVHvkWEQ+IDeanfETwQry/6b+4HJyNtzQI4p6CcR3GQlgXi4t6x
         Rg9mhL4QPsYU2oVXZNwbLx51ZQjNza8AK3S/wS3bOTdoOjoXhdA+ou5H5ld+BAaa/g5h
         pK39NtvbrvXOQ9faTLoFO6V73vTxG7t4cRK1LuBmRNeOvROWzeg3piJtXOyRLqpsIjP5
         CSXHYLC82a3qe81vsAFGjbPYLLtXr18QliXwVCVW8dqOtXn7sRfek8UXC3zt/1vHN8dw
         XslVappftofRLHztKIhpGGLIUU6spBf00Hcv/oyZMBykifmTfd3rkCd9izBGI5TpwJFX
         0qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBP7QsMdsRzii497sQdvXMivqxHUi8KnMTi6DqPb4vI=;
        b=JoUzoHYKuvfYnlzjf+790niGUO4alDX5ZWfJFMoZbsAhceyU2LsblMKmXEboEZNRoA
         7I8ODRxfH0ISZ51aMg+834OjzWlhlEVbDNaO9kco/Tiz6vc3aPslBJ0ijoewA/EKwm2Q
         kV67PbWmXPP6GevWjMBl7AA0z5LTpkPrmcKlqI2LSrJoyUI0reQv1z44PNy+ceHRvNTL
         pfwhgsylVHwYkbq09ZYOjL1wEZivNRiIhtRLDdMq46cX/5ANVNfoka/x8XiMreeC28uQ
         SIFzgpqTAJi7oHQS6X2rP7uMoByeCKr/59uLpZaujahYWQts2ysc0SwjFduv897Vnhk5
         CyIg==
X-Gm-Message-State: ANhLgQ3uyQj2Mg8unkdxVjGFHT4cZQvBOYXVws6QVUb9C0mjp+MwD675
        CIfWL2C8g390mhanyY47VbSCiBb9TV5P7QYTJmCCCw==
X-Google-Smtp-Source: ADFU+vtSr6VQwF7m2+8Lo3WnbSGTzU2AUlIfQZYijuxBt0BqYCrk6rzyB34udEirfvaR+UlGIovaqzwfjvJEyyD0Mtg=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr3417402ljj.258.1582909537024;
 Fri, 28 Feb 2020 09:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20200228063338.4099-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200228063338.4099-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 18:05:25 +0100
Message-ID: <CACRpkdabUZYhr7S8fcOX-dOgUEfDTnhUZjqsadyghpuTDCoqpw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to renaming physmap_of_versatile.c
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 7:33 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini}
> into physmap-{versatile, gemini}") renamed physmap_of_versatile.c to
> physmap-versatile.c, but did not adjust the MAINTAINERS entry.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: drivers/mtd/maps/physmap_of_versatile.c
>
> Rectify the ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT entry and now
> also cover drivers/mtd/maps/physmap-versatile.h while at it.
>
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
