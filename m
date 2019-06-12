Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8656F420A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbfFLJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 05:23:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43963 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFLJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:23:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so11502178lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xB4K2RyPS/R57/JJTkF3nS6D2VfQstRM6okCDkUpXk=;
        b=pFDYhglDOvHhgTlm4JT6bDT8ASm+PtdFkhZg52zUouEDk4o0E4X4ZtbAOdJMAZ6iWl
         O+uvDV5hgYuwyTXQoE+Kr9oMbpfQ7hmyJKMyhaN3GCM2N7mvAWId00sc1wDMtV3ao05I
         8X9urtEYd+jcPPH620hZWB5B93f2ud+j35c0VpVa8kJ7OBsx2pB2J8LdcE0eRZYr4J/e
         st1c3reb9iREpMlFnS01buN5ERtdWBLiYD8vBcbAQem7rXk8INOS+KUI7jDv37tnRw8n
         BVl92fzUvYBE3g1WF4PDDj3kp5Uk0uS7Vs2bdThWC/PljF0RjE1nP2ntysaLq1oy0ZEU
         BPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xB4K2RyPS/R57/JJTkF3nS6D2VfQstRM6okCDkUpXk=;
        b=m8DMOFe8aE2y/xaN6DLcxvs8XZQ54C6B6+IQsiuvN1776JQLgywZr6hMDmqLDXnCWT
         xMchZBqH9PdgCjkxoMnXRp2+N3ryyTOma9OG5y/BuFsWWO9Q6qyu0VOJRHauQYz0hvUl
         68ch6rkYo/f/FPrEnlrw227PEQLvkWrFCFHBuVDsPnsVYz4REKpHFhXv6S33e7pNrVtU
         tENtRLJmPAx8k85r7cON7G+DwbQcmc/wwy5Wbfmm/i8DVAL6j/tgMrE1LbSF875+kp2D
         2nc10xlLrU7536fVNZzns9GRZnNtsacfRWKlQXwykH0iW6dUGohff7RfBEkWAW1spNPK
         wSRA==
X-Gm-Message-State: APjAAAUe8fyhE0OYI5YlIU3kpQDY/6Yro+/G1h3lsvANkMwg4ng2c3lV
        vgI+YgORkNSntkBnoE9tJYp9wqXPN6RIau6wFxyRNw==
X-Google-Smtp-Source: APXvYqzpG6R8CuOm+a9rEIDx5UCqguZdACqHC7MEghETAfPC2KWCVJSCTTbd3ssSHHSl0L4f+vvy9uBtO7bg9b6ZZYA=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr5356875lfc.60.1560331399558;
 Wed, 12 Jun 2019 02:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 11:23:07 +0200
Message-ID: <CACRpkdamKFMrvfi4+L95KqJzPkX69er=CBC3ShUwj0VWArnQRg@mail.gmail.com>
Subject: Re: [PATCH-next 00/20] gpio: gpio-omap: set of fixes and big clean-up
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> This series contains set of patches from Russell King which were circulated
> internally for quite some time already and I fill it's reasonable to move
> future discussion upstream (and also avoid rebasing).
> Fisrt two patches are fixes and the rest are big, great clean up
> from Russell King.
>
> Personally, I like this clean up and refactoring very much and don't want
> it to be lost.

I share your view, it is very nice to have Russell's attention to detail
shaping up this driver.

I vaguely remember at some point wondering why we were
not using gpio-mmio.c at least partially
for this driver, as it share this characteristic of keeping a shadow
copy of the registers around and seem to have offsets from 0..n
in the registers, but I guess there is some specific
good reason for not using the library?

Yours,
Linus Walleij
