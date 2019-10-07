Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F258CEB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJGSNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 14:13:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35893 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfJGSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:13:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so9971898lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMlh6GXN6QbpwC889qdv/mL2tKRwyhPfZJiqASBvKqo=;
        b=h8vVKPc80ltfyFjjkk1eX3SsLDZsWpHSGP70shQML8lM+pQi5PD43ZLbNhTvHnnieH
         3Pdsvi7u5yvEvu0mkBG36/MC6h2vZ5j/Ramv3pLra1nTcYqBd177SsSNYgfSw50OivjV
         toQ4l5QhAqNdBrZzz/KNR6RQik0WFppq5OXBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMlh6GXN6QbpwC889qdv/mL2tKRwyhPfZJiqASBvKqo=;
        b=j/T4yeiiFoc0IsMKOrJeO+62ZCibzJUWhAmFyXX1nLt4o+B5AVrROejh4+itNAHTv0
         5lrNsL1MhY6Yo3lcff9ylZ1vpxpRdU8ynUiO3ThKn5nxQGGlsEY3FeXpaI80ic/hyQb0
         XoWqgYCi7gmh1IhIQdrZnRHkAB8V/Lez3lIyfRX2HS3dYw6XbpmSMeQLlXh8hGsEloVR
         +BHyUe0UHeS3IKS8lmoSp40hRlM/mL9og4JhRfuQlCkpDTHUGgU9pTYx9hSvyMubauAE
         hnIebtW8jRBsES+oAj/vV6sTwJtz75s3KtsNIro+CKXmAboOycxKK+BHDpS5rpooCPiR
         gJUw==
X-Gm-Message-State: APjAAAV8c3zpwZWgNW30eCQMhhJefJZhThAymF7GdAtmJ4oJ/+xYNsHo
        VFNJpRrj3159CrPUvxdh9m9SCn8O378=
X-Google-Smtp-Source: APXvYqySM3sFYGWYUiKpsM1dV1p9HeLbFWb1d9c0vusYTRcWsRtdrDDeRRClKlNFXgZO/vywHeVLIA==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr18175406lfc.28.1570472024330;
        Mon, 07 Oct 2019 11:13:44 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 202sm3307827ljf.75.2019.10.07.11.13.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u3so9931694lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr17404487lfh.29.1570472023078;
 Mon, 07 Oct 2019 11:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <20191007173432.GM26530@ZenIV.linux.org.uk>
In-Reply-To: <20191007173432.GM26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 11:13:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
Message-ID: <CAHk-=wgSzPwzX0cHgTZ9SQrd8XWQcMnLkBCo_-710pLTEBFGYQ@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Tangentially related: copy_regster_to_user() and copy_regset_from_user().

Not a worry. It's not performance-critical code, and if it ever is, it
needs to be rewritten anyway.


> The former variant tends to lead to few calls
> of __copy_{to,from}_user(); the latter...  On x86 it ends up doing
> this:

Just replace the __put_user() with a put_user() and be done with it.
That code isn't acceptable, and if somebody ever complains about
performance it's not the lack of __put_user that is the problem.

           Linus
