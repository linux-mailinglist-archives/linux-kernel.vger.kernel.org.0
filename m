Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E43109BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 11:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKZKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 05:06:43 -0500
Received: from foss.arm.com ([217.140.110.172]:60566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfKZKGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F5E30E;
        Tue, 26 Nov 2019 02:06:42 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208703F52E;
        Tue, 26 Nov 2019 02:06:41 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:06:38 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qperret@google.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
Message-ID: <20191126100638.pbcxnii67fihkb3g@e107158-lin.cambridge.arm.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191124222051.kbb62phfsln5ixg4@e107158-lin.cambridge.arm.com>
 <c76d2b10-c4a8-465e-9310-030efe75a64e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c76d2b10-c4a8-465e-9310-030efe75a64e@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 17:33, Valentin Schneider wrote:
> With cgroups, I do recall something about allowing the cgroup *knobs* to be
> inverted, but AFAICT that gets sanitized when it trickles down to the
> scheduler via cpu_util_update_eff():
> 
>     eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);

I missed that we cap here too.

> 
> So I don't see how inversion could happen within uclamp_task_util().
> Patrick, any chance you could light up my torch?

I think I am equally confused now. A clarification that can help improving the
comment would be useful.

Thanks

--
Qais Yousef
