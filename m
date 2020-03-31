Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C56199C74
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgCaRDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 13:03:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43614 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:03:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id v23so8327614ply.10;
        Tue, 31 Mar 2020 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yd9n/NfdsWvDzatSM9dtUbvLNgnkRjCRYnyN7pRmUEQ=;
        b=gv8h7sxTrDW1QebkmyoO0dEycs7UO33dS5tzWDiZkRVNgptE2srgn/MfIfhJb3M7FY
         F2sftAjYfhwknJlxyGJHZiHOOdJkh/8oUeh8vUywbFp8IKpeYznJdMyk6PDT+VHRMdoK
         jceSkSCZ9p+USu8jU2UMXf8oBR/PrzBPdgs2LS/M7zq6yB9Qr5ATaRIt3Nd8b4+e6fLl
         tpE8GGiiCNm0Tu+BX7GTNC2bqzj78Cok85f2/fpL1XTCnKEgtY9Bf2Fem4AEAOleAeNq
         OvlY3P0as+iKodwlTeK5aqT+9Jf9ZEHI64HNI0+cLa4xxSUJ/ls3hQJ+ChqvOe+ajsyV
         VMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yd9n/NfdsWvDzatSM9dtUbvLNgnkRjCRYnyN7pRmUEQ=;
        b=XGJfz7hH8BCghqX2nZgjLNct+q2L6T0EzeRRVDcAcDOn3XfIbK2HbMRhHRctpxzuIy
         OiWPCFPrBlHFg6qrFUB/Yxx2MhloRBlGT0Uu0vyFELYpAXN5C5FeDCc30zdNvZWGjp+H
         t+OjAO7JywgVm2LpQo1dHSLLdFIXTwdAKUhMoDi/Y91ZHxasVptaZQ+nFJPmTTiU3wK+
         R6hkStbjsoGtWAheYzmCXsSB4DtSICegPghlHX2W/A8E8RFpQVS+srK2Y+wFNC0X/MbO
         nrTlifWlP8CE8zODa9dTLpYZJsP8jH9XdJq71Ez8lUccycUbGjarHfcp+AFtnZjeTnZ9
         48VA==
X-Gm-Message-State: AGi0PuZcmLb72mQG39jQ/QKJ0yamvyR2Gtzlumxwi7VYcVZ9i3FffBB7
        PyAb3RdoQ46tzpecS/sIkR1OWMIG4h5C/U3xP8o=
X-Google-Smtp-Source: APiQypKc8qQ6HBvaOsQ3Oispy2HlVpP7rEMYHP2bwe8eR3GDSAy4awCO0zPuJDT0XWYG0F5MgTZBza69yOugN9vng74=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr3023640pjy.1.1585674197234;
 Tue, 31 Mar 2020 10:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170132.17275-1-grant.likely@arm.com> <20200331143355.GP1922688@smile.fi.intel.com>
 <20200331164340.GA1821785@kroah.com>
In-Reply-To: <20200331164340.GA1821785@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:03:10 +0300
Message-ID: <CAHp75VfHHdn46t852RfUbo9Y5mMU8vn-kvDo3yx656TwQyuSiw@mail.gmail.com>
Subject: Re: [PATCH] Add documentation on meaning of -EPROBE_DEFER
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Grant Likely <grant.likely@arm.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 7:46 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 31, 2020 at 05:33:55PM +0300, Andy Shevchenko wrote:
> > On Fri, Mar 27, 2020 at 05:01:32PM +0000, Grant Likely wrote:
> > > Add a bit of documentation on what it means when a driver .probe() hook
> > > returns the -EPROBE_DEFER error code, including the limitation that
> > > -EPROBE_DEFER should be returned as early as possible, before the driver
> > > starts to register child devices.
> > >
> > > Also: minor markup fixes in the same file
> >
> > Greg, can we at least for time being have this documented, means applied?
>
> It's the middle of the merge window, you know I can't take anything in
> my trees until after -rc1 is out.

Right.

> I will queue it up then, thanks.

Thank you!

-- 
With Best Regards,
Andy Shevchenko
