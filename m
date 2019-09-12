Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541CBB0B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfILJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 05:23:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41132 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfILJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:23:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id r2so720636lfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wleDCZGZgibUMcR0p00n/TWBGhK1lh4bsiBsil/6mZs=;
        b=Xzffn1ip4vNvZAXz6nwUdvhDhcg8GqJeW2AQzLdqLsFboIDSVqJa1AW0xHJjMeJCLv
         BCzwO8RnUooQosy76N7lEisC6MzpgwkyZPKMVd87gyj+DdGsXCUAipBPaQiJ3elN+bXq
         ObPuHH/c9fHCFqyQUgoX/MNcqXhioEdsMI+u7ugRCyT1vAf7KtsYEXPUJZVHuQsofAI4
         QYVz3upArm16cKzLGfK2gs9WBWa7R2ht/LZxkNTl7OuczI0jsmVvE74U3ZDojRgPZPo0
         PIdRXaYDD+EBHkS6dm81BamnqGNPKK0iQ9XmJMbvlhnMUx+hmbLnZJTO4jvDdhgEBeqq
         BQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wleDCZGZgibUMcR0p00n/TWBGhK1lh4bsiBsil/6mZs=;
        b=DAs8BAfsRad+b2/jAttlUpCsq0fZVxo7z/sZOXjr66N3z+VAXZLsq3gtYwX1WeK2/W
         gD/GghjoziJmj20rJmu/XzkqnK1qdfZ586MsN/H8P/w/TcTyL+BUc1xqT46lhbADo/ng
         O8PT02ffwp0ZYGI2nZJ0+9cq+fZZpunN8CcsAdMR3qq9D0W0tRGFKP47spdHKM65WPaX
         Lf4314T5PDrWqMuZ342us1YkltVZacdMkswlf5vQMGvrumqNFqMf16BH/5MvuaBoqAZt
         yJ46IaRHDx0zburgFJ8Js1oTPasSMNDcLPB43kk8IZEtYyRM9ITEXF0z187OIJO6xHig
         q2tg==
X-Gm-Message-State: APjAAAU8T2aXSZN/Ki7L7ZiAMLbsU2uGjjBtNabVVCNSaFqrZy2TgQpa
        IA6VULVqZxQBhoPVNegk+b7JN3PAJzlfU9kN1DnMjA==
X-Google-Smtp-Source: APXvYqzdDNeiMGuPfC2If89T18OS0RWws402RdlD6gKtiXF4K8PgEhwN31xFhUBsXB/nFtQ/qB8VFGTpmG09aukwOis=
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr28314553lfo.60.1568280190594;
 Thu, 12 Sep 2019 02:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190910170050.GA55530@dtor-ws>
In-Reply-To: <20190910170050.GA55530@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:22:59 +0100
Message-ID: <CACRpkdaQUVy_k_zvGBF3V4fNvVWKFa-st=RdtbjSQ817a0BSTg@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77686: fix obtaining "maxim,ena" GPIO
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 6:00 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This fixes 96392c3d8ca4, as devm_gpiod_get_from_of_node() does
> not do translation "con-id" -> "con-id-gpios" that our bindings expects,
> and therefore it was wrong to change connection ID to be simply
> "maxim,ena" when moving to using devm_gpiod_get_from_of_node().
>
> Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

An honest mistake, how typical :/
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
