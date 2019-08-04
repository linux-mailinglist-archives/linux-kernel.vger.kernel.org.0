Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4280BE2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfHDReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 13:34:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44823 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfHDReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 13:34:11 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so162537480iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSbKSx5m73TVdbeyhFM7iW9Og1SMXpc1ky4bCAVCxs4=;
        b=ADlOLWHuK2VwUfve8vpeFdrwbwA7RPaodycp1N99CBS2wORgpg6zZHSoWiP8SmSm1U
         RM7TiKc9dLUy0KCZ3jp4MSagVlXp2AeFW2delztb2FP5PvPDTLjyuZEcW0SwvT0pdBVb
         FUsy5k+0ovTT3iS49Jn1TBuP/PWctP5WOBK14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSbKSx5m73TVdbeyhFM7iW9Og1SMXpc1ky4bCAVCxs4=;
        b=NCUsdY7kLbFuh4EQfa/aPGeOhQUKhqM0giSyKNfvy6aOtuMF1jI+bm0x97jrC6cqQv
         aqe2bzrqnZfxs0StBwpfDfSKtb+lusMq9ZmENhIpQ05wwljTAN/aJ4icKZO6iO560GNd
         u0chQPbaB1p8ckgJHa+EtEaNdapACjOp7DcTTQ13CIFjXXYxV5zMLhw3WX3TgJyvu9uR
         Ssm6depDyfnDeYEe5GtKmTjmNpl1GyHcXCL9LuLpp36cgDomDFvb2+P5E6PAYqoe4ywC
         Bmrpg64OoA9KZ0bBklW3oWygaCPvajMI2NuRMfYfygE3NWDT07/iOunusru7J31YWaPc
         7NEg==
X-Gm-Message-State: APjAAAXDQY1y8LiKUT3+swg7JJLt2DYCb9pDzUEr6cuHlwqWH/JeCqCi
        l8JIFnqZvX4BJA29uWvdrEOIWxdfy6kSYgYarvl9hQ==
X-Google-Smtp-Source: APXvYqzzUEpJFtRih6Nzxhg6l6D83kQ2I6KqG2D7hrcFzzozkSYptlaJsV8IqdJ6lRVyc6a+lSg8vTv3+hRGSfmO3aM=
X-Received: by 2002:a5d:948f:: with SMTP id v15mr4358171ioj.93.1564940050963;
 Sun, 04 Aug 2019 10:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <87a7cpw3on.fsf@concordia.ellerman.id.au>
In-Reply-To: <87a7cpw3on.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 10:34:00 -0700
Message-ID: <CAADWXX-B=twNfqs=2hbp0UFpnhqmUDMFZA3tjXFEjDp2dAD_YA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-3 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, santosh@fossix.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 4:49 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull some more powerpc fixes for 5.3:

Hmm. This was caught by the gmail spam-filter for some reason. I don't
see anything particularly different from your normal pull requests, so
don't ask me why.

The fact that you have no email authentication (dkim/spf/whatever) for
your email address tends to make gmail more suspicious of emails, so
it's probably then some random other pattern that just happened to
trigger it.

I do check my spam fairly religiously, so it's not like it's usually a
problem - and I obviously marked it as ham to hopefully teach gmail
the error of its ways. So this is just a heads up.

But if you do have the possibility of enabling DKIM or similar on
ellerman.id.au, then that is always a good thing, of course. I hate
spam, even even if DKIM and friends certainly aren't perfect, they are
better than nothing.

                Linus
