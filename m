Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32452A229
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 02:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfEYAyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 20:54:50 -0400
Received: from ozlabs.org ([203.11.71.1]:42955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfEYAyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:54:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 459lBb45HVz9sB8; Sat, 25 May 2019 10:54:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3202e35ec1c8fc19cea24253ff83edf702a60a02
X-Patchwork-Hint: ignore
In-Reply-To: <20190511024217.4013-2-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, peterz@infradead.org,
        jolsa@redhat.com, maddy@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 2/2] powerpc/perf: Fix mmcra corruption by bhrb_filter
Message-Id: <459lBb45HVz9sB8@ozlabs.org>
Date:   Sat, 25 May 2019 10:54:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 02:42:17 UTC, Ravi Bangoria wrote:
> Consider a scenario where user creates two events:
> 
>   1st event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   This sets cpuhw->bhrb_filter to 0 and returns valid fd.
> 
>   2nd event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_CALL;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   It overrides cpuhw->bhrb_filter to -1 and returns with error.
> 
> Now if power_pmu_enable() gets called by any path other than
> power_pmu_add(), ppmu->config_bhrb(-1) will set mmcra to -1.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3202e35ec1c8fc19cea24253ff83edf7

cheers
