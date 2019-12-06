Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA28115587
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 17:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLFQgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 11:36:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44666 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLFQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:36:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so8251909lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Do9Ixinmx7DWrqug5u9w6tASXApuWJdCd8LeAbdsBIQ=;
        b=TsZ6bc64rxzpqunpmQ9zZj07Ax4iRTEptSrLKQ+dpVUS7CBbthGk73RbR1sKm/ihVS
         Eiu+u06rthCiI6Gi7wf98K8KH8EWHvaP55qYJ0K04+L5SVwB+3JbhhE3zfvQOBdm3lBQ
         NJvk6wvXUxT1Wq8K6Re8tvnM9+Fq8zS+NOsTDH2SWIMDRPbfTbWoDpZVKislSid2cofB
         3uFp3q8ehVxp+1Kolsh0EWEkVcd3Qvjw/RKIsL9kVkDaFj9yalOgX5VDEszCHN6R/g3F
         uuNno5rQX5O07PJ3HvM0q5RCl3TYwMUHEfwXJJLchW8zq4VPmq+uqNeE1sCRKru0fuSL
         ed4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Do9Ixinmx7DWrqug5u9w6tASXApuWJdCd8LeAbdsBIQ=;
        b=OMTzhm/ion+q2kmqPNVMTDPPfCqRLOWOS6qsT/hK/4uc2GR3bsbWHOSCnKOCun8L7u
         5Qplqq+jCt/JQtP6lVeVZSFrR5gT89L2zGxfV6aDpaNYtzrntXLbKR14gHXXLlmiw2yn
         nq96PjMnEjYZDgET2vSXF9KY7NCbhQTZSz49n6UTn9gNUjo5XgVZn+2h+kOwzGC5hCj+
         mPg5GeZ1MXkzIlg85Y4iY1gQjX1T4fflnBRLNwVP8XNpXFhJte5A5u6QQOZKN3cTNvPu
         4Zpgl0eExQWQCamfgdeC/iEwTuIeC0valbXW2kTPdWcfHwkw+WD+nqz8IJiz48ptOY1Z
         FWmg==
X-Gm-Message-State: APjAAAV+4pktel8ZNLMFMSzcG3iO5O/IwvfBd0B6v4Z1PHl10OQGfSMJ
        bB/0rHF5t/QLDE4d3nS9PAai8A==
X-Google-Smtp-Source: APXvYqzFPZuwpYdyHCsG+D27+XkuBdXIZhP2CbCq8CsSbLiJU4568yp5Ua0bb5hzl4F2nEum2wccHg==
X-Received: by 2002:a2e:9b52:: with SMTP id o18mr8955227ljj.205.1575650179665;
        Fri, 06 Dec 2019 08:36:19 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id k5sm2572559lfd.86.2019.12.06.08.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 08:36:18 -0800 (PST)
Date:   Fri, 6 Dec 2019 08:29:19 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys fixes for v5.4 (take two)
Message-ID: <20191206162919.vilrybgbiewdl4d2@localhost>
References: <20191115105353.GA26176@jax>
 <20191116234048.oas2rlfwxlz65jvp@localhost>
 <CAHUa44EQ-1SUd0dDBp43_EGPMPArq_g8=1hSKZ3EC0uELUKH_A@mail.gmail.com>
 <CAHUa44FaxiMrGwOLPrej_zMrVFyBExfPTqeHfYfocpc8x8LzLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44FaxiMrGwOLPrej_zMrVFyBExfPTqeHfYfocpc8x8LzLg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:57:47AM +0100, Jens Wiklander wrote:
> Hi Olof,
> 
> On Sun, Nov 17, 2019 at 3:22 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Sun, Nov 17, 2019 at 12:45 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > On Fri, Nov 15, 2019 at 11:53:53AM +0100, Jens Wiklander wrote:
> > > > Hello arm-soc maintainers,
> > > >
> > > > Please pull these OP-TEE driver fixes. There's one user-after-free issue if
> > > > in the error handling path when the OP-TEE driver is initializing. There's
> > > > also one fix to to register dynamically allocated shared memory needed by
> > > > kernel clients communicating with secure world via memory references.
> > > >
> > > > "tee: optee: Fix dynamic shm pool allocations" is now from version 2 which
> > > > includes a fix up with a small but vital dependency.
> > > >
> > > > If you think it's too late for v5.4 please queue this for v5.5 instead.
> > >
> > > Hi,
> > >
> > > I noticed you based this on -rc3 -- all our other branches are on -rc2 or
> > > older.
> >
> > I'm sorry, I thought -rc3 was old enough. I'll stick to -rc2 or older
> > in next time.
> >
> > >
> > > Anyway, I brought this in to the fixes branch, it's the only thing we have
> > > queued up at this time so I'll give it a few days in -next before I send it in.
> 
> It looks like the two patches in this pull request
> (https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=tee-fixes-for-v5.4)
> are still in -next and haven't got any further. Is there anything
> wrong? Something I should fix?

They were in our fixes branch and didn't go in yet, but will shortly.


-Olof
