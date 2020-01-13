Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B1C13956A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 17:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAMQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 11:03:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59240 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbgAMQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578931397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKpxETq0xwkBl5WEZA8OIKc0QN58PXRZckEIbgm5l3o=;
        b=AWVxa5G2vVzCpVy3y6CqC6GFpQwR/4j3ktiS1XvE2XzMou4Fjr877xgSY1R4cwMNDd1bou
        DEQS8/YepIirVrDyCaTU+0Ku18d+hlFXuzpew5Uy4M33qbfdyu6kJEWIa4EdVmUx7fYAhy
        Em/5eY3mTDnxubY5a49KgGaUbsH2o4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-ihJUYOYPMLeH2NSgbvFxxg-1; Mon, 13 Jan 2020 11:03:14 -0500
X-MC-Unique: ihJUYOYPMLeH2NSgbvFxxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC7E800D48;
        Mon, 13 Jan 2020 16:03:12 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 521CF80F57;
        Mon, 13 Jan 2020 16:03:12 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155934.GZ2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <49a6d83c-b4a5-c790-fb41-2c80f6880cfb@redhat.com>
Date:   Mon, 13 Jan 2020 11:03:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113155934.GZ2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 10:59 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
>> An internal nfsd test that ran for more than an hour could cause the
>> following message to be displayed.
>>
>>   [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> I'm guessing the pertinent detail you forget to mention here is that
> that test re-loads the nfs modules lots of times?
>
Yes, that is true. I will mention it in the next version.

Thanks,
Longman

