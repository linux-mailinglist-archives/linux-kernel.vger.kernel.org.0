Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115A33A688
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfFIOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 10:53:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45751 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfFIOx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:53:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so4858822lfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU+WyG1TNeU0wHpSgq4qa0v7PmW/GjVZf4FGn3dLePA=;
        b=S2hhrEwnLrxZ19kIxNfe07/0PGlroLlmWeZ9yAhw8zzAll+czOobfpLnWQkvdpyUH9
         rd1s16S0Q0IKggD9pllTNCPoJcLhr3W5fZR03/b/oXSmhP0f7jJVgyYwTjNJulLM1xg+
         NoeRnPaZ2SoPPRjj3sOkTZrj+EpNRT3b1AaNvZyqFXUqwO9oidtzjABATvXE9fLH03YX
         8qL+7tsYI+t+wwyXN0SThW/fSnOXpW/0goe61nHrIT2wLKQlxnFp8snQTDsF6wbREjw3
         bYFmbJlu3k4XaUJQUbK2IRLfrB3KqnK7y1jVn+LC9XFHgFa9iLNXwMoSBqnpwvP3FM6l
         TUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU+WyG1TNeU0wHpSgq4qa0v7PmW/GjVZf4FGn3dLePA=;
        b=uLfVYM74JFCRsOEDJelSA1GOLYykhfzjQ+GijBqpqJHrY5U8xhBvmNNgBnFUXKIxtt
         jTtD5A2SQcoqkxnC/8xTocfF4cQQxkCt/d3R7O/zt1D2KJ95idKn0AQAplcu3i4cKE8c
         AhvylQZ1fDmerN25LY6RWp6P/87BUI3yLLvYDhIc/dsbC1iX2q0izHRbK6RRykXq09v4
         qbIkolis6BVzP/9aGzU3dULue1ozaqi7o5FvI29hBRDM0cS+GTkHCQrba7gvNKdAniJ3
         Qr34nhMS5WNAwZ/H9TKT5RnqDt6UTzJ4xKgV4Qw7KOU2H8wSFJRveK0kxSRYGXcd4f89
         ze5Q==
X-Gm-Message-State: APjAAAVAutHX6CFaCvgpqMDzD9hsV4vuRgBlm/Gi7m1uxEotK0Rx5Vbp
        LIWNEVWjy9X+w/dzuIFyeVxVF/sc48lW6jI5dcr7rA==
X-Google-Smtp-Source: APXvYqwlidGfg5rHLR8MpVmRrgDqJeNGuuQj25IrHXF9OTZsqnr04f3gGacriT/TP/hbmUYhm5ANmiweypSJWOgGtcs=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr31483477lfh.92.1560092034835;
 Sun, 09 Jun 2019 07:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190609144313.4842-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190609144313.4842-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 Jun 2019 16:53:48 +0200
Message-ID: <CACRpkdab=A_kRBaNER54azChP276uWt8ccW7736H2G7F+1A0cA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add include guard to pinctrl-state.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 4:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
