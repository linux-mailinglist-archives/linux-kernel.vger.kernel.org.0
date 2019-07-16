Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B86A109
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 05:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfGPDzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 23:55:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730275AbfGPDzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:55:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C1C7AB9D;
        Tue, 16 Jul 2019 03:55:21 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH 0/2] Remove 32-bit Xen PV guest support
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LinuxVirtualization <virtualization@lists.linux-foundation.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190715113739.17694-1-jgross@suse.com>
 <87y30zfe9z.fsf@linux.intel.com>
 <CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
 <bbf1ea2d-1206-eb54-3611-4c9b9fad4aa4@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <b466e2eb-2d9c-46cb-c239-a93967ccf74c@suse.com>
Date:   Tue, 16 Jul 2019 05:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <bbf1ea2d-1206-eb54-3611-4c9b9fad4aa4@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 19:39, Andrew Cooper wrote:
> On 15/07/2019 18:28, Andy Lutomirski wrote:
>> On Mon, Jul 15, 2019 at 9:34 AM Andi Kleen <ak@linux.intel.com> wrote:
>>> Juergen Gross <jgross@suse.com> writes:
>>>
>>>> The long term plan has been to replace Xen PV guests by PVH. The first
>>>> victim of that plan are now 32-bit PV guests, as those are used only
>>>> rather seldom these days. Xen on x86 requires 64-bit support and with
>>>> Grub2 now supporting PVH officially since version 2.04 there is no
>>>> need to keep 32-bit PV guest support alive in the Linux kernel.
>>>> Additionally Meltdown mitigation is not available in the kernel running
>>>> as 32-bit PV guest, so dropping this mode makes sense from security
>>>> point of view, too.
>>> Normally we have a deprecation period for feature removals like this.
>>> You would make the kernel print a warning for some releases, and when
>>> no user complains you can then remove. If a user complains you can't.
>>>
>> As I understand it, the kernel rules do allow changes like this even
>> if there's a complaint: this is a patch that removes what is
>> effectively hardware support.  If the maintenance cost exceeds the
>> value, then removal is fair game.  (Obviously we weight the value to
>> preserving compatibility quite highly, but in this case, Xen dropped
>> 32-bit hardware support a long time ago.  If the Xen hypervisor says
>> that 32-bit PV guest support is deprecated, it's deprecated.)
>>
>> That being said, a warning might not be a bad idea.  What's the
>> current status of this in upstream Xen?
> 
> So personally, I'd prefer to see support stay, but at the end of the day
> it is Juergen's choice as the maintainer of the code.

Especially on the security front we are unsafe with 32-bit PV Linux.
And making it safe will make it so slow that the needed effort is not
spent very well.


Juergen
