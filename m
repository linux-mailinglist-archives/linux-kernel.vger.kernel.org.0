Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34353103133
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 02:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKTBgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 20:36:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34367 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKTBgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:36:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so12504368pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4o1Jpj7JdvYh/JDDjDtho7RQMCbF4Skfes37Qp34Ipc=;
        b=bGxau+nwG6uViXQ3fkwZ2B1CawtakorjCNBZo3/adAD9sc1Ah2mZfKWAAruEjkhe4S
         jD2ejZi8iHTVWbm03S9oePiVJsMHfwNSv2IaIC9/1lbFFaVpDGlLRPV3Ua+Y6H4xlLCe
         hVe8LlRVLoHFMXpHv1+LIVHn1EagCgUdUFf6Nk+PC2djvBrb0yGteMNtmkxUmebniLCT
         1bpV0Pj2OOWmVmLUfzPC2bLCCd5u6IkCLzQyIp9W6wEN6E7OT3noDCrp6LTddEOwWrvm
         X/ydoBt+ucn4gUDd54PRm4UybjM74dMkP62P+Ur4aY1kious4gFhOoxJRmI0eXydSnei
         gFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4o1Jpj7JdvYh/JDDjDtho7RQMCbF4Skfes37Qp34Ipc=;
        b=eZoL8WFL9sBq/IZKOtjCIdF6VWLZnzdPW+5fbPU/RZErgMceIQj9jM+w9ONlNAXWQa
         s8jnywoVg4NnnhFqtYhss21bNJFDaPIbcSrTAsEG+gLqpGrILXpYtrSj7xM/01F5pF3W
         Yv+2vDu6PXBdNb5jyM6Y23awgWBTLEbyArtv89SNnV3z5pVRvXzY3FeCeqVNYeYs70qG
         HitJiTzOMsUzPcjRNig2foBeLME+hR0MvxHXndDZkVMHrB4fpwYqwVRq6JtzxQqUNADl
         Q5k5CVjye6tTCtd6Zdcwy2AonK/AKOq0cxfC6XVvtWOhNCfUF2o9ACM8g0Apk4bcbApX
         9KKw==
X-Gm-Message-State: APjAAAV+zpK7HzsmDzY7DRBqoj0yCcmY3uvdEBBXORO0hvqVQQmq5qIE
        NTBftk1OxmyOdFJRzh1qLRT0iA==
X-Google-Smtp-Source: APXvYqwjbM0z46tTQR97VRUX4H0ZF9Pi/YMRqMtHDYKxyZl0UxOv03DKhWvyWVo9zgQlWwACKgAIPA==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr784841pfb.63.1574213771218;
        Tue, 19 Nov 2019 17:36:11 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f5sm4662235pjp.1.2019.11.19.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 17:36:10 -0800 (PST)
Date:   Tue, 19 Nov 2019 17:36:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: rpmhpd: Set 'active_only' for active only
 power domains
Message-ID: <20191120013608.GB3143381@builder>
References: <20190214173633.211000-1-dianders@chromium.org>
 <CAD=FV=WD4r-GAM6mnTg9qB04aaX7JJzHajhtb+N8Yq9UR1WZAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WD4r-GAM6mnTg9qB04aaX7JJzHajhtb+N8Yq9UR1WZAA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Nov 08:19 PST 2019, Doug Anderson wrote:

> Bjorn / Andy,
> 
> On Thu, Feb 14, 2019 at 9:36 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The 'active_only' attribute was accidentally never set to true for any
> > power domains meaning that all the code handling this attribute was
> > dead.
> >
> > NOTE that the RPM power domain code (as opposed to the RPMh one) gets
> > this right.
> >
> > Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/soc/qcom/rpmhpd.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Somehow this fell through the cracks and was never applied.  Can you
> pick it up?  Given that it's been a year and nobody has noticed this
> it seems like 5.5 is fine, but maybe you could add Cc: stable since it
> seems like something that stable trees would want...
> 
> Thanks!
> 

Thanks for noticing, I've picked this up.

Regards,
Bjorn
