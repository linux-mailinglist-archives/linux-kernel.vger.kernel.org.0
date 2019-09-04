Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD92A7A21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 06:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfIDEm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 00:42:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33370 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfIDEm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:42:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so10524295pgn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJ8WdF3ild99tEEbygL0ot0ojOVW2zZpc22ATe0+scs=;
        b=oO0EEfo+NTHRhTnLZ2TXj73Y+Y5GdZgVkd6bW6YHmvfBv8r3Vx4i2UgUcS17mbwY9J
         oiQ2cOHPkHUOZbZu1UR+HKXgF/URLa1Kt0cImQCG2YscIuUATWWZ6NiqsBNv2/Pu3cSB
         qHg6Qep7XO5gvsL6CSL5ewPwE6tLxb7yCFKDbCa2pHzBrSZtZvaNtbPW4RFQzMbFTrzq
         llWvO8keys/KHsAzcu3Gf9YREwRGulM7IcvFcZDXJvGAQpXUXH2/TMhjxhbxZSpSYk6U
         sawXDddaVKICrTuFOM9IBeh4CD+qH8xqd5W6yRTt80Lv0UYtKOBD9AbWH9ETAl7Gs7p1
         AhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJ8WdF3ild99tEEbygL0ot0ojOVW2zZpc22ATe0+scs=;
        b=BGzmqrmaHYaryaip9pVJbrWTTDynhfkhOOLGXXvNdINf4sf8eb2QaDiIj/mARwHM41
         DA/i5uifHpAyf9DCByvTgD7XcRdUwC2411wXO6HBpWZTibKPOI9WUD/OcN6sWfgQTLS2
         p8oxhmiDefhQq7mTbzpv8U4qTWRsFeig7uBusKn6IcARV1AxeL453ReNp9wMbQLEjOYi
         NdJaBsIR8ja8NPd8XSR/DYo+UZrY9YgYz1LxKO7ug4zMRmJI5+Egjrw5u0dfwQdYuw1e
         1fKYZ0+P25CadoCbk/fuT48BZKricNszGVwK15Xe/C5oatOWPw2i8CJ7gyMJEf3ZhcoL
         Jk4g==
X-Gm-Message-State: APjAAAUTz789AXacKYgXJigzx0f3spCmHuTAAOHrWFWrmiSoBHiuRTSg
        TyHHQBFj72QDOMFv16/Z54Aexw==
X-Google-Smtp-Source: APXvYqwlDQvDhrlYU+PPzl7Wz1eVzTvoMLivDLt4Y8P3QfWIcjArp1vqAtQHDmvzExwjprOpgNHWsA==
X-Received: by 2002:a17:90a:2182:: with SMTP id q2mr3124104pjc.56.1567572177000;
        Tue, 03 Sep 2019 21:42:57 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q8sm1136479pjd.28.2019.09.03.21.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:42:56 -0700 (PDT)
Date:   Tue, 3 Sep 2019 21:42:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        rishabhb@codeaurora.org, Evan Green <evgreen@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] soc: qcom: llcc cleanups
Message-ID: <20190904044252.GD3081@tuxbook-pro>
References: <20190718130238.11324-1-vivek.gautam@codeaurora.org>
 <CAFp+6iE7224G4k8XE6Oz1S82iMgSza-n_zMN-ppOUWnuz+hFLQ@mail.gmail.com>
 <CAFp+6iE6zwrOUoCoOJO0mgYJGrWj+wUjXQ7RnxSPsV34ndYGbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iE6zwrOUoCoOJO0mgYJGrWj+wUjXQ7RnxSPsV34ndYGbw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Aug 04:01 PDT 2019, Vivek Gautam wrote:

> On Fri, Aug 2, 2019 at 11:43 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> >
> > On Thu, Jul 18, 2019 at 6:33 PM Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> > >
> > > To better support future versions of llcc, consolidating the
> > > driver to llcc-qcom driver file, and taking care of the dependencies.
> > > v1 series is availale at:
> > > https://lore.kernel.org/patchwork/patch/1099573/
> > >
> > > Changes since v1:
> > > Addressing Bjorn's comments -
> > >  * Not using llcc-plat as the platform driver rather using a single
> > >    driver file now - llcc-qcom.
> > >  * Removed SCT_ENTRY macro.
> > >  * Moved few structure definitions from include/linux path to llcc-qcom
> > >    driver as they are not exposed to other subsystems.
> >
> > Hi Bjorn,
> >
> > How does this cleanup look now? Let me know if there are any
> > improvements to make here.
> >
> 
> Hi Bjorn,
> 
> Are you planning to pull this series in the next merge window?
> There's a dt patch as well for llcc on sdm845 [1] that has been lying around.
> 
> Let me know if you have concerns with this series. I will be happy to
> incorporate the suggestions.
> 

No concerns, this is exactly what we discussed before. Sorry for missing
it. I've picked the patches now.

> [1] https://lore.kernel.org/patchwork/patch/1099318/
> 

This is part of the v5.4 pull request.

Thanks,
Bjorn

> Thanks & Regards
> Vivek
> 
> > Best Regards
> > Vivek
> > >
> > > Vivek Gautam (3):
> > >   soc: qcom: llcc cleanup to get rid of sdm845 specific driver file
> > >   soc: qcom: Rename llcc-slice to llcc-qcom
> > >   soc: qcom: Make llcc-qcom a generic driver
> > >
> > >  drivers/soc/qcom/Kconfig                       |  14 +--
> > >  drivers/soc/qcom/Makefile                      |   3 +-
> > >  drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c} | 155 +++++++++++++++++++++++--
> > >  drivers/soc/qcom/llcc-sdm845.c                 | 100 ----------------
> > >  include/linux/soc/qcom/llcc-qcom.h             | 104 -----------------
> > >  5 files changed, 152 insertions(+), 224 deletions(-)
> > >  rename drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c} (64%)
> > >  delete mode 100644 drivers/soc/qcom/llcc-sdm845.c
> > >
> 
> 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
