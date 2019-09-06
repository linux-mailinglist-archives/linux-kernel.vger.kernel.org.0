Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB1AB1D4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390672AbfIFEzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 00:55:09 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40943 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfIFEzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:55:08 -0400
Received: by mail-vk1-f193.google.com with SMTP id d126so1011902vkf.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gxIWH0Z2/nc7EM+6BfjuISpsFajm8nKC3P95I4PSIk=;
        b=Gkvknkt1b8owSIyUje5r0ssZriQWhtSEiH5uUPU0W51hvEigEqcC+eAzkevDWGzZ9J
         G4O6uerwLfmsRXwLr+PxBQIHrn/7nSIo/Aq31HTZMVUwric3fHhbSjgTfVsk9YV/o+Wn
         3lEg72m+jme00C7mT/bbtYRgPn6fWuu7Rf2i3okbcHIOtUmpASzmtDsKeTAbPKNN0r/o
         0Li+5mHjyHzMANdaqgiezETL5PJVrOZiV2TxIZwYEKY930VphyGlBrc5qXbSyIXd1kQs
         HFoXfJbOrizbSFXiuiRqPZNoGnTRUM7IXUZC+OvpCzh8BB0nIVZ6Zzq2j4RBRwbuQKFW
         g19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gxIWH0Z2/nc7EM+6BfjuISpsFajm8nKC3P95I4PSIk=;
        b=GCCdcaspqqS2L7oG9C8yznRam1b9MsLx6PJdjCNRfTdZCi7C5/DDIoFZthQWA0k2ks
         ncxcNk5lmpGaMwdgatuMZjWBjK45DgVMRPVbtEtp7zOVUc5wOXNKcr7swHDAeaIbbv/w
         PvP7jikYo90tOpnEHL9mtUgBK5zY7NcdKmge1ic17tULOiyG92em0EV2qAAJVGKrMh2T
         RHfOy51VZ9EX9ims7l61CywoFYi5afZsGrB+vx1mmUUUFDva73NBUIUIxNIYpU8QEIu6
         BxAzKHNjcb6VqXmLd/BNAtwMuY2mYeUT/jKqlFatfaxFqmKoni6W04hwftCGpph8WP+C
         JEIQ==
X-Gm-Message-State: APjAAAVgGIVJcMvJz01SAbfjUEaTaEVfIc5a+0GvckjTuVzG8Ruh0m0w
        0aKDj8c8/9gKhmx/97Fnyj8EdjOPd+a5b2m8CwMVgtnQ
X-Google-Smtp-Source: APXvYqy+8Uy5jSjnaZ2NKBfl3MiDrPQ3f6jSQwHeh9wMPiMvhpEwKy58ZlLjpymDZWP8QmxqhTcJmsZixmWBF7tngb8=
X-Received: by 2002:ac5:cdad:: with SMTP id l13mr3412485vka.30.1567745707609;
 Thu, 05 Sep 2019 21:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190905121934.GA31853@ogabbay-VM> <20190905205017.GA25089@kroah.com>
 <CAFCwf12VtkZd-cd7A+dznWx70ydjdxX7ahi7tn5CSGPoEcjexA@mail.gmail.com>
In-Reply-To: <CAFCwf12VtkZd-cd7A+dznWx70ydjdxX7ahi7tn5CSGPoEcjexA@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 6 Sep 2019 07:54:41 +0300
Message-ID: <CAFCwf12LurmKz0ek-fN-uCh5tXq95hHtkzRJ7_bxzvEK-mMsnA@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.4
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:38 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Thu, Sep 5, 2019 at 11:50 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 05, 2019 at 03:19:34PM +0300, Oded Gabbay wrote:
> > > Hello Greg,
> > >
> > > This is the pull request for habanalabs driver for kernel 5.4.
> > >
> > > It contains one major change, the creation of an additional char device
> > > per PCI device. In addition, there are some small changes and
> > > improvements.
> > >
> > > Please see the tag message for details on what this pull request contains.
> > >
> > > Thanks,
> > > Oded
> > >
> > > The following changes since commit 25ec8710d9c2cd4d0446ac60a72d388000d543e6:
> > >
> > >   w1: add DS2501, DS2502, DS2505 EPROM device driver (2019-09-04 14:34:31 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-09-05
> >
> > Is that a signed tag?  It doesn't seem to me like it is, have you always
> > sent unsigned tags?
> >
> > thanks,
> >
> > greg k-h
>
> It is unsigned. I have never sent you a signed tag.
>
> Thanks,
> Oded

Just to clarify. I have never sent a signed pull request. I'll look
now how to do it and re-send this pull request to you.
My only question is how do you verify my GPG key ? Do I need to
authenticate it somewhere ?

Thanks,
Oded
