Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA0F9A470
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 02:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfHWAxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 20:53:15 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46806 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732071AbfHWAxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:53:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TaAJU4z_1566521589;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaAJU4z_1566521589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Aug 2019 08:53:09 +0800
Subject: Re: [PATCH v3] psi: get poll_work to run when calling poll syscall
 next time
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jason Xing <kerneljasonxing@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>
References: <1566357985-97781-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20190822152107.adc0d4cd374fcc3eb8e148a9@linux-foundation.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <8a093924-98ea-de13-554d-5f5b6ee63536@linux.alibaba.com>
Date:   Fri, 23 Aug 2019 08:53:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822152107.adc0d4cd374fcc3eb8e148a9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/8/23 06:21, Andrew Morton wrote:
> On Wed, 21 Aug 2019 11:26:25 +0800 Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> 
>> Only when calling the poll syscall the first time can user
>> receive POLLPRI correctly. After that, user always fails to
>> acquire the event signal.
>>
>> Reproduce case:
>> 1. Get the monitor code in Documentation/accounting/psi.txt
>> 2. Run it, and wait for the event triggered.
>> 3. Kill and restart the process.
>>
>> The question is why we can end up with poll_scheduled = 1 but the work
>> not running (which would reset it to 0). And the answer is because the
>> scheduling side sees group->poll_kworker under RCU protection and then
>> schedules it, but here we cancel the work and destroy the worker. The
>> cancel needs to pair with resetting the poll_scheduled flag.
> 
> Should this be backported into -stable kernels?
> 
Sorry for missing that, should I resend it with cc stable tag?

Thanks,
Joseph
