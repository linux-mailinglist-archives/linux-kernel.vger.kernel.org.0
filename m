Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7FFE012
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 15:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKOO3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 09:29:51 -0500
Received: from foss.arm.com ([217.140.110.172]:60144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727411AbfKOO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:29:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71D9331B;
        Fri, 15 Nov 2019 06:29:50 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03AD03F534;
        Fri, 15 Nov 2019 06:29:48 -0800 (PST)
Subject: Re: [PATCH v2] sched/uclamp: Fix overzealous type replacement
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
References: <20191115103908.27610-1-valentin.schneider@arm.com>
 <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f4fcc45e-7609-3836-162a-0a1839134bcf@arm.com>
Date:   Fri, 15 Nov 2019 14:29:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2019 14:07, Vincent Guittot wrote:
>> -static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
>> +static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> 
> Out of curiosity why uclamp decided to use unsigned int to manipulate
> utilization instead of unsigned long which is the type of util_avg ?
> 

I didn't stare at the discussion much, but I think it stems from the
design choices behind struct uclamp_se: everything is crammed in an unsigned
int bitfield. Let me see if I can find some relevant mails.
