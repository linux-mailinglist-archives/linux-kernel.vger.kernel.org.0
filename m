Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E647F52782
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfFYJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:07:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47024 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfFYJHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:07:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so15431397ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GWdIS+GEfUG5nPSEfqs5x6+drSTvkhfOWgKSNYIqN0=;
        b=QyBeTVgMyvV3A51yzjyFast24jYXD9mt1vYhxM+sIQQr9vvvhD24Q8C2Tojj/HzDOs
         N5MpHRTsgCVobB0lKXDimS1Nui2PheataX+Mu/E5NqIjnhRYxc4y4AAROUWO7p3AQa+5
         dkoN0wDLziZJDEzMxClpeUP/RU9UWvPeLmoELQcv8t9PFYBz5RBfGxc25hb9TF4FpICS
         b/IOVmvBltbMfLgiUDDo1S3hpikRWMkhjy7j1J7bbL6WBDOBij9OXOHxUPKAsp28cuVK
         pUKnDln9ijZ/N8V1r6D4/J/11sl7s9W/Obg7YeSW6reO42F2AAtMTn4G4iFOWTAWjZyC
         HWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GWdIS+GEfUG5nPSEfqs5x6+drSTvkhfOWgKSNYIqN0=;
        b=VSY4VyhQr+Lywp8m2YLdhIweszQn4KI4VientlSzEsGYRA7laawm0lB8YkJp2B87nC
         TlijpmU4wzeh6NzuJn9QfFsqMZLwaZBY35xHFHbo6Kr6fWCc7Ms8uDXjlwVwA0SGzvUO
         EGqmRH05Sp7JPHyltHFEbnFgdM9s4UFsU1ZEx28E9SpJKAZDx96HJBadfJ7FuPjHHHLX
         JQeaRm7rNtTHBiHkxwil0T3nhBPZjnvGxR8Dy8jeu8FuhYcaDpQCH7ZJ7Dwo8nN8jWb+
         muBBpCGmq7ze6QvNlmorb3q6UF+4H8qFIMgAbr7V6MOsviRwecxSCpPIHPGXaxhdKcuo
         rQZw==
X-Gm-Message-State: APjAAAXdsm5k7zWc4b2oIDIv4ISa1ORftoDetOso+nBoehzQQGgIc0Qt
        uTA8ceEER/AURIn9nowTQ38MWyqsR2iTs8W4BMQFrw==
X-Google-Smtp-Source: APXvYqzz9Um+MYJcHs/yCgJ4qUjUqXZH4oi0xIYoS/HhbJbKDvrsegnToehDA35zTaDo3fbZAHo6UYebdB3weJDQ2Ko=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr60952483ljg.62.1561453663092;
 Tue, 25 Jun 2019 02:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-5-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-5-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:07:31 +0200
Message-ID: <CACRpkdaRy+aVsmTCy0x+V4Xx13A3rihKLr2BkvLnQ-if5UZsGA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drivers: gpio: grgpio: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
