Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C3A180CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 01:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCKAdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 20:33:39 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36623 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbgCKAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:33:39 -0400
Received: by mail-vk1-f196.google.com with SMTP id a1so56544vkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxH5+n+OF84tRnMGKQoWLmnpALEgESPXC5UHvwTMSf8=;
        b=ETcU1G0+wCTWkKAAgJm34FOejXTx3bxmVvyioKYfTBLbHe7z4LICWw4054fhrE9/DC
         E2iS4LcBtQ7H/yswrnKl0PHhGCyyk5ThESoxcS/n30wBXy1sNgpIcC3GyEs9F5EM5va/
         9Zq3pUsAm7QSeJBR23FX2QvDu7IyeLajYzs6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxH5+n+OF84tRnMGKQoWLmnpALEgESPXC5UHvwTMSf8=;
        b=AV+7GadumSbM4N5X1pb2vTBhyPwRDEg8WhmkkaBmzJuwsBfQeRCCYl7Tsp3kg9JOT+
         DOiSQB7TvTBK0Jum29rq3VCZF9DkkpcQVpPknJThMFV7vcUi4ItqhS5mnUmYavLjv0sf
         EUpLGYhGPigDuCNJ7ecuWJnrwYJNiotu3CwlgMbkUeNS05w5+fruKf2c7mnI19vDCYqJ
         lGuyI0NZBq9dIYghCM+hN28mQFtnX5LK33LA+hfzfSAOkfov6ySpGV6CtHtRy3VwIiRX
         DYLFIdk4s/Gw/Q0U6Wi1nNxTpqCH3+rDqxOaRAfo9F5Q/PKLc63wei7VFAnZ5gl8Up26
         PYCg==
X-Gm-Message-State: ANhLgQ03VMhlUh153ZxPFlp9aVAH33/cMsfegRGRIOKd1VwzsaQJvDj3
        lbDdbSeYvK2GiGKWBlT9pPyz0RFj+wo=
X-Google-Smtp-Source: ADFU+vtPGwssp+KXiMSZfAsBnqDA2Jd+xtnLuZWfv9YWxlxlVUypnw6WhZQ4JydjRz00YdqXgAkjVw==
X-Received: by 2002:a1f:2d4f:: with SMTP id t76mr541910vkt.58.1583886817449;
        Tue, 10 Mar 2020 17:33:37 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id v4sm857132vkg.17.2020.03.10.17.33.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 17:33:36 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id a19so220567vsp.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:33:36 -0700 (PDT)
X-Received: by 2002:a67:e98e:: with SMTP id b14mr474974vso.106.1583886815626;
 Tue, 10 Mar 2020 17:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200306235951.214678-1-dianders@chromium.org> <20200306155707.RFT.6.Icf2213131ea652087f100129359052c83601f8b0@changeid>
In-Reply-To: <20200306155707.RFT.6.Icf2213131ea652087f100129359052c83601f8b0@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Mar 2020 17:33:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0OX-HFK8jcj5HU9_f9tPq13GEZpc7er2knMYS6sdDNA@mail.gmail.com>
Message-ID: <CAD=FV=U0OX-HFK8jcj5HU9_f9tPq13GEZpc7er2knMYS6sdDNA@mail.gmail.com>
Subject: Re: [RFT PATCH 6/9] drivers: qcom: rpmh-rsc: Only use "tcs_in_use"
 for ACTIVE_ONLY
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
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

On Fri, Mar 6, 2020 at 4:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> From trawling through the code (see the "A lot of comments" change) I
> found that "tcs_in_use" was only kept up-to-date for ACTIVE_ONLY TCSs.
> ...yet tcs_is_free() was checking the variable called from
> tcs_invalidate() and tcs_invalidate() is only used for non-ACTIVE_ONLY
> TCSs.
>
> Let's change tcs_invalidate() to just check the "RSC_DRV_STATUS"
> register, which was presumably the important part.
>
> It also feels like for ACTIVE_ONLY TCSs that it probably wasn't
> important to check the "RSC_DRV_STATUS".  We'll keep doing it just in
> case but we'll add a warning if it ever actually mattered.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

After other RPMH email threads, it's possible that this patch isn't
quite right.  ...but also the code wasn't quite right before.

Specifically if we have 0 active TCSs then it's possible that we've
used a wake TCS to send an active-only request.  That would be a case
where "tcs_in_use" might be set and we'd need to make sure that
tcs_invalidate() checks it.  However:

1. We need to add locking to tcs_invalidate() since "tcs_in_use" is
protected by drv->lock and tcs_invalidate() didn't grab that lock.

2. We should add documentation explaining the situation.


I'm still waiting on overall review / testing of my series, but I'll
put it on my list to address this for v2.

-Doug
