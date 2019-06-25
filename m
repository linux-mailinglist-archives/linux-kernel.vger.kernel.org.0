Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23605280F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfFYJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:27:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFYJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:27:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FBC2360;
        Tue, 25 Jun 2019 02:27:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2973F71E;
        Tue, 25 Jun 2019 02:27:43 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:27:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] kernel/isolation: Assert that a housekeeping CPU
 comes up at boot time
Message-ID: <20190625092740.homiljqkygecwete@e107158-lin.cambridge.arm.com>
References: <20190625001720.19439-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625001720.19439-1-npiggin@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/19 10:17, Nicholas Piggin wrote:
> With the change to allow the boot CPU0 to be isolated, it is possible
> to specify command line options that result in no housekeeping CPU
> online at boot.
> 
> An 8 CPU system booted with "nohz_full=0-6 maxcpus=4", for example.
> 
> It is not easily possible at housekeeping init time to know all the
> various SMP options that will result in an invalid configuration, so
> this patch adds a sanity check after SMP init, to ensure that a
> housekeeping CPU has been onlined.
> 
> The panic is undesirable, but it's better than the alternative of an
> obscure non deterministic failure. The panic will reliably happen
> when advanced parameters are used incorrectly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> v2: Fix a NULL pointer dereference when not overriding housekeeping,
>     noticed by kernel test robot and Qais, who fixed it and verified
>     the fix (thanks!)

Glad I could help. But for the record my problem wasn't a NULL pointer
dereference and simply the loop didn't hit the condition to 'return 0' so I hit
the panic.

I tested that the fix does indeed skip the verification if no nohz_full nor
isolcpus is passed. But I didn't do the reverse check, although from the code
this flag is only set in housekeeping_setup() so it should continue to work as
intended.

Thanks!

--
Qais Yousef
