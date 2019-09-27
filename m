Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFEC0BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfI0SuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:50:12 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41242 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0SuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:50:11 -0400
Received: by mail-vk1-f195.google.com with SMTP id 70so1433682vkz.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBZJx9mwfwKl/d1YIGsqXIQmYrQ0m8MFTpNwf6yagA8=;
        b=H5dEeRS9CP0jlYjImC6db5aNPKHty0p5YdWo3lugKh4Pm3xxuTRG24ERUjIcqA4E5b
         0/EItbxItxl9urEqAcfhdC9Gxdz8ADd8NAPx2x/sg0J5T0Pt0PNDSYjgy8DbbMjCM3MJ
         vLjyjqwCfGOmhAkYHDcW74kWilqiZIKjR5u+DKTVYcKgTvcyJ0HwVT3PkTLqEtnz7h2q
         2AuD/vYPdU2A1TXjqJdNeX3IypXUtfGOeq2PAmz6UvnEliGHnhnhwn3VBoYknS1o90Fo
         hcWNavv5mTmQ9Hsv75s6+/PZS91UY48ZayemO8AnHKsywI4CLdQ+N3NFFNRzALJ6AB5y
         +MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBZJx9mwfwKl/d1YIGsqXIQmYrQ0m8MFTpNwf6yagA8=;
        b=pJkRJIH9bnz2mFi7Wuv/OgnPxZnmnEar6BMaTjqYhgjsFNf/hy79jqTuo9YJ01TYoU
         ejDszu9Xus5RebP577Mx2oDSIbHF/JG96ye4h6MpWDByj/JVPDKU4OC4gy5/GI9mVBe1
         tLvxzmnrI/eKCaMPGA21iVUv8Ne4a6IjClFBXYZg3cb2BgXWSVwVigVvpgCKe5CwZojr
         GVXj8dYoos0SLzKWwAzECASWcA0ejB0bR8LHc4OkyCo0cxM6VdMdAA2Z8t62xpoYEz4l
         juiZKGonSUUWII9/VrPtzBmS/KxSvAZvkbg0BrheCMxSUkPSnRq2oyGaKNZmeJ6lP3Dz
         O+kA==
X-Gm-Message-State: APjAAAX/BBkAapLNfADg3HJz8dOgo0DotoKDnv1fsVl90Ps9H1UYZH4g
        snqpDu5TAT4MpvDRQsZeGe76j0WAO5k9/of9JLq06w==
X-Google-Smtp-Source: APXvYqzOU21WddncSc1IrWQHL6FdZMo/EgPppLvIw/h3P6j4sgxIB6VYfLntNv7P7g39dvDmRgnveUuUkEOhSIWpa5I=
X-Received: by 2002:a1f:da45:: with SMTP id r66mr5057255vkg.36.1569610208805;
 Fri, 27 Sep 2019 11:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568184581.git.benchuanggli@gmail.com> <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org> <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
 <20190923213925.GA19247@people.danlj.org>
In-Reply-To: <20190923213925.GA19247@people.danlj.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Sep 2019 20:49:31 +0200
Message-ID: <CAPDyKFqTtGAygYPQ-qJuBaU2YU8CU-OgZJyWSmAQYYtq5xnpvg@mail.gmail.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 at 23:39, Michael K. Johnson <johnsonm@danlj.org> wrote:
>
> On Wed, Sep 18, 2019 at 02:07:51PM +0300, Adrian Hunter wrote:
> > On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> > > I see that the first four patches made it into Linus's kernel
> > > yesterday. Is there any chance of this final patch that actually
> > > enables the hardware making it into another pull request still
> > > intended for 5.4?  Waiting on additional acked-by on Ben's work
> > > addressing all the review comments?
> ...
> > > On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
> > >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >>
> > >> Add support for the GL9750 and GL9755 chipsets.
> > >>
> > >> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
> > >> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
> > >> tuning flow for GL9750.
> > >
> >
> > It is OK by me:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Ulf,
>
> Sorry to be a bother... Is anything remaining for this work to make
> it into a second PR for 5.4 before the merge window closes?
>
> It would be really convenient for the microsd readers in
> current-generation thinkpads (for instance) to have hardware support out
> of the box without having to wait another kernel release cycle, if
> there's nothing otherwise remaining to change.  I confirmed that
> it currently applies cleanly on top of Linus's kernel.

I have applied this for fixes, so it will go in for 5.4, but perhaps I
need to defer my PR to after rc1 as I am still on the road.

Kind regards
Uffe
