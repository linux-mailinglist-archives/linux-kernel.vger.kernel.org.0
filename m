Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C780DEE486
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfKDQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:18:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:45944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbfKDQSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:18:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E80B7AB8F;
        Mon,  4 Nov 2019 16:18:35 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/events: remove event handling recursion
 detection
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20191104135812.2314-1-jgross@suse.com>
 <40cba9d9-24b0-3141-4ba8-02e03049f1bf@suse.com>
 <acaf58cb-47f2-7e7e-f25d-ff83ae8a8066@suse.com>
 <b1171c0c-7928-d7a1-7bdc-e3f18f67eaac@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e6b8fcc2-2e2c-60f8-e68c-972cc7951e6b@suse.com>
Date:   Mon, 4 Nov 2019 17:18:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b1171c0c-7928-d7a1-7bdc-e3f18f67eaac@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.11.19 16:19, Jan Beulich wrote:
> On 04.11.2019 16:09, Jürgen Groß wrote:
>> On 04.11.19 15:35, Jan Beulich wrote:
>>> On 04.11.2019 14:58, Juergen Gross wrote:
>>>> __xen_evtchn_do_upcall() contains guards against being called
>>>> recursively. This mechanism was introduced in the early pvops times
>>>> (kernel 2.6.26) when there were still Xen versions around not honoring
>>>> disabled interrupts for sending events to pv guests.
>>>>
>>>> This was changed in Xen 3.0, which is much older than any Xen version
>>>> supported by the kernel, so the recursion detection can be removed.
>>>
>>> Would you mind pointing out which exact change(s) this was(were)?
>>
>> Linux kernel: 229664bee6126e01f8662976a5fe2e79813b77c8
>> Xen: d8263e8dbaf5ef1445bee0662143a0fcb6d43466
> 
> Are you sure about the latter, touching only header files underneath
> xen/, and there mostly public interface ones?

No, you are right, this was a false interpretation of mine.

> 
>>> It had always been my understanding that the recursion detection
>>> was mainly to guard against drivers re-enabling interrupts
>>> transiently in their handlers (which in turn may no longer be an
>>> issue in modern Linux kernels).
>>
>> This would have been doable with a simple bool. The more complex
>> xchg based logic was IMO for recursion detection at any point.
> 
> Well, the respective XenoLinux c/s 13098 has no mention of this, i.e.
> it simply leaves open what the actual reason was:
> 
> "[LINUX] Disallow nested event delivery.
> 
>   This eliminates the risk of overflowing the kernel stack and is a
>   reasonable policy given that we have no concept of priorities among
>   event sources."

For XenoLinux it makes at least a little bit sense, as interrupts
were enabled during calls of some handlers AFAIK. The complexity is
rather strange, though, as the bool would have been much easier to
understand.

I'll adapt the commit message.


Juergen
