Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12DBFB21F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKMOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:06:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:41908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbfKMOG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:06:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63E00B211;
        Wed, 13 Nov 2019 14:06:26 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 3/3] xen/mcelog: also allow building for
 32-bit kernels
To:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
 <07358162-1d03-63f5-ad14-95a2e0e23018@suse.com>
 <cd81b75f-bf43-9094-7236-8efa4da27da1@oracle.com>
 <4577bd33-e4b5-9869-3760-c55471382f01@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <b6afa49b-e33d-dc4c-3e3b-de260219cd9e@suse.com>
Date:   Wed, 13 Nov 2019 15:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4577bd33-e4b5-9869-3760-c55471382f01@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.19 14:47, Jan Beulich wrote:
> On 13.11.2019 01:15, Boris Ostrovsky wrote:
>> On 11/11/19 9:46 AM, Jan Beulich wrote:
>>> There's no apparent reason why it can be used on 64-bit only.
>>>
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>>
>>> --- a/drivers/xen/Kconfig
>>> +++ b/drivers/xen/Kconfig
>>> @@ -285,7 +285,7 @@ config XEN_ACPI_PROCESSOR
>>>   
>>>   config XEN_MCE_LOG
>>>   	bool "Xen platform mcelog"
>>> -	depends on XEN_DOM0 && X86_64 && X86_MCE
>>> +	depends on XEN_DOM0 && X86 && X86_MCE
>>
>> Can we have X86_MCE without X86?
> 
> I don't think we can. Is this a request to drop the middle
> operand altogether?

I think this would be reasonable. X86_64 was an additional dependency,
while X86 isn't.

With the X86 removed:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
