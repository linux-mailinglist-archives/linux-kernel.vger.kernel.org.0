Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82915FB86
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgBOAhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:37:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:9977 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgBOAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 16:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="234636549"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2020 16:37:34 -0800
Date:   Sat, 15 Feb 2020 08:37:53 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [PATCH v2] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-ID: <20200215003753.GA32682@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200214073320.28735-1-richardw.yang@linux.intel.com>
 <20200214085113.GP31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214085113.GP31689@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 09:51:13AM +0100, Michal Hocko wrote:
>On Fri 14-02-20 15:33:20, Wei Yang wrote:
>> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
>> affinity.
>> 
>> Current routine does like this:
>> 
>>   a) Iterate all the numa node
>>   b) Adjust cpu affinity when node has an online cpu
>> 
>> For a) this is not necessary, since the particular online cpu belongs to
>> a particular numa node. So it is not necessary to iterate on every nodes
>> on the system. This new onlined cpu just affect kswapd cpu affinity of
>> this particular node.
>> 
>> For b) several cpumask operation is used to check whether the node has
>> an online CPU. Since at this point we are sure one of our CPU onlined,
>> we can set the cpu affinity directly to current cpumask_of_node().
>> 
>> This patch simplifies the logic by set cpu affinity of the affected
>> kswapd.
>
>How have you tested this patch?
>

I online one cpu and confirm the "cpu" is the one we just onlined.

If my understanding is correct, this is the expected behavior.

>Also this is an old code and quite convoluted but does it still work as
>inteded? I mean, I do not see any cpu offline callback to reduce the
>cpu mask as all the CPUs for the given node go offline? Wouldn't the

You are right, I didn't see the counterpart for cpu offline. This is the
question I want to ask. Seems we didn't handle it at the very beginning.

>scheduler simply go and fallback to no affinity if that happens?
>In other words what is the value of kswapd_cpu_online in the first
>place?

Some cases may this function be useful.

If we have a memory node which doesn't have any online cpu, the default
cpumask is not set. After one of the cpu online, we want to change cpu
affinity.

Or we want to add more cpu to the system, we could allow kswapd use more cpu
resources. Otherwise, kswapd would be limited to those original cpus.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
