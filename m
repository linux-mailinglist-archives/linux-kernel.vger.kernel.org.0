Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81E157892
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 02:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfF0AxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 20:53:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37030 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfF0Acq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:32:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so627507qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w03qy6EFSZddlaeR4XXdByXLhXgkUgXil3c6GHJxhvU=;
        b=D5wRjxHq9V5XbBgZSnROW+7DALOrUfCiALI8vABHmruViVFI0BRgspDKxnC0HJ5HT2
         2HA4bSMYcmJ79NZlDerGsvkniJ9FTvqcEe17W+wpYWqKKBRI/9ocf3rsBrF/osJJSbmW
         JZOQjYpfnFOVm9Yu0Dpgy/tjUjQMRGr6xKCQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w03qy6EFSZddlaeR4XXdByXLhXgkUgXil3c6GHJxhvU=;
        b=nuHkTi0lu1s6bxgzB/D9nwGMQ+X7ImWzXOc412DiOv5B5p3Kmoa1d7vASj9TBtqbfJ
         ZLnXcQKC84VmSkmjEVNeVHoTQcbj6fEH/BS2DnA8RnJLDbHbWN2SirCjB3bfFmegMDzG
         3591Y4CkYC0UYaCv8RkWqAZoXvWq8GLRR62uoqVf196ZAsE5UiCw3sJ4JrLGlCKkc0XE
         n3bNXiz1+G7m66Xcja/CCrXR9I4jE+aa7wN2+oYtW9iNgVLqNJkppG7j4rm3KCGFdpQG
         lHfTrw5QzUMAi1WgBgXXrA9zvFa3UjlBQMus0D4YQuSBtGDPXTkPGUk/DMclYH9zMdDM
         GziA==
X-Gm-Message-State: APjAAAWXD5KHxfUIuRL5nHBbdtiK86xLT87yZH3l50tmdqRI9IoSjtcF
        WC5soo/vUDrfXx42CjpMNON7cqscjcezux1XYkhtXbkd1cM=
X-Google-Smtp-Source: APXvYqwBiufSpaNS4K0NRDMFfS68Z7VQqnw29e4Y3PdeVHTHONuH06tjKC8sgyVCBx0XYwXFHzsWTD7QTp1HGjEJ65s=
X-Received: by 2002:a0c:9591:: with SMTP id s17mr674217qvs.100.1561595565741;
 Wed, 26 Jun 2019 17:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235011.7b449eb0@canb.auug.org.au> <CACRpkdaHyb=o=9YzSvKWRbbyPCbsOUxC=zoz+acnTWNvp=vu5w@mail.gmail.com>
In-Reply-To: <CACRpkdaHyb=o=9YzSvKWRbbyPCbsOUxC=zoz+acnTWNvp=vu5w@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 27 Jun 2019 08:32:34 +0800
Message-ID: <CANMq1KCUfsKdJD8=DKR7ya-zhV0fgpHBi=PUtD030nFo8k9_ng@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:11 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 26, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > In commit
> >
> >   99fd24aa4a45 ("pinctrl: mediatek: Ignore interrupts that are wake only during resume")
> >
> > Fixes tag
> >
> >   Fixes: bf22ff45bed ("genirq: Avoid unnecessary low level irq function calls")
> >
> > has these problem(s):
> >
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >     or later) just making sure it is not set (or set to "auto").
>
> Thanks Stephen, fixed this.

Ouch, sorry, for some reasons I thought it was 10, not 12...

>
> Yours,
> Linus Walleij
