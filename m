Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60303AFDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfIKNqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 09:46:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37772 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfIKNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:46:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so16492503lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sB+wuvpg6HOuULqW0CTyLMZAayjlo9Avh7ZcIfH02I=;
        b=f7WAc4eVUllG0HyD3MOg19lLppTzVl6OteOiVGlOanE6XyIj3qnlmvqoBN987zeZrw
         S0IAcgva40wvfsDFvM3iBU+YJHXlQJ3lZG51L+Mi5m2SR+hu8e0jyXEHnLLybleugw05
         ZF0/LzCcyey2fwAHdDqpbTR0gDZ/J9BymPONwPVtMrKQxHhsT/t4Lriy+q4xMRdFPeW0
         OLC2m/IW0I59dAFAHxL2YvisRwdW6sCDWuapamoz7H6mHjZ6Qv6bBFOfo99aJWCAyWTc
         m9m9WN45I21+hrEqrAa7ziveIW9c5R1rDsjJVUPr93xOMiM0odNzmnjfiB49EaR7aUTq
         q6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sB+wuvpg6HOuULqW0CTyLMZAayjlo9Avh7ZcIfH02I=;
        b=amyinF1RX+TZ17H+fAD3PTSOEzbqIyfEuIVwmpNqcr7UmH90B81Wuob+ZYMcBG0cSU
         RepGlGhU5M4fizmyqOk0BmD8oSIcaAUyrw0ZBRT01XpSLLMiFZ6aQsHBSQoEi+CzGy9M
         2lFWXf6vGcierLfRgyxhB0fuo0jC1WmSg1YrLeKIAYJvrp+AiI4Dg/Tz6xAhK98VnZU2
         f+nA2iFH/cvmMQ8WzieF6QJpdEy4SVqrSWD70ndaoglqIazsT7PjsJMxjyOtQS9RI6Fl
         /AmnEyrrXys5kYnfx0NBm0mDcaOhDStcFiUWXQbj40jLZYvR6Y8QBQ4y9v0d6A54Ji2G
         3u3A==
X-Gm-Message-State: APjAAAVIqQZDgBPijvYpRPO53AbKZzjGG1iEk8nj/MDn4vcJPUhzwg5p
        xLr/W+EntpvVPpTfg8VhwcpMDb4gzAKiu6h2LhMc9g==
X-Google-Smtp-Source: APXvYqyF6iui8XzJs63N8SI1PpU/RSrw6A/JpJKJvAWmEDeGqssvUwnipJOZ4/itbd3e1Uyp9EoF+YH4+XRnfLSl9JE=
X-Received: by 2002:a19:117:: with SMTP id 23mr24532313lfb.115.1568209598170;
 Wed, 11 Sep 2019 06:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190906084539.21838-1-geert+renesas@glider.be> <20190906084539.21838-3-geert+renesas@glider.be>
In-Reply-To: <20190906084539.21838-3-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 14:46:26 +0100
Message-ID: <CACRpkdaOu2mVGS13MpQQ-OJ71W0qR4oTvE9T4+=BKch4+Vdf1A@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpio: of: Make of_gpio_simple_xlate() private
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 9:45 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Since commit 9a95e8d25a140ba9 ("gpio: remove etraxfs driver"), there are
> no more users of of_gpio_simple_xlate() outside gpiolib-of.c.
> All GPIO drivers that need it now rely on of_gpiochip_add() setting it
> up as the default translate function.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
