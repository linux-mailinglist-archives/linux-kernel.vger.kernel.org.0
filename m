Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7BA29F40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391734AbfEXTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 15:42:47 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39207 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391698AbfEXTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:42:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id m1so6627647vsr.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhfSnlcb3x0OEuOnYAwcBMXnyJQgUsGnRJ+13Y0a02s=;
        b=kzEow1LScPr0enEDbSBaWZVHM+oGAipxBS3m7HV5oQz7OQNb3t2AmVYQZBUQYUhexI
         TsS9HO6+u4FcWXx7elZE7xdqB6g40xn4EvHS6xv2hem9W0knfP5zMmNdYApaESDksFIC
         d7rlSo+5FRrv6voyWPr8P32El2IIflL0sukfXL39lSFLXvoV1C4i9i3vQlY9h3apOE2x
         dM2chmb/A9ysLdANeNazZhjzvq/2p0QOnYevhi4AqOvbVH7C4EubFmiLWP/mTjdcVaw5
         699KF0NYSqKzCqGiVbt+l3Vu1dAfOY+pfVYGeDAKXuggBVAlqp2uhJwBuHVq9Z4O0lEI
         7onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhfSnlcb3x0OEuOnYAwcBMXnyJQgUsGnRJ+13Y0a02s=;
        b=pXP9V7skNCmf1RhqDf6xOa+I+Q6y3hJ4+U/IWz5L7J0YHbTt7T8Y56AUY7HgwHeRzA
         Sh28tHlkAHSuyFPwmsKSFklK4VATC8tsW7kJwUsIDiIruM36cG6sIDx2CmiblIV6aH+n
         esonNnwcM9vWnLZIAhTbxUNw18q+M0qRJVtwr3Rt+Y+71uIX5sXlsZYO0+Y4YsXiUIzW
         nXhH1NdpAjMzk5i/MWCnx8+iyN9ltom0CfC+vLfu32AUou6e81bi0M2s6kYcCeugnD70
         eIVlm85iBaI92nYS5tWI5hpeSTneOFtQ9/UxJGSCzBzsTeHCifFS860UFy5NknRu2a2h
         PZnw==
X-Gm-Message-State: APjAAAWfXyxZr0rKdthXQIW6A+UALi8zThZNf+x+bE9X9sCYBQPWBgAX
        F4LcA8yKP6Ogw3WqAVhVfqzcxYX4SJ7vhkMZsbalG0iz
X-Google-Smtp-Source: APXvYqydhFkJ5j/OYLRQSG1qS83AsM1W3XSP0BUpGur6e6gs1XAx8XpWdRBGVAmAC0ZEBLOdixV/zcoMo3xKq2J539Q=
X-Received: by 2002:a67:b408:: with SMTP id x8mr17258650vsl.236.1558726965545;
 Fri, 24 May 2019 12:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190524175324.GA3024@ogabbay-VM> <20190524180122.GA27745@kroah.com>
In-Reply-To: <20190524180122.GA27745@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 24 May 2019 22:42:21 +0300
Message-ID: <CAFCwf12CKwuD-ciA0N+uE+k2iPJPgnbcZ9LbHYiLeBM_oG4wUw@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes for 5.2-rc2/3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 9:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 24, 2019 at 08:53:24PM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This is the pull request containing fixes for 5.2-rc2/3.
> >
> > It supersedes the pull request from 12/5, so you can discard that pull
> > request, as I see you didn't merge it anyway.
> >
> > It contains 3 fixes and 1 change to a new IOCTL that was introduced to
> > kernel 5.2 in the previous pull requests.
> >
> > See the tag comment for more details.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit b0576f9ecb5c51e9932531d23c447b2739261841:
> >
> >   misc: sgi-xp: Properly initialize buf in xpc_get_rsvd_page_pa (2019-05-24 19:00:54 +0200)
>
> Wait, that is my char-misc-testing branch, which moves to char-misc-next, not char-misc-linus.
>
> Please rebase this series on char-misc-linus, as the patches in
> char-misc-testing are NOT for 5.2-final.
>
> thanks,
>
> greg k-h

sure, np.
I'll remember this from now on.

Oded
