Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEE906A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHPRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:19:44 -0400
Received: from foss.arm.com ([217.140.110.172]:59274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfHPRTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:19:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271DA28;
        Fri, 16 Aug 2019 10:19:43 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281F63F694;
        Fri, 16 Aug 2019 10:19:42 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com, pjt@google.com
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
 <2994a6ee-9238-5285-3227-cb7084a834c8@arm.com>
 <7C1833A8-27A4-4755-9B1E-335C20207A66@linux.alibaba.com>
 <39d1affb-9cfa-208d-8bf4-f4c802e8c7f9@arm.com>
 <c8ababc5-cb9e-58ba-2969-1e061bb564c8@arm.com>
 <02BC41EE-6653-4473-91D4-CDEE53D8703D@linux.alibaba.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ce1b05b1-d4d3-140e-b611-0482fa9fd3f5@arm.com>
Date:   Fri, 16 Aug 2019 18:19:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <02BC41EE-6653-4473-91D4-CDEE53D8703D@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 16:39, Liangyan wrote:
> Thanks for the feedback.
> Add some debug prints and get below log. It seems that pick_next_task_fair throttle the cfs_rq first, then call put_prev_entity to assign runtime to this cfs_rq.
> 
[...]
> 
> Regarding the suggested change,  i¡¯m not  sure whether it is ok to skip the runtime account for curr task.
> 

Yeah it's probably pretty stupid. IIRC throttled cfs_rq means frozen
rq_clock, so any subsequent call to update_curr() on a throttled cfs_rq
should lead to an early bailout anyway due to delta_exec <= 0.
