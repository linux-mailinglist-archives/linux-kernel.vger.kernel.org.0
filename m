Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036CA8C2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfHMVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:04:50 -0400
Received: from mail.windriver.com ([147.11.1.11]:56068 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfHMVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:04:47 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7DL4gQv003132
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 13 Aug 2019 14:04:42 -0700 (PDT)
Received: from [172.25.39.5] (172.25.39.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 13 Aug
 2019 14:04:41 -0700
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: [RT] should pm_qos_resume_latency_us on one CPU affect latency on
 another?
Message-ID: <4b3bf6d8-7e1a-138b-048d-b3c1f5f65297@windriver.com>
Date:   Tue, 13 Aug 2019 15:04:39 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.39.5]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Just wondering if what I'm seeing is expected.  I'm using the CentOS 7 
RT kernel with boot args of "skew_tick=1 irqaffinity=0 rcu_nocbs=1-27 
nohz_full=1-27" among others.

Normally if I run cyclictest it sets /dev/cpu_dma_latency to zero.  This 
gives worst-case latency around 6usec.

If I set /dev/cpu_dma_latency to something large and then set 
/sys/devices/system/cpu/cpu${num}/power/pm_qos_resume_latency_us to "2" 
for the CPUs that cyclictest is running on then the worst-case latency 
jumps to more like 16usec.

If I set pm_qos_resume_latency_us to "2" for all CPUs on the system, 
then the worst-case latency comes back down.  It's not sufficient to set 
it for all CPUs on the same socket as cyclictest.

It does not seem to make any difference in the worst-case latency to set 
cpuset.sched_load_balance to zero for the cpuset containing cyclictest. 
(All cpusets but one have cpuset.sched_load_balance set to zero, and 
that one doesn't include the CPUs that cyclictest runs on.)

Looking at the latency traces, there does not appear to be any single 
culprit.  I've seen cases where it appears to take extra time in 
migrate_task_rq_fair(), tick_do_update_jiffies64(), rcu_irq_enter(), and 
enqueue_entity().

I'm trying to dynamically isolate CPUs from the system for running RT 
tasks, but it seems like the rest of the system still affects the 
isolated CPUs.

Any comments/suggestions would be appreciated.

Thanks,
Chris
