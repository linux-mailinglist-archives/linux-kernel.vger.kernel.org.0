Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8325C18B15B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCSK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 06:28:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCSK2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A30631B;
        Thu, 19 Mar 2020 03:28:49 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800C33F305;
        Thu, 19 Mar 2020 03:28:48 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 3/9] sched: Remove checks against SD_LOAD_BALANCE
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-4-valentin.schneider@arm.com>
Message-ID: <c74a32d9-e40c-b976-be19-9ceea91d6fa7@arm.com>
Date:   Thu, 19 Mar 2020 11:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-4-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:15, Valentin Schneider wrote:
> Potential users of that flag could have been cpusets and isolcpus.
> 
> cpusets don't need it because they define exclusive (i.e. non-overlapping)
> domain spans, see cpuset.cpu_exclusive and cpuset.sched_load_balance.
> If such a cpuset contains a single CPU, it will have the NULL domain
> attached to it. If it contains several CPUs, none of their domains will
> extend beyond the span of the cpuset.

There are also non-exclusive cpusets but I assume the statement is the same.

CPUs which are only used in cpusets with cpuset.sched_load_balance=0 are
attached to the NULL sched-domain.

There seems to be no code which alters the SD_LOAD_BALANCE flag.

[...]
