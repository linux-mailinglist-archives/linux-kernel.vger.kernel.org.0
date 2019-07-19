Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9066EB20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 21:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfGSTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 15:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbfGSTcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:32:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1157330A7C5D;
        Fri, 19 Jul 2019 19:32:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B1F5D961;
        Fri, 19 Jul 2019 19:32:10 +0000 (UTC)
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
Date:   Fri, 19 Jul 2019 15:32:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719184538.GA20324@hermes.olymp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 19 Jul 2019 19:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/19 2:45 PM, Luis Henriques wrote:
> On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
>> The rwsem->owner contains not just the task structure pointer, it also
>> holds some flags for storing the current state of the rwsem. Some of
>> the flags may have to be atomically updated. To reflect the new reality,
>> the owner is now changed to an atomic_long_t type.
>>
>> New helper functions are added to properly separate out the task
>> structure pointer and the embedded flags.
> I started seeing KASAN use-after-free with current master, and a bisect
> showed me that this commit 94a9717b3c40 ("locking/rwsem: Make
> rwsem->owner an atomic_long_t") was the problem.  Does it ring any
> bells?  I can easily reproduce it with xfstests (generic/464).
>
> Cheers,
> --
> Luís

This patch shouldn't change the behavior of the rwsem code. The code
only access data within the rw_semaphore structures. I don't know why it
will cause a KASAN error. I will have to reproduce it and figure out
exactly which statement is doing the invalid access.

Thanks,
Longman

