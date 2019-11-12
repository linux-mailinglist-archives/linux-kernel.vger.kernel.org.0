Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45F3F8994
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 08:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKLHUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 02:20:53 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45449 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:20:53 -0500
Received: by mail-lf1-f53.google.com with SMTP id v8so11898825lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du/YNqhL0+IJPhD1R9mUXMVQ5rI34kWUejTlm7RxC2Y=;
        b=odHLQ2L6iOrh0QwukNjVBfVVGZ/n4B8uRPrvCWk2O2Z5vF99bJ66cjXCjDxQvu6k14
         r4jJM0qib49mhyLZDsH7PiqcIT4Zp48ocracmA9l5z/HFdMfJzVJJv+cv+dKJOheR21s
         9lYjBS/W7Rx/jZZBIYkGmxhPreP+sJI1INQsgB2xBI/3fcbtQBHD5VUkn67+oJswcYsU
         QvHpmIPiJO4ym52VvAsSNII3XjP33dt6kSO84i8+HdlLJhrBbYiCaHCDiRirrh7McZbA
         oeReL6QmQ05xeR+cNIXDe3CStrqzY1b59YsjhhPdr34d+pWIJQM+UAVpwainOmeGNE7m
         7x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du/YNqhL0+IJPhD1R9mUXMVQ5rI34kWUejTlm7RxC2Y=;
        b=cuJNV5ZVsDmT202shu0jiqoID44P3NUWR0DuRMKCNDdAptbzlAheaisW8czmoIt4du
         KuS6yP2M5dmeskrF2rh/MQ0zZvCVxMiqfnw5BK53B/NekjyIsEmt5AWTDXofrnzx29ho
         HRxjPutbWZE06xjM2Ntx4rKc73Fnv8oKWQR7wgBoNGF0erSd2bV73lTUufiTpxACOaKS
         Z4/JGb89sXCLCt6ISlhbLYhhRgeofReEbnOpwCEQoBSPXrFXkCci+K5LwJYB2uIVFVF4
         e+SzsV9PrnA0lmCDOFLe3fmLVYe+SiBIg4lvNcFl3kjFg5RjbW9GaJPJCfUUh9VCe32t
         fDiQ==
X-Gm-Message-State: APjAAAUrEHfMrPhTeiIKWtCLKSlAKiNk8lk/pwQS0MdOYYqlVSNqfJ2v
        IWHyYqKGMZM4mZEwKQPCtMPVX6y9gywLNtp1SGAXttDR
X-Google-Smtp-Source: APXvYqz7UXqx1DK6mjR0LTQCmCq2MfZDcMGBksjhYpF6K+8RB0fRGYJs616TYhZBGckjr0OxZHTrFm7iH74q63GAOHI=
X-Received: by 2002:a19:791a:: with SMTP id u26mr2211087lfc.192.1573543251070;
 Mon, 11 Nov 2019 23:20:51 -0800 (PST)
MIME-Version: 1.0
References: <0100016e5ae0878e-7b9d1bef-b3be-4350-8823-440929ca4a81-000000@email.amazonses.com>
 <CA+G9fYt=+ymENJg1-m=F3BF8dn7mzxvt5Di34Jw5qFLBHXA5bA@mail.gmail.com>
 <20191111183059.GA1140707@kroah.com> <CAEUSe7-d35WPJnx1hduji80_aym53ztQi-EkCkvu7Kf3S0Wjwg@mail.gmail.com>
 <20191112051713.GB1160519@kroah.com>
In-Reply-To: <20191112051713.GB1160519@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Nov 2019 12:50:39 +0530
Message-ID: <CA+G9fYubrM2Qc9JxnfWkt1n=wYk1hbVL9UGEvQcXtB9kK=C7gg@mail.gmail.com>
Subject: Re: stable-rc 4.14.154-rc1/0d12dcf336c6: regressions detected in
 project stable v.4.14.y on OE - sanity
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 at 11:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > > Any chance you can bisect?
> >
> > Reverting 61dbb1f20417 ("mm, meminit: recalculate pcpu batch and high
> > limits after init completes") got the system working again.
>
> Yeah, I messed that one up :(
>
> I'm pushing out a -rc2 now to hopefully fix this up, thanks!

The -rc2 boot pass.
Full functional testing is in progress.

- Naresh
