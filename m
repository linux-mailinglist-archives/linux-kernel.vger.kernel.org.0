Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4183F90610
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHPQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 12:49:02 -0400
Received: from foss.arm.com ([217.140.110.172]:59008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHPQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:49:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A954828;
        Fri, 16 Aug 2019 09:49:01 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4393F694;
        Fri, 16 Aug 2019 09:49:00 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
References: <00000000000076ecf3059030d3f1@google.com>
 <20190816142643.13758-1-mathieu.desnoyers@efficios.com>
 <20190816122539.34fada7b@oasis.local.home>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <28afb801-6b76-f86b-9e1b-09488fb7c8ce@arm.com>
Date:   Fri, 16 Aug 2019 17:48:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190816122539.34fada7b@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 17:25, Steven Rostedt wrote:
>> Also, write and read to/from those variables should be done with
>> WRITE_ONCE() and READ_ONCE(), given that those are read within tracing
>> probes without holding the sched_register_mutex.
>>
> 
> I understand the READ_ONCE() but is the WRITE_ONCE() truly necessary?
> It's done while holding the mutex. It's not that critical of a path,
> and makes the code look ugly.
> 

I seem to recall something like locking primitives don't protect you from
store tearing / invented stores, so if you can have concurrent readers
using READ_ONCE(), there should be a WRITE_ONCE() on the writer side, even
if it's done in a critical section.

