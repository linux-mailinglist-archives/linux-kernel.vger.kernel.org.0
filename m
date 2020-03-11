Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2987F181C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgCKP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:28:04 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40069 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:28:03 -0400
Received: by mail-vs1-f65.google.com with SMTP id c18so1580416vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWfoJ++8ba1UjJJUVze4Ap8/nfBrdlx1lp2jUW3YMEE=;
        b=VaTdB4gGQXtHFKnMc5YJsrQoRMocOFN/rEEd6koLEz3uw5WqcjPmsIjqeq8UK/D/B3
         xmWX9mBMlHCrJooFkw1YpDK59iB4JB1Bs7d1/AHjJI01+3E3IZ74Z4lD3CSBRjChbPnF
         /7Q5naIvmbpPbdtQs1JIPb5+R+aol2eAoU99c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWfoJ++8ba1UjJJUVze4Ap8/nfBrdlx1lp2jUW3YMEE=;
        b=h27kP8eudFoImd7Y9jHU2lGfr41qibJwIKyxYeG9NxZZp1LIj3AGdnC7gOmtXZFDCN
         3WdDErjR3cN+uMtcKdtrobF63aj4QeMyhQm1OXgZK/h8aZfV/yw/j4R1AnomNGrS34Uq
         KDgmYdg2YNdalvN/GD+Wfk916ks92VhQE//xl+aae53enO5h3mX4qfZvkQtRSdbVolhm
         5LABwhSpK0TbZrLDfaeeysjBDyLKAg/ZH9XfbRbODh5EPq7TTsGbVDGqsMbbZKE1WHBK
         nKm2jvu5kp03s/oAS5+n+hJpTtPWV86Z++Rihnkodt4LvE1FV9AaY/7bzKzmFZOoljvQ
         r+rQ==
X-Gm-Message-State: ANhLgQ1+6mggFTMgMRJTzLWsehJYAqpPZL6q/MtG6sE8Cp1C53Xr4RS0
        dlAl8R8r9+POwth4uyX24JdYeGWEt/w=
X-Google-Smtp-Source: ADFU+vuz3VORhy+9j2w/IWfqr6jimfzwflK2RoEoaezHNa/IQaIO9OW6TnyyhrYZlzF6tKmRmd61AA==
X-Received: by 2002:a67:8a05:: with SMTP id m5mr2354074vsd.206.1583940481757;
        Wed, 11 Mar 2020 08:28:01 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id g1sm9848514uak.5.2020.03.11.08.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:27:59 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id g21so877023uaj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:27:57 -0700 (PDT)
X-Received: by 2002:ab0:1653:: with SMTP id l19mr2128010uae.8.1583940476081;
 Wed, 11 Mar 2020 08:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200306235951.214678-1-dianders@chromium.org>
 <20200306155707.RFT.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid> <285d3315-7558-d9f6-fe65-24d8ad07949d@codeaurora.org>
In-Reply-To: <285d3315-7558-d9f6-fe65-24d8ad07949d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Mar 2020 08:27:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W5RGwu=ywtM7aCv3H-EpJ1i23S0awgVc8QtOsXtige4w@mail.gmail.com>
Message-ID: <CAD=FV=W5RGwu=ywtM7aCv3H-EpJ1i23S0awgVc8QtOsXtige4w@mail.gmail.com>
Subject: Re: [RFT PATCH 2/9] drivers: qcom: rpmh-rsc: Document the register
 layout better
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 11, 2020 at 2:35 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi Doug,
>
> On 3/7/2020 5:29 AM, Douglas Anderson wrote:
> > Perhaps it's just me, it took a really long time to understand what
> > the register layout of rpmh-rsc was just from the #defines.
> i don't understand why register layout is so important for you to understand?
>
> besides, i think all required registers are properly named with #define
>
> for e.g.
> /* Register offsets */
> #define RSC_DRV_IRQ_ENABLE              0x00
> #define RSC_DRV_IRQ_STATUS              0x04
> #define RSC_DRV_IRQ_CLEAR               0x08
>
> now when you want to enable/disable irq in driver code, its pretty simple to figure out
> that we need to read/write at RSC_DRV_IRQ_ENABLE offset.

It's not the specific layout that's important to me.  It's the
relationships between everything.  In other words:

a) one rpmh-rsc contains some registers and then a whole bunch of TCS blocks

b) one TCS block contains some registers and space for up to 16 commands.

c) each command has a handful of registers

Nothing describes this in the existing code--you've gotta read through
all the code and figure out how it's reading/writing registers to
figure it out.


> this seems unnecessary change to me, can you please drop this when you spin v2?

In v2 I'll replace this with the prose below.  Personally I find this
inferior to the struct definitions which are easier to read
at-a-glance, but it seems like it would be less controversial...

/*
 * Here's a high level overview of how all the registers in RPMH work
 * together:
 *
 * - The main rpmh-rsc address is the base of a register space that can
 *   be used to find overall configuration of the hardware
 *   (DRV_PRNT_CHLD_CONFIG).  Also found within the rpmh-rsc register
 *   space are all the TCS blocks.  The offset of the TCS blocks is
 *   specified in the device tree by "qcom,tcs-offset" and used to
 *   compute tcs_base.
 * - TCS blocks come one after another.  Type, count, and order are
 *   specified by the device tree as "qcom,tcs-config".
 * - Each TCS block has some registers, then space for up to 16 commands.
 *   Note that though address space is reserved for 16 commands, fewer
 *   might be present.  See ncpt (num cmds per TCS).
 * - The first TCS block is special in that it has registers to control
 *   interrupts (RSC_DRV_IRQ_XXX).  Space for these registers is reserved
 *   in all TCS blocks to make the math easier, but only the first one
 *   matters.
 */

I'll also move the documentation of "irq_clear", "cmd_wait_for_cmpl",
"status", and "cmd_enable" next to the respective #defines.
