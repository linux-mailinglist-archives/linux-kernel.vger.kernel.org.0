Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB416CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfEGVIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 17:08:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35533 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfEGVIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:08:06 -0400
Received: by mail-vs1-f67.google.com with SMTP id s4so7135990vsl.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyT42HhZo+NoWlMcFfVHa74AFNvsodijHlMncKg590Q=;
        b=YehQViZvLM7Lmr9d7H2oBVwOnhxc/W7ZGb3C0R7fmfvEgavSj8wr0dWjHPOIOGCXVB
         ++EpCbZEDhD0i+6YXXoX1RK3f89W5kHuFQztGG9LtdCwHB6ZKLxVsTYZOa3dSuXWWfxY
         9ZMhyvs5cRAiCyhMUyX4IsaE2+u2EYpSjxKnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyT42HhZo+NoWlMcFfVHa74AFNvsodijHlMncKg590Q=;
        b=BHtmjqKbvlujE4xWJ/ji7L7PlK7phcppHi+Ejw+GP5FvZB+Cj15V5zDrMBX4OBy7Fo
         Nn2v6Fy/ancLL/+vn8TY/djRecAOnCy3n9CfcjhuJ3XzrUZ0bu6vOV054aMX9T/2x3dY
         onEWJlkseLUBh53kdI9C173lzihp9TJKLY1z8gV4ItO6GLJAu7DKojxCZk26Z1pbcgpK
         h2P46HvmBV+d1Ng/wYKBjnNOrp3gsyMpXUi4wNslJjEIzVwn/mFC6kvTDAnKFRNa0wft
         CRyp/fdw6EwNaO1IFaLBwEBEcBjnvn/Xc3MXk3RqPxhc5AS/YpM6J1ml1dEtjEebJV7a
         6hIQ==
X-Gm-Message-State: APjAAAW9rYDXpic0vuM5cq3xCKif7S2692oFpqgpgE6N/8hfafDeEPeY
        ffKSWJ/iQ8wNjpmLBFcL51FBczyF41g=
X-Google-Smtp-Source: APXvYqwLezLE7rqjiSlmLyRrKOxdOAzwyCQYgFZ4tlU6UUJSXJHLbGPp6/fssSgs8d1fVbTpc3svVA==
X-Received: by 2002:a05:6102:119:: with SMTP id z25mr17856577vsq.145.1557263284942;
        Tue, 07 May 2019 14:08:04 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id r67sm3718298vkd.39.2019.05.07.14.08.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 14:08:03 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id x78so11306067vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:08:03 -0700 (PDT)
X-Received: by 2002:a67:dd95:: with SMTP id i21mr13304046vsk.48.1557263282871;
 Tue, 07 May 2019 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190507161321.34611-1-keescook@chromium.org> <20190507170039.GB1399@sol.localdomain>
In-Reply-To: <20190507170039.GB1399@sol.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 May 2019 14:07:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL7pWWXuJMinghn+3GjQLLBYguEtwNdZSQy++XGpGtsHQ@mail.gmail.com>
Message-ID: <CAGXu5jL7pWWXuJMinghn+3GjQLLBYguEtwNdZSQy++XGpGtsHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] crypto: x86: Fix indirect function call casts
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Joao Moreira <jmoreira@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 10:00 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > Given the above, the current efforts to improve the Linux security,
> > and the upcoming kernel support to compilers with CFI features, this
> > creates macros to be used to build the needed function definitions,
> > to be used in camellia, cast6, serpent, twofish, and aesni.
>
> So why not change the function prototypes to be compatible with common_glue_*_t
> instead, rather than wrapping them with another layer of functions?  Is it
> because indirect calls into asm code won't be allowed with CFI?

I don't know why they're not that way to begin with. But given that
the casting was already happening, this is just moving it to a place
where CFI won't be angry. :)

> >   crypto: x86/crypto: Use new glue function macros
>
> This one should be "x86/serpent", not "x86/crypto".

Oops, yes, that's my typo. I'll fix for v4. Do the conversions
themselves look okay (the changes are pretty mechanical)? If so,
Herbert, do you want a v4 with the typo fix, or do you want to fix
that up yourself?

Thanks!

-- 
Kees Cook
