Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD56B6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfGQGtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 02:49:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfGQGtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:49:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E867EACAE;
        Wed, 17 Jul 2019 06:49:05 +0000 (UTC)
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
To:     Joe Perches <joe@perches.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, x86@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
 <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
Date:   Wed, 17 Jul 2019 08:49:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.19 08:46, Joe Perches wrote:
> On Tue, 2019-07-16 at 12:26 +0800, Zhenzhong Duan wrote:
>> .. as "nopv" support needs it to be changeable at boot up stage.
>>
>> Checkpatch reports warning, so move variable declarations from
>> hypervisor.c to hypervisor.h
> []
>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> []
>> @@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
>>   #endif
>>   }
>>   
>> -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
>> +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
> 
> static?

It is being referenced from arch/x86/kernel/cpu/hypervisor.c


Juergen
