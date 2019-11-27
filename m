Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1F10C0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 00:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfK0XnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 18:43:07 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36686 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfK0XnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:43:06 -0500
Received: by mail-vk1-f196.google.com with SMTP id d10so5938970vke.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=PvBbnjafdCvEjlwAHLsw4Jkf5UKDz6s7witD5jd3/x70kOObX+EhN8IhEu1l0vMDao
         eyFB2VR6+BiVNsnhas396vPiie5zwGNVANUKDHufBAXVc0+9hKfbW030dFWNG3Cv/J7l
         hqmrKydCIurQVBzzegb3UutaspJwhtGXO/gKSvIA6Sq2HhXhwRAghpC1UbE1oDheTz8S
         qX4ZaH6B1tEQxHPimTogvOFaHeUSQzd1sKhIPU+fef2bGXQspLHe1EyC9nEza/asyLzJ
         b/YquzQ4e8aWWFpfl2u+fQMt+7m4lbuhnN1p9eHjdQdOaCsEYyXNqrWJj/1kRgyr8e+w
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5V1U7K9kHqSmBC9GKmbu10OmsvEfDZWHZBAkdynx/3A=;
        b=qZkePn7fIqhhEJaj4xWJP4AquD2oVWrWJ6Y7Iq/Oa7LNrxluua4c4oRm50s+j2csCq
         7DPfpKJdX9e5y8yvnvt0xS+IXVM0hJoCiVoBHY6QJpk5Ft9fzYiGKKXV7t4IZr3JA2FV
         GYTpPu0Vezku8EV6sC/pcpY8BOku1Hg6vBTgoa6aEVXJ9LLLN8G4ASDPYFYE3klC7wir
         t0KxsE0L1XyvPMccqb40bxOv8hgGI7aoIzVAK+qfc7pOtGiMjkp9zkAQIAsGM9PuaFT/
         eUDH860u8KeZsXjhuMQW4k3IFxyWr2fRrHgat9VTyFRcUXmiPZI+EX34oI47S3/LB9AB
         jWNg==
X-Gm-Message-State: APjAAAWQnI8HZUi+V69XlRoMtLJyQRT08cOvZMUnKKSI/a5cHew+p6k4
        6bbGpysCifwNVxaR9cqh0SqBQDxBt4WvzL1+EkXqXw==
X-Google-Smtp-Source: APXvYqx1i0KATXqkxu2iu7n10l5sJYYFz7lSnecvNV9HWF093zCgA7YZz4hfleScYvfvsSSdbbjLOGlrCFIaftAte+A=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr4689848vkc.71.1574898185282;
 Wed, 27 Nov 2019 15:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191119201353.2589-1-samitolvanen@google.com> <20191127181940.GB49214@sol.localdomain>
In-Reply-To: <20191127181940.GB49214@sol.localdomain>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 27 Nov 2019 15:42:53 -0800
Message-ID: <CABCJKud-JRT8mNmP8yMobeFajk1gU_iwss9w43keZyX9jasPXw@mail.gmail.com>
Subject: Re: [PATCH v3] crypto: arm64/sha: fix function types
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Nov 19, 2019 at 12:13:53PM -0800, Sami Tolvanen wrote:
> > +static void __sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > +                             int blocks)
> > +{
> > +     return sha1_ce_transform(container_of(sst, struct sha1_ce_state, sst),
> > +                              src, blocks);
> > +}
> > +
>
> 'return' isn't needed in functions that return void.
>
> Likewise everywhere else in this patch.
>
> Otherwise this patch looks fine.

Thanks for taking a look, Eric. I'll send out v4 with this fixed.

Sami
