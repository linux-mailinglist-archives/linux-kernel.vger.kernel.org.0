Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E611098E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfEAOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 10:46:12 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37418 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfEAOqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:46:12 -0400
Received: by mail-ot1-f47.google.com with SMTP id r20so13804452otg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mean50VLm+Ltg1ziPZdYCm7+U49ZnbbE0jixdd/cy0k=;
        b=EuZYyAbEXhDX3NX22m5vtTI/l2EQZDXA0UkrGpfrpPip7Wnx3tOs9TNb87ijtjA1N7
         Q+Qi4l5PJqqMStLjUmtvi2YvkCcPEb5EoskucFLQToCdQ78RupAX5zkWnJy810iPjWdw
         y7GBfFU1rbrIr0wFpfR70HjSRAol/h26bFTcZUK9KTlXdX8hwI0F9W84CkIyvjIOmnxh
         PlNerHi87ZMnxjVsb+GPBgmuy2wm93tCsGxK+pwUWFM0QqXFFAqXDjOCHC0JPjDFI12c
         uXxJGowLdnBj1jhJTdQAywq8V5KcsOampjy/PVGNDNgDTA5kXWVJu1BVoRR72YaARCQf
         r7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mean50VLm+Ltg1ziPZdYCm7+U49ZnbbE0jixdd/cy0k=;
        b=FveXWMH3q4OEPfFg/kgYlIxW01tOXchfJxKjob+4HOAPp47TuPWdb95Zy0951cfNGO
         4w1gcDyu0XcEuJgdF3K+PyGmM2/dF1O72HvateP9fTw4zQ+0ZaBGgzE2x3EIZn+VbpCi
         jae8HIgZiZmd4qn9/7rZIpucMO0pQxDkm0yo8/j9fExBxMbdHmbLVB1evyhlYu9F1PsD
         MRJkaALkRn6rQS6jvLJNTITTQRJvoUj1QECH3Nj06+CpbChJM5k21SZBJx+1hBW5aRVO
         yrOtyi98xmwVoUFnoJSJ2WYdnk7temGQNvGKO4lSZYmL4+3U+w0lpDQMXT2UxXkeGMVL
         i41w==
X-Gm-Message-State: APjAAAXBvGq7IPWp1ul9W+QoOXDvGmTtgKB8PGx9gZFnwVdn0ZHQrZKX
        FXBgmOiWZW9s/b/CholR/DhNZmKMJuVcWMwBPqh+lg==
X-Google-Smtp-Source: APXvYqwUHSRvz9ag5AOqu6flAFRoXst5Dx8uASfN3YMKHW3QrlzwBzSPWqAs/BNqjdGiNyEk1dysEEWAgcBVsZ/vfcY=
X-Received: by 2002:a9d:7319:: with SMTP id e25mr2112796otk.279.1556721971685;
 Wed, 01 May 2019 07:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190501140624.6931-1-TheSven73@gmail.com> <20190501142332.GA13008@kroah.com>
 <CAGngYiXAz-10BtMs6K1mNwHgakK=U80hX4+Cf6tG8Vc3Ag=NOA@mail.gmail.com> <20190501144321.GB31461@kroah.com>
In-Reply-To: <20190501144321.GB31461@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 May 2019 10:46:00 -0400
Message-ID: <CAGngYiX6-VWLus5uxey0EqANYTL=EJJTyQUCDA4juNfwm_6Anw@mail.gmail.com>
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > What infrastructure do you trust? GitHub?
>
> Hahahahahahaha

Okay, maybe I wasn't completely innocent when I suggested
that one :)

>
> If you want a kernel.org account, so that you can have a development
> tree there for future work, I suggest you apply for one.
>

I will, thank you for the suggestion !
