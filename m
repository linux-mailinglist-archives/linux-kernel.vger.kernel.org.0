Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3856C77241
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfGZTg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:36:59 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63853 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfGZTg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:36:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x6QJasON004309
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 26 Jul 2019 12:36:54 -0700 (PDT)
Received: from [172.25.39.5] (172.25.39.5) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 26 Jul
 2019 12:36:53 -0700
To:     rt-users <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: [RT] hit recently-fixed PREEMPT_RT CFS-bandwidth timer locking issue
 in the wild
Message-ID: <feae6d57-e8a9-36cf-56c5-e9334d7df303@windriver.com>
Date:   Fri, 26 Jul 2019 13:36:51 -0600
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

I thought people might be interested to hear that we recently hit the 
bug fixed by git commit c0ad4aa4d8 on multiple lab systems running the 
RHEL 7 "kernel-rt" kernel.  (But I think other versions are at risk as 
well.)

Interestingly, when the bug hit the system just hung completely. Nothing 
was emitted on netconsole or serial console, neither the hung task timer 
nor the NMI watchdog triggered, CONFIG_DEBUG_SPINLOCK didn't output 
anything, and magic sysrq didn't work on the serial console.  As you can 
imagine this was a bit frustrating.  I was finally able to cause a panic 
by sending an NMI from the BMC and that allowed kdump to store the core 
file so I could get stack traces.

Given how annoying it was to debug, I'd recommend backporting this fix 
as far back as it applies.  HRTIMER_MODE_SOFT was introduced in mainline 
in 4.16, but at least in the RHEL7 kernel-rt package (and I think in the 
vanilla PREEMPT_RT patches as well) hrtimers are run by default in 
softirq context and so the fix might apply to all supported PREEMPT_RT 
versions.

Chris
