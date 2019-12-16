Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38C120510
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLPMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:09:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36898 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfLPMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:09:40 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so3951795vsq.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R41bi6yGX1iFZADmCtGFAtslTM1p//RJUgDUHlg61M4=;
        b=f9FsYCC6hzMCeJ2TsROTECko+3MS0vbiOrA9N1RR5183cjmeTiP9e9Q7D3ysfb1CKi
         GP4eeMR4lOF5HpP4h7G1gGF6Tozadvflj2EwnEY07TrIQRRU7xQd5BUlWKbP1khStots
         TacxY60AnMM6HvZqiS4yy51nkGFlxH9T0CbirWXCaG2VU7yNUbXTRklnduKGN4so/r2Y
         IjMmpJnQ8FMC8pK0+J9qhQJSNIhPFC4RBARtyLEdZvVcdpFTgFYshG1BMv4UKTHK6Y1s
         7gHFfy9afxxhsdqnoi6mOTAXdietwZ6YK1kq+oJQVeR8QtFs0V1N1RP6Uf9a8xNHA5kG
         unVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R41bi6yGX1iFZADmCtGFAtslTM1p//RJUgDUHlg61M4=;
        b=e+zOpRF6uP5NolMqGYqg/xS12i0meGS3OfXR1SS36kEpU4P1tZqul5zXmZJObPqMQh
         QC3T4CjAXpuk/wdhSZUtNzBzO9LVvymytwuQkyAsGkuwH3i9jnpXPiiD4/lw8OJ8DFCj
         nlMXJUJoFqr/btWLbpF5Kt8Q9MGmGHmo1qExoZwtfH14P22mnxMjBb+ap/XSpjp8swKV
         fOs4Qj48vyGbJZvJfHRrqMiGw4uN8rSgEfnYT63baYrTPYamebXLnzAYkg7msvnNq38p
         DsHv+SYUAkmZuuijI+VTAuoSkYzzJXXYaseJzU8z8bvn1IW7B++ohLynGoN6DtM38GVn
         FBCA==
X-Gm-Message-State: APjAAAUfoUJci79c5YnO1VbUl/leUhWIfsJXHWtfw+wndkq6t0xccYiz
        voDpAWp+4npm3QOX13RdX4jgmAypHCqW7wHRlEJLNQ==
X-Google-Smtp-Source: APXvYqyM+BFHKKpccM+ztT4sO4U92WldyDbTPLgrN1RbEanMHjp2bB6PAG89agGyNwpzRp5oUphcx23VDVg4tfX63sQ=
X-Received: by 2002:a67:b649:: with SMTP id e9mr20077581vsm.34.1576498179745;
 Mon, 16 Dec 2019 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <0101016ea738eb52-8c362755-205a-4383-9181-1a867e82eeed-000000@us-west-2.amazonses.com>
 <CAPDyKFqdFc1RMNu38d7b+s2Bpr49v-w18frGsPSxsYf924HLWg@mail.gmail.com> <0101016ef47b4d25-49791932-586b-456e-b9a7-6f9a6f95babf-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016ef47b4d25-49791932-586b-456e-b9a7-6f9a6f95babf-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Dec 2019 13:09:03 +0100
Message-ID: <CAPDyKFqk75n9GE9JELgg=bnwjRHhTNkOMFLL01Y0X1NwgFgOYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Correct the offset and value for
 DDR_CONFIG register
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 at 11:22, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
>
> On 12/10/2019 3:21 PM, Ulf Hansson wrote:
> > On Tue, 26 Nov 2019 at 11:19, Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> >> The DDR_CONFIG register offset got updated after a specific
> >> minor version of sdcc V4. This offset change has not been properly
> >> taken care of while updating register changes for sdcc V5.
> >>
> >> Correcting proper offset for this register.
> >> Also updating this register value to reflect the recommended RCLK
> >> delay.
> >>
> >> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > I have applied this for fixes, however it seems like this should also
> > be tagged for stable, right?
>
>   Thank you. Yes, I agree.
>
> >
> > Is there a specific commit this fixes or should we just find the
> > version it applies to?
>
> It fixes the bug introduced by commit:
>
> f153588 (mmc: sdhci-msm: Define new Register address map)

Great, thanks added a fixes/stable tag.

[...]

Kind regards
Uffe
