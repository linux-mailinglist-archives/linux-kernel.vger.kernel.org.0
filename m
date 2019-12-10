Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BF1186B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:42:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:49924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfLJLmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:42:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD75FAF2B;
        Tue, 10 Dec 2019 11:42:08 +0000 (UTC)
Subject: Re: [PATCH 3/4] xen/interface: don't discard pending work in
 FRONT/BACK_RING_ATTACH
To:     "Durrant, Paul" <pdurrant@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-4-pdurrant@amazon.com>
 <8a42e7a2-e1aa-69ff-32a4-f43cc5df10d9@suse.com>
 <23a1e955fcaa4e948f5290a7252256fb@EX13D32EUC003.ant.amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6c5b7102-39af-9e83-8571-ff669b23115d@suse.com>
Date:   Tue, 10 Dec 2019 12:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <23a1e955fcaa4e948f5290a7252256fb@EX13D32EUC003.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 17:38, Durrant, Paul wrote:
>> -----Original Message-----
>> From: Jürgen Groß <jgross@suse.com>
>> Sent: 09 December 2019 13:55
>> To: Durrant, Paul <pdurrant@amazon.com>; linux-kernel@vger.kernel.org;
>> xen-devel@lists.xenproject.org
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>; Stefano Stabellini
>> <sstabellini@kernel.org>
>> Subject: Re: [PATCH 3/4] xen/interface: don't discard pending work in
>> FRONT/BACK_RING_ATTACH
>>
>> On 05.12.19 15:01, Paul Durrant wrote:
>>> Currently these macros will skip over any requests/responses that are
>>> added to the shared ring whilst it is detached. This, in general, is not
>>> a desirable semantic since most frontend implementations will eventually
>>> block waiting for a response which would either never appear or never be
>>> processed.
>>>
>>> NOTE: These macros are currently unused. BACK_RING_ATTACH(), however,
>> will
>>>         be used in a subsequent patch.
>>>
>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>> ---
>>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> ---
>>>    include/xen/interface/io/ring.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/xen/interface/io/ring.h
>> b/include/xen/interface/io/ring.h
>>> index 3f40501fc60b..405adfed87e6 100644
>>> --- a/include/xen/interface/io/ring.h
>>> +++ b/include/xen/interface/io/ring.h
>>> @@ -143,14 +143,14 @@ struct __name##_back_ring {
>> 		\
>>>    #define FRONT_RING_ATTACH(_r, _s, __size) do {				\
>>>        (_r)->sring = (_s);							\
>>>        (_r)->req_prod_pvt = (_s)->req_prod;				\
>>> -    (_r)->rsp_cons = (_s)->rsp_prod;					\
>>> +    (_r)->rsp_cons = (_s)->req_prod;					\
>>>        (_r)->nr_ents = __RING_SIZE(_s, __size);				\
>>>    } while (0)
>>>
>>>    #define BACK_RING_ATTACH(_r, _s, __size) do {				\
>>>        (_r)->sring = (_s);							\
>>>        (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
>>> -    (_r)->req_cons = (_s)->req_prod;					\
>>> +    (_r)->req_cons = (_s)->rsp_prod;					\
>>>        (_r)->nr_ents = __RING_SIZE(_s, __size);				\
>>>    } while (0)
>>
>> Lets look at all possible scenarios where BACK_RING_ATTACH()
>> might happen:
>>
>> Initially (after [FRONT|BACK]_RING_INIT(), leaving _pvt away):
>> req_prod=0, rsp_cons=0, rsp_prod=0, req_cons=0
>> Using BACK_RING_ATTACH() is fine (no change)
>>
>> Request queued:
>> req_prod=1, rsp_cons=0, rsp_prod=0, req_cons=0
>> Using BACK_RING_ATTACH() is fine (no change)
>>
>> and taken by backend:
>> req_prod=1, rsp_cons=0, rsp_prod=0, req_cons=1
>> Using BACK_RING_ATTACH() is resetting req_cons to 0, will result
>> in redoing request (for blk this is fine, other devices like SCSI
>> tapes will have issues with that). One possible solution would be
>> to ensure all taken requests are either stopped or the response
>> is queued already.
> 
> Yes, it is the assumption that a backend will drain and complete any requests it is handling, but it will not deal with new ones being posted by the frontend. This does appear to be the case for blkback.
> 
>>
>> Response queued:
>> req_prod=1, rsp_cons=0, rsp_prod=1, req_cons=1
>> Using BACK_RING_ATTACH() is fine (no change)
>>
>> Response taken:
>> req_prod=1, rsp_cons=1, rsp_prod=1, req_cons=1
>> Using BACK_RING_ATTACH() is fine (no change)
>>
>> In general I believe the [FRONT|BACK]_RING_ATTACH() macros are not
>> fine to be used in the current state, as the *_pvt fields normally not
>> accessible by the other end are initialized using the (possibly
>> untrusted) values from the shared ring. There needs at least to be a
>> test for the values to be sane, and your change should not result in the
>> same value to be read twice, as it could have changed in between.
> 
> What test would you apply to sanitize the value of the pvt pointer?

For the BACK_RING_ATTACH() case rsp_prod_pvt should not be between
req_prod and req_cons, and req_cons - rsp_prod_pvt should be <= ring
size IMO.

> Another option would be to have a backend write its pvt value into the xenstore backend area when the ring is unmapped, so that a new instance definitely resumes where the old one left off. The value of rsp_prod could, of course, be overwritten by the guest at any time and so there's little point in attempting sanitize it.

I don't think this would be necessary. With above validation in place
all the guest could do would be to shoot itself in the foot.


Juergen
