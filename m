Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96881803F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbfHCCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 22:23:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfHCCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 22:23:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so34318956plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9sYWgEPT8Sdr7FL6Fm9O/QuS9QywLUzbJLmD+bnYaoQ=;
        b=VImJtTaoLmH/hfmh60bvWcXjmHb5gZKvABwLKSvF//alKzkiCRQI1sFTFeKMS6UctJ
         FuSDQGzy+ZA4Py4HbWAocqCN9wzHAgOOE7wvWJPD8Axn1RSYZsIWC/PD8/3fzb9JT+IF
         RiiaF4dO2kM0JFLpHTgTrxStdgwmd2UDlUIpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9sYWgEPT8Sdr7FL6Fm9O/QuS9QywLUzbJLmD+bnYaoQ=;
        b=n41/dc79BBIPg2W3ft2o0/4FkWHVGjMAo1VWJ3/qfim/ApjTDqoAhlLPjyWrRmEr84
         WHF52me96SNMCc74SBzUxpemqBQtyBlSQrQuOdJzPoBZlyEnmFQN+osFbPsswGUf1EA2
         USdOrvWGrmc5jCk1utUy4ddRwPV/bkTdAHIpJMVtd+vzHU4Tdr4df87lxku/9zsK3jus
         mzyeI39+Eo4NoL1pfV5HMuZl1ajX1P5GexsrgnrnFauegWNpNMy6oGrQQawuFNmR/JyZ
         /LkfIbNllEiqlDT77gLfqmmml3LWcEUB6tldoJmN0Z1tKrv5GJbW7RukDnkg+kb3TMlI
         znHg==
X-Gm-Message-State: APjAAAV/VAway2a17Pmv9zwp9QReJi/wfeTZiAuLjcEUiaKOdu9MV+4x
        tztc/Fg97+9A/cDBnDbYvoLNLA==
X-Google-Smtp-Source: APXvYqwnHrEKmPSGBPT/ZnkkSA04AoOhYUplAsrkXw87vI+OsBBuDhu0UvHw+2l46Nha58SVuc3f1A==
X-Received: by 2002:a17:902:b285:: with SMTP id u5mr45126914plr.329.1564798989145;
        Fri, 02 Aug 2019 19:23:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm7754049pjs.31.2019.08.02.19.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 19:23:08 -0700 (PDT)
Date:   Fri, 2 Aug 2019 19:23:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 4/6] lib/refcount: Move bulk of REFCOUNT_FULL
 implementation into header
Message-ID: <201908021915.95BD6B26FC@keescook>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-5-will@kernel.org>
 <20190802185222.GD2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802185222.GD2349@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:52:22PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 11:09:58AM +0100, Will Deacon wrote:
> > In an effort to improve performance of the REFCOUNT_FULL implementation,
> > move the bulk of its functions into linux/refcount.h. This allows them
> > to be inlined in the same way as if they had been provided via
> > CONFIG_ARCH_HAS_REFCOUNT.
> 
> Hehe, they started out this way, then Linus said to stuff them in a C
> file :-)

I asked this at the time and didn't quite get a straight answer; Linus's
request was private:

https://lore.kernel.org/lkml/20170213180020.GK6500@twins.programming.kicks-ass.net/

It seemed sensible to me (then and now) to have them be inline if there
were so many performance concerns about it, etc. Was it just the image
size bloat due to the WARNs? So... since we're back to this topic. Why
should they not be inline?

-- 
Kees Cook
