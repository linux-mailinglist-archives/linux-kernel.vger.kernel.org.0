Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38886155576
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgBGKS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 05:18:56 -0500
Received: from foss.arm.com ([217.140.110.172]:38500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBGKSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:18:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6AA30E;
        Fri,  7 Feb 2020 02:18:55 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 042D63F52E;
        Fri,  7 Feb 2020 02:18:53 -0800 (PST)
Subject: Re: [PATCH v4 1/4] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-2-valentin.schneider@arm.com>
 <20200207050854.GF27398@codeaurora.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <90b6b52f-6e8d-7d25-dc5b-3e537f419ef7@arm.com>
Date:   Fri, 7 Feb 2020 10:18:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207050854.GF27398@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On 07/02/2020 05:08, Pavan Kondeti wrote:
> 
> Looks good to me.
> 

Thanks for having a look!

> Thanks,
> Pavan
> 
