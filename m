Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26DCAA4B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfIENkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 09:40:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57836 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfIENkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:40:12 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x85DdvGG088282;
        Thu, 5 Sep 2019 22:39:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Thu, 05 Sep 2019 22:39:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x85Ddn6H088212
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Sep 2019 22:39:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
Date:   Thu, 5 Sep 2019 22:39:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/05 5:04, David Rientjes wrote:
> On Wed, 4 Sep 2019, Michal Hocko wrote:
> 
>>>> It's primary purpose is
>>>> to help analyse oom victim selection decision.
>>>
>>> I disagree, for I use the process list for understanding what / how many
>>> processes are consuming what kind of memory (without crashing the system)
>>> for anomaly detection purpose. Although we can't dump memory consumed by
>>> e.g. file descriptors, disabling dump_tasks() loose that clue, and is
>>> problematic for me.
>>
>> Does anything really prevent you from enabling this by sysctl though? Or
>> do you claim that this is a general usage pattern and therefore the
>> default change is not acceptable or do you want a changelog to be
>> updated?
>>
> 
> I think the motivation is that users don't want to need to reproduce an 
> oom kill to figure out why: they want to be able to figure out which 
> process had higher than normal memory usage.

Right. Users can't reproduce an OOM kill to figure out why. Those who do
failure analysis for users (e.g. technical staff at support center) need to
figure out system's state when an OOM kill happened. And installing dynamic
hooks like SystemTap / eBPF is hardly acceptable for users.

What I don't like is that Michal refuses to solve OOM stalling problem,
does not try to understand how difficult to avoid problems caused by
thoughtless printk(), and instead recommending to disable oom_dump_tasks.

There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
But that requires a solution for OOM stalling problem. Since I know how
difficult to avoid problems caused by printk() flooding, I insist that
we need "mm,oom: Defer dump_tasks() output." patch.
