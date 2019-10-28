Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153E1E74FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfJ1PWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:22:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:51958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfJ1PWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:22:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B320CB20E;
        Mon, 28 Oct 2019 15:22:32 +0000 (UTC)
Date:   Mon, 28 Oct 2019 08:21:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     eric@anholt.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: vc04_services: replace g_free_fragments_mutex
 with spinlock
Message-ID: <20191028152108.bjliafudxn3llysv@linux-p48b>
References: <20191027221530.12080-1-dave@stgolabs.net>
 <576df522-f012-9dd1-9dcc-b7e444e82ac6@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <576df522-f012-9dd1-9dcc-b7e444e82ac6@gmx.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019, Stefan Wahren wrote:

>Hi Davidlohr,
>
>Am 27.10.19 um 23:15 schrieb Davidlohr Bueso:
>> There seems no need to be using a semaphore, or a sleeping lock
>> in the first place: critical region is extremely short, does not
>> call into any blocking calls and furthermore lock and unlocking
>> operations occur in the same context.
>>
>> Get rid of another semaphore user by replacing it with a spinlock.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>> This is in an effort to further reduce semaphore users in the kernel.
>>
>thanks for this. Could please also send this to devel@driverdev.osuosl.org?

Ccing.

>
>I only need to know, has this been tested on the Raspberry Pi?

No testing has been done, I have no hardware to test this.

Thanks,
Davidlohr
