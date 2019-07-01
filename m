Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7420676
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 14:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEPLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:54:58 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39114 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEPLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:54:57 -0400
Received: by mail-vk1-f193.google.com with SMTP id t18so935588vkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gw9Ghc+xQrqh42btkF+tSwScblo1M5MvWvdVH4TT7i0=;
        b=v26qoU6H8L1eKcYMoea7paIcbwqKfFyFfh4g29/LlGR6+AUpIUNU3bNE8s3wyNQJKd
         kQCGJb9CAIQ2AgFYlk0SLoUn4HsoNoh0eNBdhek1FO+tVLDcJ5NcdPQjy6BRdvLxlaQK
         0aIlSfSssyMkTz7GipBksDjARihKegYcNTAz8t5xd/SHkEavzcNuZ/+vIVV1I/nndpea
         MP06okMhU0f1Athz5O6dl7kceRU43aFcm0qDLB0uMM12eSEiS6XTppcIe0Y4FZn/2rV1
         GuoBk8CKXPPLoHvogkLGbVn8coLEnYox/LkyrDuG7ZQXRrykgKDd2NWvR7GV7av2PyfU
         /tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gw9Ghc+xQrqh42btkF+tSwScblo1M5MvWvdVH4TT7i0=;
        b=OxwjtVNNfMJlaBuxPpubNwRUg9lRDCFkeUfWJJFHSPFjuFVLAKLpFuyp3M4t0FJWwS
         /G/LbGoO1kqlsa3Byg3fwC7FFIkPD1/iJxdCmlO9C7AnUJaoyxwx34RNGcYfUZR35jGB
         rFom1JvgO9e4b+EFcfksqxT9ISHM4tZj8T226whZC3E051HHepjwnTNfKNsaqiasnwLj
         /TzNeEX+6SXscCjcuj9BkOzioxAHledLt5/Q2EpujbgiVJOC0TwwZfk2SLcnikXjGLow
         fScbp+jTGIB8FugKnYQgI+8QQf+A6CFrtDVvgxfIcXD+dOK0xaKD2/mOr1cDrhi3ntPk
         1U0w==
X-Gm-Message-State: APjAAAVH0szqVJpiIyk0JJ5QPUQrG0ccpHUb2QfqCTZxXoGhf7WNWB6X
        8yoiJ5Dw/cMOvbWYb/OnxEJ8PYPVSvfzZXHKrnZ/Ig==
X-Google-Smtp-Source: APXvYqy+0i0NCLJY9mu7r+K0u56+d0TTe1O6WRw/Ai9J8XZgwGaPKyF4TLUj8e80gKzDj9M2oxm9yBWBX3AdrhjAKaY=
X-Received: by 2002:a1f:812:: with SMTP id 18mr22833450vki.68.1558007696693;
 Thu, 16 May 2019 04:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190114184255.258318-1-mka@chromium.org> <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com>
 <CAHLCerPZ0Y-rkeMa_7BJWtR4g5af2vwfPY9FgOuvpUTJG3rf7g@mail.gmail.com> <155786856719.14659.2902538189660269078@swboyd.mtv.corp.google.com>
In-Reply-To: <155786856719.14659.2902538189660269078@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 16 May 2019 17:24:45 +0530
Message-ID: <CAHLCerP69Jw27VyO+ek4Fe3-2fDiOejtz6XZPykPSRA2G1831w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Andy's correct email address)

On Wed, May 15, 2019 at 2:46 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-05-13 04:54:12)
> > On Mon, May 13, 2019 at 4:31 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > On Tue, Jan 15, 2019 at 12:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
> > > > ("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
> > > > that describes this topology.
> > >
> > > This is partly true. There are two groups of gold and silver cores,
> > > but AFAICT they are in a single cluster, not two separate ones. SDM845
> > > is one of the early examples of ARM's Dynamiq architecture.
> > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > >
> > > I noticed that this patch sneaked through for this merge window but
> > > perhaps we can whip up a quick fix for -rc2?
> > >
> >
> > And please find attached a patch to fix this up. Andy, since this
> > hasn't landed yet (can we still squash this into the original patch?),
> > I couldn't add a Fixes tag.
> >
>
> I had the same concern. Thanks for catching this. I suspect this must
> cause some problem for IPA given that it can't discern between the big
> and little "power clusters"?

Both EAS and IPA, I believe. It influences the scheduler's view of the
the topology.

> Either way,
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks.

Andy/Bjorn, can we squeeze this in for -rc2 as a bugfix?

Regards,
Amit
