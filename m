Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF58100703
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKROG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:06:29 -0500
Received: from foss.arm.com ([217.140.110.172]:35186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfKROG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:06:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5EC328;
        Mon, 18 Nov 2019 06:06:27 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD223F6C4;
        Mon, 18 Nov 2019 06:06:25 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: add comments for group_type and balancing
 at SD_NUMA level
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        bsegall@google.com
References: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
 <7325dac4-bb26-9fcb-75bc-15b68d35b62d@arm.com>
 <20191118133457.GB66833@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3cdf1c60-edf1-a46f-d312-411fa3301c95@arm.com>
Date:   Mon, 18 Nov 2019 14:06:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118133457.GB66833@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2019 13:34, Ingo Molnar wrote:
> Thanks - I did a few more fixes and updates to the comments, this is how 
> it ended up looking like (full patch below):
> 
[...]

LGTM, thanks!

> I also added your Acked-by, which I think was implicit? :)
> 

Hah, I'm not used to handing those out, but sure!
