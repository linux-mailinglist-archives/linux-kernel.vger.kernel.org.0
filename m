Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4307341D40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407944AbfFLHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 03:11:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41039 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407055AbfFLHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:11:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id 136so11209382lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KcMuzl2j9UlUMV+5bVICTUXl/nZCKqZLShOlWK6AIs=;
        b=Aw/L4d8YErCBnWXwJfO00otZf3wDQGfZunv7P0vOQbVNoN7eMd3CVXEDRcX+z6n9Tk
         /2euh4O9JfNrPHL31l92kA1LyI+Hf8IwF0mgT+eM06OcpGEZyrMz7ZOzPXbsEHQc1m/g
         K4znn/UpX6u53bnerzHi6Xm0JOGOda+gBMZAvNGVRyDlVF7mXggr8DA0Do3O3uA/qhMb
         u4JFf9yQixYhq8vpIkQEncJBgDhdJMQ7FH3ULz61HsO+U9tQk8rEnolE01nRQrKg/92F
         DLMEdej/O6VZCTO6Q8UQ6ZTf4eeWDcd8p4MF/ztFLRW+/jn7f9O65II2rDLFUMfQu84b
         SxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KcMuzl2j9UlUMV+5bVICTUXl/nZCKqZLShOlWK6AIs=;
        b=VDtWLND097q1l3T/5cIVOt1n8EbUzp5NOj/TlQ3dhDteMLwxq9rgVGJW3NKxGe9mQa
         AF4DY7ryUpxxliV/eFSe/spOEbYN3mjMQt9jgx56dnSoPOp7p4VgEX0bxXfnn8M34jT+
         Oj+vHsSKexiJchiB42NYj8WY5YkI/0WgiuIbGel1dWyOx1CMOM7fSB4ZiQtUYCmt6uDb
         R673j/+4PjEbqq9Qc7Y3rca+1Y831d3TfBIwkwmlqHbZktehrWAsYUME5JZZGAzCAyBR
         OFvD3yzi7/ErJFHmXyL9DQPRja9fbhhdGA2Fre6eLgoXOcb+n5LjuyxhpEdqJ5Bk2lS0
         SQVQ==
X-Gm-Message-State: APjAAAWdexYDkxioxEyfjEO6O7ohrsK6GjniPm2/LHFRBaJY+uVAgQ+3
        KEwEKEBq4vcCuN2mAzZZJckz+RDPd5dj7CrlOi+J+Q==
X-Google-Smtp-Source: APXvYqxk29thQQE/BHKwINb4uefI2UckUUiQ3q2QTbipO6HIND/PFkyMs94HDPXUOnV0M1Ddkg6jgfptNouBMVw9dIU=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr27109977lfm.61.1560323492832;
 Wed, 12 Jun 2019 00:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190609150953.6432-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190609150953.6432-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 09:11:21 +0200
Message-ID: <CACRpkdaSM4y_CEJH-MWx_7BqSP6PpTwQ21ZG++wfAT29RPcBHg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: remove unused pin_is_valid()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 5:10 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> This function was used by pin_request() to pointlessly double-check
> the pin validity, and it was the only user ever.
>
> Since commit d2f6a1c6fb0e ("pinctrl: remove double pin validity
> check."), no one has ever used it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Good catch!
Patch applied.

Yours,
Linus Walleij
