Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32C119468F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 19:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgCZSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 14:34:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34896 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCZSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:34:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id t25so6470034oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvcRbO8JiiH8TflCF3JYY64FRuv850T5VBR+zKWVaAo=;
        b=D5KANnoUgA813LQvHjIp5rAoPhY2gTJup4nP+xGLb5FNmM7+8RNwum/ue1O95T+xWb
         5Ktbnl2iWEXVoCU3oOQg1rH6QozCfngfrmRO501JFNyUSHuo2dqvZagSkuCv/ZkCcdDy
         9SNPpYOLAEHYsE4N1CYsv1lw2JsDmzr3bO5CAhprXa6CHmJ/wgf3TslEjhp5iWSPZbla
         6EGwewp3bw3kVgK1ceZl6cCzyM58RIqxXE7Ece2gV1Bkyopg2Mdv5j42z6O1C0vGsEb+
         xUlK8kqOpBq79qowMpVYE7dI2KBF+1Bmk+h2mEbeqaCTkXHdCSEol6R1AyJ6SpC3NLmt
         slKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvcRbO8JiiH8TflCF3JYY64FRuv850T5VBR+zKWVaAo=;
        b=rEfutk6FXlKeIUyZqAFojiPIEcrfNIwcpOcEyXyV0dE/e4WACWiuiTcdR8qD5rHOGe
         dZcyTKMAuMj1zLvnoxwfyQHm6JJLPG/ijBhgiWv1t7/332YuCOVgm664PHyQZ+7wh3ZY
         /6UqutLCgQ7BE3roIxOwXBbqvnnXavyukdHw3woOcACP2JCud6t6cnLZM6IHXVQ7TyFp
         fZeldq6R8R3+BVGm6VQENTmfRoganKtZsQllDGeWezGfp7dfo3yCtHOOaWVOACbV1B3g
         FBnOPj8WUadcwvq/CnIbZa84FJLdDmnvehg7JZKDgYNxrXouB7Kj7GsggAfRN9gVp3AX
         N6oQ==
X-Gm-Message-State: ANhLgQ16rNNYEqVKsg5XN36GYeXd3bfv+zECV11GN9Bue5H7KD8iVM8Z
        pPU2sdxAtas9odK4XFYhiHU5/cHVlltf/Ld0zZrkrg==
X-Google-Smtp-Source: ADFU+vuhr19j1Gh9BuMJvyrUH94cq/bHJXqm/DeIzQEZemccehjW6KDkcmRhHiQOfwXBWmMBVCeLo1LvtVagEPcJ2FU=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1218807oih.172.1585247660202;
 Thu, 26 Mar 2020 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <1584973502-14775-1-git-send-email-ppvk@codeaurora.org> <c17d8842-0e1d-0014-b909-3114952b350b@codeaurora.org>
In-Reply-To: <c17d8842-0e1d-0014-b909-3114952b350b@codeaurora.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 11:33:44 -0700
Message-ID: <CAGETcx_GD4K9CKyUtJEHKtAjHFKdfrepT0ZdA9WfRoUCF+QKPg@mail.gmail.com>
Subject: Re: [RFC v6 0/2] Add SDHC interconnect bandwidth scaling
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Pradeep P V K <ppvk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        adrian.hunter@intel.com, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>, mka@chromium.org,
        linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        linux-mmc-owner@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:22 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Adding Viresh and Saravana,
>
> On 3/23/2020 7:55 PM, Pradeep P V K wrote:
> > Add interconnect bandwidths for SDHC driver using OPP framework that
> > is required by SDHC driver based on the clock frequency and bus width
> > of the card. Otherwise, the system clocks may run at minimum clock
> > speed and thus affecting the performance.
> >
> > This change is based on
> > [RFC] mmc: host: sdhci-msm: Use the interconnect API
> > (https://lkml.org/lkml/2018/10/11/499) and
> >
> > [PATCH v6] Introduce Bandwidth OPPs for interconnects
> > (https://lkml.org/lkml/2019/12/6/740)
>
> Pradeep, since your series seems to depend on the above proposed bw bindings,
> can you post the DT changes for the platform that you are testing these
> patches on?
>
> Please note that the above series is currently deadlocked [1][2] with no clear path
> forward for now, so looking at how you plan to use this might throw some light onto
> the requirements
>
> [1] https://lkml.org/lkml/2020/1/14/511
> [2] https://lkml.org/lkml/2020/3/20/106

Sorry, not deadlocked. Just kinda busy. For [1] I believe I agreed
with Viresh later on. I'll respond to [2] soon.

-Saravana

>
> >
> > Pradeep P V K (2):
> >    mmc: sdhci-msm: Add interconnect bus bandwidth scaling support
> >    dt-bindings: mmc: sdhci-msm: Add interconnect BW scaling strings
> >
> >   .../devicetree/bindings/mmc/sdhci-msm.txt          |  18 ++
> >   drivers/mmc/host/sdhci-msm.c                       | 240 ++++++++++++++++++++-
> >   2 files changed, 254 insertions(+), 4 deletions(-)
> >
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
