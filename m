Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55958766EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfGZNGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGZNGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:06:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1245218D4;
        Fri, 26 Jul 2019 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564146405;
        bh=wy90VSu21JsNlVD4p9aROU7aEivMN9wBYYTtojIdGuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T0cPsAPNe8K0N153hhhClYfBNU/9g1TYS9J14wsei7fNcElNIaZqDT3mTzxNdvb/h
         64NRjFkUXZBRz4k5ATbS46cxZdTCjIuBUDamPdioHsSi8B22Wsw3NMr5H6/kuj9FsM
         l5gjkIaNuY5HiXfkLfLTVBkhrhDeElef1P9wY0U0=
Date:   Fri, 26 Jul 2019 14:06:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH] arm_pmu: Mark expected switch fall-through
Message-ID: <20190726130641.dp3qrvyhsote5iu3@willie-the-truck>
References: <20190726112737.19309-1-anders.roxell@linaro.org>
 <20190726122956.GC26088@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726122956.GC26088@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:29:56PM +0100, Mark Rutland wrote:
> On Fri, Jul 26, 2019 at 01:27:37PM +0200, Anders Roxell wrote:
> > When fall-through warnings was enabled by default the following warning
> > was starting to show up:
> > 
> > ../drivers/perf/arm_pmu.c: In function ‘cpu_pm_pmu_notify’:
> > ../drivers/perf/arm_pmu.c:726:3: warning: this statement may fall
> >  through [-Wimplicit-fallthrough=]
> >    cpu_pm_pmu_setup(armpmu, cmd);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/perf/arm_pmu.c:727:2: note: here
> >   case CPU_PM_ENTER_FAILED:
> >   ^~~~
> > 
> > Rework so that the compiler doesn't warn about fall-through.
> > 
> > Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> > 
> > I'm not convinced that this is the correct patch to fix this issue.
> > However, I can't see why we do 'armpmu->start(armpmu);' only in 'case
> > CPU_PM_ENTER_FAILED' and why we not call function cpu_pm_pmu_setup()
> > there also, since in cpu_pm_pmu_setup() has a case prepared for
> > CPU_PM_ENTER_FAILED.
> 
> I agree, think that should be:
> 
> 	case CPU_PM_EXIT:
> 	case CPU_PM_ENTER_FAILED:
> 		cpu_pm_pmu_setup(armpmu, cmd);
> 		armpmu->start(armpmu);
> 		break;
> 
> ... so that we re-start the events before we start the PMU.
> 
> That would be a fix for commit:
> 
>   da4e4f18afe0f372 ("drivers/perf: arm_pmu: implement CPU_PM notifier")

Does seem about right, but I'd like Lorenzo's ack on this.

Will
