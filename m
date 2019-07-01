Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C12A66F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfEYSQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 14:16:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40460 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfEYSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:16:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so7205517pfn.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ii9WpqD7iEAJKDcuy2CpZ/y9+8YtSKEyLsD7jWsNAQ=;
        b=E3O488YVP8TgapmTW0WHrHr5ag7JIOkw2T6nXC6lEd/a1hMULi+DdyrxSINGbd5xGc
         sUSAbhzND1I0stBU7o+1u8mSI48Daarvhj55rAbL/1vhpivBXI190VPU+y9L/pcIWJE7
         bfKWvxY68+2gtByETnQ9w6hEowzfxRrG02eW82rPQv2LvVXCXiPU7lyvE6g0LNSGY7OR
         kCGHOkkSESFeOZNhP6ieNVyxpo4H2sAbr6pAee6pLlSnvADsydU2iLqzalTMy1kol+f8
         +yb/AaoYxpNYnw7UkoFrVGy95QbvWwZnwiPtvDT5gCN88MtAHn3HaUy3ya6MRiAyKObS
         errQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ii9WpqD7iEAJKDcuy2CpZ/y9+8YtSKEyLsD7jWsNAQ=;
        b=cW0AXAaN6hVpX0ErqwICkYiIIyU/mSIsXITzXyjIM+C/UV0WQH5ZqBDpJVSXxM/J06
         KLrsZFXLL34R4djrfeLWmg8U4NWKABNPzwxyFKq+3GRy4y/s3dNqELShCpHd1QPepTRB
         KXdlPGofDGykggae/5+JzOxDS0HJiQhxPYcvzDx1J8K1cZOa4hKCSt7TeqFzJQwTxp9S
         YU7L7dBTm8lFzf69Ra2h6ZFZOtPWylknl6pQ0/ePQZiCvN/tdcmn7bWBBYIlIQdWJxym
         rgjoErQxpVpYnASzmQJ1WZ3OfwAC2Stc9KPekShF5m9Qt3UMXZuBTYXo2iqn6dZ5sIR9
         ILzg==
X-Gm-Message-State: APjAAAVg281Cg9cuja9zPlLldIQ6Tf9Nz+s79cmXp8FBsevB4EOACG8o
        z/XtXapg+ecQRm5uKqqMTVeq/A==
X-Google-Smtp-Source: APXvYqxBA7lJ3zAgZZL0FnYp4GQtRBbRIxVuoz1SqGkSgJaOy62aJMDPdmEgBEATozTa5f+xEy64mQ==
X-Received: by 2002:aa7:8dc3:: with SMTP id j3mr123366686pfr.141.1558808207644;
        Sat, 25 May 2019 11:16:47 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i101sm6691470pje.9.2019.05.25.11.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 11:16:46 -0700 (PDT)
Date:   Sat, 25 May 2019 11:17:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] soc: qcom: Add AOSS QMP driver
Message-ID: <20190525181714.GI2085@tuxbook-pro>
References: <20190501043734.26706-1-bjorn.andersson@linaro.org>
 <20190501043734.26706-3-bjorn.andersson@linaro.org>
 <3d2c61ca-b91b-fdc7-7837-af6a3b71af7e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2c61ca-b91b-fdc7-7837-af6a3b71af7e@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 25 May 10:53 PDT 2019, Sai Prakash Ranjan wrote:

> On 5/1/2019 10:07 AM, Bjorn Andersson wrote:
> > The Always On Subsystem (AOSS) Qualcomm Messaging Protocol (QMP) driver
> > is used to communicate with the AOSS for certain side-channel requests,
> > that are not available through the RPMh interface.
> > 
> > The communication is a very simple synchronous mechanism of messages
> > being written in message RAM and a doorbell in the AOSS is rung. As the
> > AOSS has processed the message length is cleared and an interrupt is
> > fired by the AOSS as acknowledgment.
> > 
> > The driver exposes the QDSS clock as a clock and the low-power state
> > associated with the remoteprocs in the system as a set of power-domains.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v6:
> > - Squash the pd into the same driver as the communication, to simplify
> >    the interaction.
> > - Representing the QDSS clocks as a clock/power domain turns out to
> >    cascade into a request to make all Coresight drivers have a secondary
> >    compatible to replace the required bus clock with a required power
> >    domain. So in v7 this is exposed as a clock instead.
> > - Some error checking updates, as reported by Doug.
> > 
> 
> Thanks for the patch Bjorn.
> Tested the QDSS functionality on SDM845 based Cheza board with this
> change and it works just fine.
> 
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Thanks for the confirmation Sai!

Regards,
Bjorn
