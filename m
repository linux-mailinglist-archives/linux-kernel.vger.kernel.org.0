Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A2F52723
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfFYIwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:52:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40103 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYIwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:52:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so12052787lff.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sVy1ZdjISYZ4x2JdrMT9LI1XuB2hh4y/prk76ssgW8=;
        b=G3KRAhAGe1qA98XT+tNHwa6bfkqWZJ5R3S16P7b1ifCEGfzYc3qRb9OR5cQ1pA/RAD
         sbtplkiwf81OLc1zT+WYjzWFq2429RCTZOnLkcf4QinyL/0XQ1lkYPiWnOCt0jOpliOo
         yhcyXb2W1TyqBurZptQzuoYglnr+ocZF0b6rUitx9tlT23mwMsz41LZrAbd/h98BZGXu
         YRDc8ns+UFRDXEk7nIKRpIJckJt2v5cEP4Mnwi1YeO1sXDVdVzo5vIsEFdDMZYf9Levx
         tNjVXQJK9c3sLR59Hfb2xcviF5y9fxomKTljgGSey8+PPsn/LjsTdnytJS+AbSvsTmgA
         TY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sVy1ZdjISYZ4x2JdrMT9LI1XuB2hh4y/prk76ssgW8=;
        b=V1PAnKgH8G64ywvAlepf/uCSgzf3nph4EjNxW4buX5PTfogwV+xxF7wOw0JjAMsZWy
         MZvBHI1OMfU1LGjk81PjXsqhkPKmY8TdwwnuaajVmqgmT9vSuz1SUWAygJ/oBbRKQsI+
         3/Zkqu+o4m0NBisB7qWLRkHCXfzmkhDwk7KMD9ge1tNxjaxOQve8/sh9nsXrtOl3IvAT
         BYNhm9RFWrwQKLx1YY53KcjcBAWHkJTj6xDAkbkNibqtmJB4TXDySKRokk7eTBnGa3nI
         ovYZjZP4iV/Ycc36d3dkvEZwe6O65lf9RsbTibKbN51vrSCWxYshXlnnzwweInvbkI99
         tH4g==
X-Gm-Message-State: APjAAAV0iGIrtUdI7P7lbwt/gQzA4HEFwX3i9FseF2ZgtTUc1McZyofp
        K6X+o0JsxpbckRloSQ7vU0wP7rCVXPmj49N8QlRMHA==
X-Google-Smtp-Source: APXvYqyE2yJaybeR4mT7wbfZf/tS94S/SlU0cAeCtceLJiDRJCRt6joGVNWjbcfYTBxGjyPWLwAjVeBQRiHmFRfChkI=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr28602618lfc.60.1561452771554;
 Tue, 25 Jun 2019 01:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613015532.19685-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190613015532.19685-1-yamada.masahiro@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 10:52:40 +0200
Message-ID: <CACRpkdb1MySnzCVGb6v1KovmgJtagKeSe+mrPvsVOJz_s198eA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: remove unneeded #ifdef around declarations
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

thanks for your patch. For some reason I managed to pick up
patch 2 before patch 1. I applied this now with some fuzzing.
(Please check the result.)

On Thu, Jun 13, 2019 at 3:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> What is the point in surrounding the whole of declarations with
> ifdef like this?

I don't know if it is generally good to have phrases posed as
questions in a commit message, we prefer to have statements
about the change not a polemic dialog.

>   #ifdef CONFIG_FOO
>   int foo(void);
>   #endif
>
> If CONFIG_FOO is not defined, all callers of foo() will fail
> with implicit declaration errors since the top Makefile adds
> -Werror-implicit-function-declaration to KBUILD_CFLAGS.

Maybe this flag was not in the top Makefile when the #ifdefs
where introduced?

> This breaks the build earlier when you are doing something wrong.
> That's it.

Good idea.

> Anyway, it will fail to link since the definition of foo() is not
> compiled.
>
> In summary, these ifdef are unneeded.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Pushing this to the zeroday builders and let's see what happens!

Yours,
Linus Walleij
