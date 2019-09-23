Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA271BBE0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 23:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503122AbfIWVir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 17:38:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41901 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389058AbfIWVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:38:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id r2so11298765lfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=JcoEGS/AI2rU99SMqow9YrwJpVhAdInWmVe0K73EpxT4IX0dSd4iV6gEYJNry3t1NZ
         czy0P2z6QFvutymUbR9Kl/JfZ7V+MTGu8fD757Q0hU9hsZCA1KKVL4ex53vmZh/jPMib
         pBCmfcv12WS9ovtx+DEcpFDjd8BQTAsbCG3Fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2a5iRl0pwYddtRZuyM8DbsyUr2hb638EoJcEbjk4XVU=;
        b=qMyxuYKIRQQ/A4QbetfI/e/oX4qgyUZ/E8eCBYi0zPsSp3j5Ijf2+S08xhzO4TqFQh
         yVydEdHfifoUHTUO6yPChaHuSf5Sp9y47avZ+E332dniQzVmceEWVLOWgTuJm+cHc+Yb
         3qW3jrCXBDPdZLFFud2n+eMP7f0oJsT1kP+UYN46jMVSCKhUhEWbl6loQdLkyDLAyDXn
         LhEzjD1cj8QZRCuTLkvXCkGb3nooJW5Xq/2qtk3O6diS9gEXSY5H0xPrTmy/mBA6pY9r
         X6Bt/D7unojqR3TOhgX9HbErFMuvTflAQq6yB0hjV4K9fK5Mk3ANFPLIYcSiXY60632t
         li3g==
X-Gm-Message-State: APjAAAVKgzb0ao4j6yOHff/1aR+N4IYuf8/9rFouvWDkWKeGw6rrs+WX
        3ztIwGs7cYY3jhRJwn7ij1TfP99EN6E=
X-Google-Smtp-Source: APXvYqx8H59lJZpe0gojrne++bJmXAPRS+zGXi9eCbMzgnchehMo8qlewxVG+T3MxAA6vLPtt1Behg==
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr968397lfb.153.1569274725200;
        Mon, 23 Sep 2019 14:38:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x6sm2055907ljh.99.2019.09.23.14.38.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id q11so11291125lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 14:38:44 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr945017lfh.29.1569274723803;
 Mon, 23 Sep 2019 14:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <745ac819-f2ae-4525-1855-535daf783638@schaufler-ca.com> <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
In-Reply-To: <CAHk-=wg1zkUTdnx5pNVOf=uuSJiEywNiztQe4oRiPb1pfA399w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Sep 2019 14:38:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Message-ID: <CAHk-=wgNi_y5SaXGS3hsxsFcU8P89O9ayJZ6yEYkvCC115J40A@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.4 - retry
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Sep 23, 2019 at 1:14 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Thank for the instruction. I think this is correct.
>
> Looks fine, pulled.

Oh, btw, can you get more signatures on your pgp key? I actually care
more about having a key than having a key with lots of signatures (*),
but signatures and a chain of trust would be good too.

                   Linus

(*) To me, keys are more of a "yeah, I'm the same person that usually
sends these pull requests" than some kind of hard identity.
