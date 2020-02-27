Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4048B17173B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgB0Mbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 07:31:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgB0Mbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:31:37 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48SsVH2qCSz9sRY; Thu, 27 Feb 2020 23:31:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e08658a657f974590809290c62e889f0fd420200
In-Reply-To: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/watchpoint: Don't call dar_within_range() for Book3S
Message-Id: <48SsVH2qCSz9sRY@ozlabs.org>
Date:   Thu, 27 Feb 2020 23:31:34 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-22 at 08:20:49 UTC, Ravi Bangoria wrote:
> DAR is set to the first byte of overlap between actual access and
> watched range at DSI on Book3S processor. But actual access range
> might or might not be within user asked range. So for Book3S, it
> must not call dar_within_range().
> 
> This revert portion of commit 39413ae00967 ("powerpc/hw_breakpoints:
> Rewrite 8xx breakpoints to allow any address range size.").
> 
> Before patch:
>   # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
>   ...
>   TESTED: No overlap
>   FAILED: Partial overlap: 0 != 2
>   TESTED: Partial overlap
>   TESTED: No overlap
>   FAILED: Full overlap: 0 != 2
>   failure: perf_hwbreak
> 
> After patch:
>   TESTED: No overlap
>   TESTED: Partial overlap
>   TESTED: Partial overlap
>   TESTED: No overlap
>   TESTED: Full overlap
>   success: perf_hwbreak
> 
> Fixes: 39413ae00967 ("powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e08658a657f974590809290c62e889f0fd420200

cheers
