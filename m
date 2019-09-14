Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8173B2D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 00:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfINWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 18:33:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33867 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfINWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 18:33:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so13337901lfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jji8i7bYghl9dIJBVrLKgOsYCCv2cn7xJvSFL8MqDS8=;
        b=SZFhlX/Rx68OcFKimkyg0NdYulc/jApI9Fpnm8EYrmOFj1TBa1qzG2szKWe2evXz+t
         IaT6ZvoRIRAUR/NbTRgAp9baqL8Y3+ITewQ1TKQFUAVjyKRFYNWD2o7HEDFM1X82gdG4
         RdZr2NaIIc/nniMafWEMnFSRDyOih4FIwoxiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jji8i7bYghl9dIJBVrLKgOsYCCv2cn7xJvSFL8MqDS8=;
        b=aVgSpdJLfvKO9aPgo9xVGaULiTwoKqTA0j++0dr06EcKwIgqzcUOpCQzBJ+LpODbVE
         qAD/jdH+019GRX6r6LM85g1iuPePBANnRAO2KCsXSzfbi5KtBTl5U+jKLlweF/L4wKYB
         OrxeB8bYmwfrLGpQJOfDPJKX4ZIB9ddf3jP1x3Dkec4j+TMjcSmooCsrRgqCf5JWkDqC
         RJ6jaYJbu4xzggGOqz8PmmQaMW211ZpphCqEbIqOEqKZxzKJthhN+AeqUXhEo1YzWtsQ
         fCfEuESs5aq8qTl6ww++37AvTnY1ACAw/Tu9L7XRAYtzGmlglBORHBlcMV3GsQkMoXwB
         O9Vg==
X-Gm-Message-State: APjAAAX/UbmrlVXHX3dKXe1aLFOjdD6jD7au62zGQ2TpzZ6ImqpfIGxE
        KmTNYwcRgEfEj1Hswar5q6OImu0U7Us=
X-Google-Smtp-Source: APXvYqxEcPHRFzoMZDKsTpi9XZXPXoWzIJaxUC7vuJIeWE9FJzh19zOFxkJ6DQnNHWTiiWV0Zz58IQ==
X-Received: by 2002:ac2:59c2:: with SMTP id x2mr31776009lfn.125.1568500385269;
        Sat, 14 Sep 2019 15:33:05 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h9sm7964005lfp.40.2019.09.14.15.33.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 15:33:02 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w67so24634816lff.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 15:33:02 -0700 (PDT)
X-Received: by 2002:a19:7d55:: with SMTP id y82mr34501511lfc.106.1568500381950;
 Sat, 14 Sep 2019 15:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190914211126.GA4355@darwi-home-pc> <20190914222432.GC19710@mit.edu>
In-Reply-To: <20190914222432.GC19710@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 15:32:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
Message-ID: <CAHk-=wi-y26j4yX5JtwqwXc7zKX1K8FLQGVcx49aSYuW8JwM+w@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 3:24 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> > > Also, we might even want to just fill the buffer and return 0 at that
> > > point, to make sure that even more broken user space doesn't then try
> > > to sleep manually and turn it into a "I'll wait myself" loop.
>
> Ugh.  This makes getrandom(2) unreliable for application programers,
> in that it returns success, but with the buffer filled with something
> which is definitely not random.  Please, let's not.

You misunderstand,

The buffer would always be filled with "as random as we can make it".
My "return zero" was for success, but Alexander pointed out that the
return value is the length, not "zero for success".

> Worse, it won't even accomplish something against an obstinant
> programmers.  Someone who is going to change their program to sleep
> loop waiting for getrandom(2) to not return with an error can just as
> easily check for a buffer which is zero-filled, or an unchanged
> buffer, and then sleep loop on that.

Again,  no they can't. They'll get random data in the buffer. And
there is no way they can tell how much entropy that random data has.
Exactly the same way there is absolutely no way _we_ can tell how much
entropy we have.

> For 5.3, can we please consider my proposal in [1]?
>
> [1] https://lore.kernel.org/linux-ext4/20190914162719.GA19710@mit.edu/

Honestly, to me that looks *much* worse than just saying that we need
to stop allowing insane user mode boot programs make insane choices
that have no basis in reality.

It may be the safest thing to do, but at that point we might as well
just revert the ext4 change entirely. I'd rather do that, than h ave
random filesystems start making random decisions based on crazy user
space behavior.

                 Linus
