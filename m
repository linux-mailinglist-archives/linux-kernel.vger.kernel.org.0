Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F440108C82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKYLDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:03:42 -0500
Received: from foss.arm.com ([217.140.110.172]:48566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfKYLDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:03:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD46431B;
        Mon, 25 Nov 2019 03:03:41 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52BDF3F52E;
        Mon, 25 Nov 2019 03:03:40 -0800 (PST)
Subject: Re: [PATCH] sched/fair: fix rework of find_idlest_group()
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        kernel test robot <rong.a.chen@intel.com>
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
 <2bb75047-4a93-4f1d-e2ff-99c499b5a070@arm.com>
 <CAKfTPtC54O7tY4T2RmYAFdZ7iM-wTnabbdeatRn6zY_P=jM9YQ@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <08220a1c-5f31-75ff-4f07-25c45ccc8a14@arm.com>
Date:   Mon, 25 Nov 2019 11:03:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtC54O7tY4T2RmYAFdZ7iM-wTnabbdeatRn6zY_P=jM9YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 09:16, Vincent Guittot wrote:
> 
> This is an extension of idle_cpu which also returns int and I wanted
> to stay consistent with it
> 
> So we might want to make some kind of cleanup or rewording of
> interfaces and their descriptions but this should be done as  a whole
> and out of the scope of this patch and would worth having a dedicated
> patch IMO because it would imply to modify other patch of the code
> that is not covered by this patch like idle_cpu or cpu_util_without
> 

Fair enough.
