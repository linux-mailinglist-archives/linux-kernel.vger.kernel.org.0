Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8EF2A26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbfKGJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:07:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38794 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387585AbfKGJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:07:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so1378089ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4r2I4GWCi4/JcKwrvsl/b6YhN/4C3j/fmn4xKNtK0ZQ=;
        b=ux2FovIcG1zE1vslYMh2o/uYdWYD97faEpyQnorZ9gkQPiRWvlS2RTooMZAxvF3su+
         OqoHPDmvTUAi47XsDElIJWqgC3LO7i9KEuHpeu7FdNJRgfNfkzqPuAqSyPGzHXjMB3B6
         q9wjlHMeQgdsM7gIdR9S7L9ABnXjRR3GhZaPvwnscJwgO+QS/Eipa1O756bS8o8tMYgR
         uPt/rdMsJw77oSkg6k4BQQLd2cS3JqRU6ZzLbEl1CJ0K0AT0BeYhuoBj1UyAfOdehm9A
         YKs0s1JZ16Km5J4MR2gu5hILMegt1bUWBpQOx3xf72iFOTqNaIeQ7vGXgdOpXJ5gKTRF
         /4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4r2I4GWCi4/JcKwrvsl/b6YhN/4C3j/fmn4xKNtK0ZQ=;
        b=s6Re5ZxKbrpzptMn7n/z8bSQ0xl5vrTcH//DZ8d2lnlp/JgnjtAx1MK9+OxeLYa/xl
         +Nvs6QwgxUxAil0Yhv7vsof/64e4c2sVhsUza56ZAtBiJahCUo0jfSC/xJAQZiRmInta
         sMUvTcssZO43eVcpPIbAj+ghZ3t0ARzIoc3NGVopanM2FqqLBPJ+X08mqw7O1FBTMUrp
         mFRnlh+BPU9ouLN1zjYJ5RFhCX0V+g5pbLjdQfjf9Dhx5xk9SeskcrlZck6SbfbBrSyB
         hC4onbi1+gce9bEjCYBdmRW9b3L9WOUwBrKna1/dm4V6IXHnBo9/d2KIKjTHZnQn/jd4
         inNA==
X-Gm-Message-State: APjAAAXlSIz0Oe0wfiVLhEOGYj1MMA1SqLJo/IalwgmpspXI7sY65qXu
        HdaUO/hTO4ioi3aTzau4AgkKKkION8UW+YkYPKGuog==
X-Google-Smtp-Source: APXvYqwocIIrCbyry8zer+NUwVaV5Dx7e3lBotAXLq/eYxTJbRgLBTjLohnii7mCSBObKiM3W3u/8TT7mvEO2yLrxeg=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr1583378lja.218.1573117642202;
 Thu, 07 Nov 2019 01:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20191104100908.10880-1-amelie.delaunay@st.com>
In-Reply-To: <20191104100908.10880-1-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 10:07:10 +0100
Message-ID: <CACRpkdbFyTV_8aJko8r1+2vXohHfwoJy8ujTofUC0ruG1PeviA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: stmfx: fix valid_mask init sequence
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:09 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> With stmfx_pinctrl_gpio_init_valid_mask callback, gpio_valid_mask was used
> to initialize gpiochip valid_mask for gpiolib. But gpio_valid_mask was not
> yet initialized. gpio_valid_mask required gpio-ranges to be registered,
> this is the case after gpiochip_add_data call. But init_valid_mask
> callback is also called under gpiochip_add_data. gpio_valid_mask
> initialization cannot be moved before gpiochip_add_data because
> gpio-ranges are not registered.
> So, it is not possible to use init_valid_mask callback.
> To avoid this issue, get rid of valid_mask and rely on ranges.
>
> Fixes: da9b142ab2c5 ("pinctrl: stmfx: Use the callback to populate valid_mask")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Patch applied for fixes.

Yours,
Linus Walleij
