Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B40D90BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392977AbfJPMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 08:24:14 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:10512
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387581AbfJPMYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:24:13 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 08:24:12 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AaAABYCadd/zXSMGcNWRkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAREBAQEBAQEBAQEBAYF7hDyEJY80AQEBAQEBBoERJYl4igy?=
 =?us-ascii?q?HIwkBAQEBAQEBAQE3AQGEQAKDHTgTAgwBAQEEAQEBAQEFAwGFWIYZAQEBAQM?=
 =?us-ascii?q?jFUEQCw0IAwICJgICVwYNBgIBAYMeglOtaHWBMhqFM4MwgUiBDCiBZYpBeIE?=
 =?us-ascii?q?HgTgMgl8+h1KCXgSNOIh1lyAIgiSVFSGOIgOLHS2pUIF6MxoIKAiDJ1CQS2K?=
 =?us-ascii?q?RSgEB?=
X-IPAS-Result: =?us-ascii?q?A2AaAABYCadd/zXSMGcNWRkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?REBAQEBAQEBAQEBAYF7hDyEJY80AQEBAQEBBoERJYl4igyHIwkBAQEBAQEBA?=
 =?us-ascii?q?QE3AQGEQAKDHTgTAgwBAQEEAQEBAQEFAwGFWIYZAQEBAQMjFUEQCw0IAwICJ?=
 =?us-ascii?q?gICVwYNBgIBAYMeglOtaHWBMhqFM4MwgUiBDCiBZYpBeIEHgTgMgl8+h1KCX?=
 =?us-ascii?q?gSNOIh1lyAIgiSVFSGOIgOLHS2pUIF6MxoIKAiDJ1CQS2KRSgEB?=
X-IronPort-AV: E=Sophos;i="5.67,303,1566835200"; 
   d="scan'208";a="202259568"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 16 Oct 2019 20:14:50 +0800
Subject: Re: [PATCH 10/34] m68k/coldfire: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-11-bigeasy@linutronix.de>
 <39d20c16-50a4-34f5-f98c-979138bf1a29@linux-m68k.org>
 <20191016075520.eauiemlvbo5a37d4@linutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f59db1e5-2249-3b80-a869-6f4a306f015b@linux-m68k.org>
Date:   Wed, 16 Oct 2019 22:14:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191016075520.eauiemlvbo5a37d4@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 16/10/19 5:55 pm, Sebastian Andrzej Siewior wrote:
> On 2019-10-16 10:50:41 [+1000], Greg Ungerer wrote:
>> Hi Sebastian,
> Hi Greg,
> 
>> On 16/10/19 5:17 am, Sebastian Andrzej Siewior wrote:
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
>>> Both PREEMPT and PREEMPT_RT require the same functionality which today
>>> depends on CONFIG_PREEMPT.
>>>
>>> Switch the entry code over to use CONFIG_PREEMPTION.
>>>
>>> Cc: Greg Ungerer <gerg@linux-m68k.org>
>>
>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thank you.
> 
>> Do you want me to take this via the m68knommu git tree?
>> Or are you taking the whole series via some other tree?
> 
> It is up to you. You have all the dependencies so you can either add it
> to your -next branch or leave it and we will pick it up for you.

Patch added to the m68knommu git tree, for-next branch.

Thanks
Greg

