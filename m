Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96F2D9085
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 14:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbfJPMNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 08:13:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbfJPMNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:13:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so23765385lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwAOuJ02/CmNLRHvM1+0qWUJI2vdB/CPjcxRe0gTmfs=;
        b=HGlLUHGm8S/Vl+k3MY1zgTw0RMgNg16Hy9iyCo9W1KsN+asWjfDNyDhvnxak0iXuC4
         RzAppZ3MSc3irAS7NtlwfvcE0/Cs+UyZa50Y3zMQSDsMSqedDidivTOd6BLzWZvjw0PK
         abReKeIh11Dxh5DcAgNfz8tn+Z1+a6m0pq61W26X6JoxC1oPbycUYP0bwgOysFkQvRkg
         WndepekugfextEI9bex7J8l1AyqNSrACd8gL8nO8netT9wjGt0Id9AYDXjM/KtQ0xhxh
         bNXd805sxS01yNIb6nxz+FAEyI09tgMaaunICGWQxDglPwC9EPBbkIJ8MYPy9ZoHTUjR
         DioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwAOuJ02/CmNLRHvM1+0qWUJI2vdB/CPjcxRe0gTmfs=;
        b=ri6LRHax6iDdNX2wsYwMpQrYIko1stXLHh8oLyrwnbmMo3TCFU13vceQvlf7Td9KhX
         C/I26uDQjw6xdHR10AI3lmQhLgKKBT4iEMxH2fnqI48Y/3GcdPKcuk+ojrSNEiYdIGT3
         LMOBT6UNBKdNz7lZvasJ71Qq1G5l5QJ88R1LX/OqQ6Af+CRq8IFxuyFr1OLYLVR4sRsq
         +lVz0BkW/XdeRudPqUm75IU6stUfER1+0yQLCp2w/gEbxjszqmZEXJcyS93xjUQajcTm
         dXPGllC86W5niZOwgWlv3fxDUPDs3PgB4yoCxyQYG3/YOrztFVCvPqTz7fzphsnli03d
         8mug==
X-Gm-Message-State: APjAAAXpNBFHDjxVO/2h6UAs2AxAZKypplRxJ2vEgRvP8vogfyeJYWW5
        q5PVetVgNfu30yQrmlxFi+fZ6xsdLLb9IGV2Iwh0B5qT
X-Google-Smtp-Source: APXvYqzcLm4ffYjz6L/K6mToL+dNjoyckx1raiIUkGvyOt2QIDTLZA0ue/HKnt9dEPr3w6FBUV2ydjWuON8gLRceMgU=
X-Received: by 2002:a2e:481a:: with SMTP id v26mr18267416lja.41.1571228027497;
 Wed, 16 Oct 2019 05:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191011154321.44f08f9a@xhacker.debian>
In-Reply-To: <20191011154321.44f08f9a@xhacker.debian>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:13:36 +0200
Message-ID: <CACRpkdb=FzN8sVc+u7SxgNkx11dWCLJK7rbJmOrk0gUN1T58zA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: berlin: as370: fix a typo s/spififib/spdifib
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 9:55 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:

> The function should be spdifib, fix this typo.
>
> Fixes: 423ddc580b13 ("pinctrl: berlin: add the as370 SoC pinctrl driver")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Patch applied for fixes.

Thanks!
Linus Walleij
