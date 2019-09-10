Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A832AE7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405751AbfIJKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:16:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34280 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfIJKQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:16:26 -0400
Received: by mail-lj1-f193.google.com with SMTP id h2so9322017ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6B2dmN5WN+irtxvTuQNclEjCjmvheB+jKp64iTgriXY=;
        b=gFcVNymHxWVs8cfxjlFzpyRY00lUHBGm0Sbh+3aXrwh0QCMV+3Ixt7l2BXg+f7yNBv
         C9vuPnDYIny+sLhGj9VW2DXouBIinpfuT3apDrcX+tyhYY58jd2WjC/uK9ZU9PE6mg4h
         +N2Cc6YNk//bzzyZAO+cON8+LlWM7h97xl1K4c59F7fkpBoaykqzSLRf0QHzQ3JkLVtu
         h9cp3Vv6N3fquIs9rSzlIMGBWkGSri4JowLEl5ZzkR/hK5OzJiSslnMTURbCrRkMubSp
         tbjQ4ub5WHK44rYFtFxd6Z7D88dL26Um/k3aAFkJiLM2+IXgZLHuhpnAmOwQ9HLyE6HU
         aL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6B2dmN5WN+irtxvTuQNclEjCjmvheB+jKp64iTgriXY=;
        b=NHAD8zfycfU1tbZKCpB1HRCPC8d/4gf72VUA4S+g7kUEspQW2cO1E28IU/M41vybmA
         ainoB3HFw+zKiOehRPJHnCozxO3B96nmz3bIgoFdYT637jpNgGoMoN6dc1ibPec4iQPK
         +GF6Bol8fjEqAAkL5rIXKOUP+ldZY2trY6+alBf8MMsOrEkw9gfO48L8hs0sFvv8Wk8O
         A11a28dW//nK6WGzlBsj8oNV8xUpNX+QIIypyl0rAuBBnB7wWtZ02OoRFwxQwKwnC6CZ
         26OdNU9/3r2pkDLgB0QsQ4H0Hq36m9pJ4UcKxMfoaIjGNfxxMKEGR6yXM3qJSZqncL2+
         7Ehg==
X-Gm-Message-State: APjAAAWe1jDr5CIF1fTZFFMfSflJJtG0n4FYkLyHzgQC/50vkLIGlv7N
        nbe6RL8HwvYPOB+gWVnKLDXKJuBzfslF1BiGlSe0N5yHGMptZA==
X-Google-Smtp-Source: APXvYqyfaGIPGKw7uEc6YE4YseLGABiCLKnn8WtOyOLR58FCtTmk1iUgK8RA6r1gKMFjR2SWor+RcUYS4d/6rCX9hsk=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr14041038ljg.69.1568110583490;
 Tue, 10 Sep 2019 03:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190909203512.675822-1-arnd@arndb.de>
In-Reply-To: <20190909203512.675822-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Sep 2019 11:16:11 +0100
Message-ID: <CACRpkdYhnYvepfxi6fBwiuPBGqWk=YiStfnXB75QwTb6XPyYvg@mail.gmail.com>
Subject: Re: [PATCH] gpio: fix incorrect merge of linux/gpio/driver.h
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Enrico Weigelt <info@metux.net>,
        Johan Hovold <johan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 9:35 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Two otherwise correct patches got merged incorrectly, which leads to
> build problems when CONFIG_GPIOLIB is disabled:

This has actually been fixed in my for-next branch for days,
the problem is that new next releases are not coming out
currently because of kernel summit, so the fix is not turning
up in next.

I have gotten something like 4 different fixes for this at this
point :D

Yours,
Linus Walleij
