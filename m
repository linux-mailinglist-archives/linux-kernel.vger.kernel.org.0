Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAC161299A3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLWRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 12:55:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLWRzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:55:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C06C328;
        Mon, 23 Dec 2019 09:55:50 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2CA63F68F;
        Mon, 23 Dec 2019 09:55:49 -0800 (PST)
Date:   Mon, 23 Dec 2019 17:55:48 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
Subject: Re: [Patch v6 7/7] sched/fair: Enable tuning of decay period
Message-ID: <20191223175548.GD31446@arm.com>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-8-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576123908-12105-8-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Dec 2019 at 23:11:48 (-0500), Thara Gopinath wrote:
> Thermal pressure follows pelt signas which means the decay period for

s/signas/signals

I think if you run checkpatch on the patches it will show misspelled
words as well.

Regards,
Ionela.

> thermal pressure is the default pelt decay period. Depending on soc
> charecteristics and thermal activity, it might be beneficial to decay
> thermal pressure slower, but still in-tune with the pelt signals.  One way
> to achieve this is to provide a command line parameter to set a decay
> shift parameter to an integer between 0 and 10.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
[...]
