Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F48115B0D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 06:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLGFIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Dec 2019 00:08:02 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:40143 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfLGFIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 00:08:02 -0500
Received: by mail-io1-f47.google.com with SMTP id x1so9507293iop.7;
        Fri, 06 Dec 2019 21:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZjCU4j3sL53untxnLZNdDSh0qNqfLN8e+bQHEuZ5dE=;
        b=e/7O6x16LI/cuCQ9VTwPI5Qk6hyKut98AIxqbVAVLXFnPUZszlL1F8MV0zeOlzDw98
         HNsphd3/kuZeVUnk/l+0GmPBjf3+I51JSETHKJ5xNFY202XDoSOAIsX0gWRf/m7vu3Xq
         kMmZ2dECX7IZhWY9XsT+MbFZCfSxV9drsJHQUEd+wbcl5J3b7Lo/a8seWTM7Yq3dzOsP
         U9oQc4brO84vwhqY+ZCjjwQ1qi2dc8fnhzkTFfZeHrPLoO7umCQtmN5/Kbz8MZ5tlSON
         rnwU7Z5V8M3R6LRjkh3sGIAllgXm1L8stfF4hlxW/dyYp8s2KF5q91MoguFmdFMmmYeH
         6ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZjCU4j3sL53untxnLZNdDSh0qNqfLN8e+bQHEuZ5dE=;
        b=nYolNh/94vzHhutV3XTnJM1eDurxog4C4QxXMYNmHQjsSjo6AxWWSLZCwbLbHENbkg
         /QWYx2R2x7aCaSi+OLRZP9Azz3LzUDPgomsiJsAnCJHXHMFkXB8D0Y8+SuZUHTvw20Zs
         MZR4cfahhNFJuSWALOXMlvvdFq9fxgNUf3316MilEcqsbe1xjVqkaQzIfWEJy7fA01ar
         AU0PfRZTyq3Wz1Yd1Mss/Og98E8S9JWcAhIr9ACvud/WLdsIqy0aby51jGG3ny3DDu5e
         9CCsmYb2f2TtGMba9cUP5q7No3wH8c9lSJqxsU6iycyuwfurMF5zqUA6zZSTQAtWlzET
         LxZg==
X-Gm-Message-State: APjAAAUnsjQ8qiPyQCmpVpG8vzlxk8t2vihPH1lOkTL5yYvOhqitgEBf
        beIPcTAQ+//8tMo8qYyjaoyevP+E5Mq+MGJ9twM=
X-Google-Smtp-Source: APXvYqyhs07MAWwbyQaZm+/Kp7saX8qenn+0uk1OjJl5k3oO2GPkxDDzBSxlGDoe37fLgle+eEbXq0/21fu5UFYXzcs=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr8633311iom.6.1575695281133;
 Fri, 06 Dec 2019 21:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20191206184536.2507-1-linux.amoon@gmail.com> <1765889.rfqrfT1PbY@phil>
In-Reply-To: <1765889.rfqrfT1PbY@phil>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Dec 2019 10:37:49 +0530
Message-ID: <CANAwSgT_k5VgtQcP_vOX4Goa-9_B6GmXP+i-hAwpZuTRVTPt_Q@mail.gmail.com>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Sat, 7 Dec 2019 at 04:02, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Anand,
>
> Am Freitag, 6. Dezember 2019, 19:45:28 CET schrieb Anand Moon:
> > Most of the RK3399 SBC boards do not perform clean
> > shutdown and clean reboot.
> >
> > These patches try to help resolve the issue with proper
> > shutdown by turning off the PMIC.
> >
> > For reference
> > RK805 PMCI data sheet:
> > [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
> > RK808 PMIC data sheet:
> > [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
> > RK817 PMIC data sheet:
> > [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf
> > RK818 PMIC data sheet:
> > [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
> >
> > Reboot issue:
> > My guess is that we need to some proper sequence of
> > setting to PMCI to perform clean.
> >
> > If you have any input please share them.
>
> The rk8xx pmics may not on all devices be responsible for powering down
> the device. That is what the system-power-controller dt-property is for.
>
> So that property is there for a reason - to indicate that the pmic is
> responsible for power-off-handling.
>
> Heiko
>

Ok, my intent was to have common framework for
shutdown, restart, suspend, resume routines.

-Anand
