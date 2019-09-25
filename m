Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87982BE1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbfIYP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 11:59:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfIYP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:59:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so7588590wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naNd+UbuwtuRUJ+hSZ/C3jQPhykR0AxG78EDGMaa2LM=;
        b=L1BePPlCUZpe2lX0UtRdIuCIcnLWgeVOPYD2Lp7LY0LoqFtNrL4X0/X2HhHBnJIIW5
         0l3fT48O5RocQnemwjC+x7f+0O5EckSy/o9G5zysJ6Wvn6zrF7U/FesWvHLYy6bnA1hs
         gJHcRpT7gDFR6m/Gw4u0TDVSr49K731xfz1zBS8iSzjnGhWo23eljfAfO0B66v5uIQyG
         Oimer8qmPyV6il2K+KvMa4PVhwG16odQRFMFisN4A+U3JO7HjlIK3XD36II7kQ/5tAgl
         lQtHW4OS5+GAuImuvnWam0jSWIHwmcW0N48tDWIPoA+4NW2ZLC6u+u4hb4y2IYCvOOHJ
         P4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naNd+UbuwtuRUJ+hSZ/C3jQPhykR0AxG78EDGMaa2LM=;
        b=dhbsQOATKqvGcSJ5KRhlw94b4OKD2F2e36DvpWQWYF+eA5gx/qYeFoVAmtOvRpd4VX
         U+rrLtcgXHI1EZcBUQ5pIA2CA+m8PMLpEg9FOhEa1qnWRHdghQQywOhXpWuR4U3ilkWb
         C4hkxLFMWmtBJdqXrHHORsQwI89k0PO3vIsmN9fVJuC18sj2T0NJPqZlzc35mMJO7SZN
         iKE3Q5YcaGLnAet9q5l76caCLwAlxxw8ADbc82GZ4Ic1oTow1MbSp0xNzZhz3Mko7U8W
         RTuI+G/wZBmid0SSQn/3LKbQiZRRtlpR6Uqw2+Ak+fbwuYmrAClqusZ1/0lPiqwA8ObO
         U9XQ==
X-Gm-Message-State: APjAAAWxQ+mz3xCNrBJE8qn6vtJ/wYlqaKCsmtb+wHO1y61doJ63CDBA
        qdacMrSa38bKTHDUWPo1to+XQkarvfNfZP14VmiuhpnwcMs=
X-Google-Smtp-Source: APXvYqwL1znvfk7TBINMdkWf85DjqJPbGaGlO87KnDbqkPYVRPiOVZeOJJ7pMwC9hczBzv96t6tV3biwRtRfnQ7Ti5I=
X-Received: by 2002:adf:fb11:: with SMTP id c17mr10712460wrr.0.1569427138407;
 Wed, 25 Sep 2019 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <7f05a25a-36c7-929c-484d-bc964587917c@arm.com> <CAKv+Gu9EvwM22HaFJvX55HQhptcNUoQZCxq3nxyzquUjcq6DUg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9EvwM22HaFJvX55HQhptcNUoQZCxq3nxyzquUjcq6DUg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 25 Sep 2019 17:58:47 +0200
Message-ID: <CAKv+Gu_-zGLaZfWb5r-yrMjh-cST+zvL7HrYV8ubf9ch0m4oqw@mail.gmail.com>
Subject: Re: Problems with arm64 compat vdso
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 at 18:41, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 20 Sep 2019 at 18:33, Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > Hi Will,
> >
> > thank you for reporting this.
> >
> > On 20/09/2019 15:27, Will Deacon wrote:
> > > Hi Vincenzo,
> > >
> > > I've been running into a few issues with the COMPAT vDSO. Please could
> > > you have a look?
> > >
> >
> > I will be at Linux Recipes next week. I will look at this with priority when I
> > come back.
> >
>
> Hi all,
>
> I noticed another issue: I build out of tree, and the VDSO gets
> rebuilt every time I build the kernel, even if I haven't made any
> changes to the source tree at all.
>
> Could you please look into that as well? (once you get around to it)
>

I haven't managed to reproduce this on a fresh checkout, so it looks
like this is a transient thing.
