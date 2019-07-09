Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8C63542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfGIL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 07:59:28 -0400
Received: from foss.arm.com ([217.140.110.172]:42226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfGIL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 026F02B;
        Tue,  9 Jul 2019 04:59:26 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7296C3F59C;
        Tue,  9 Jul 2019 04:59:23 -0700 (PDT)
Subject: Re: [v1 0/5] allow to reserve memory for normal kexec kernel
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
 <CACi5LpNGWhTnXyM8gB0Tn=682+08s-ppfDpX2SawfxMvue1GTQ@mail.gmail.com>
 <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2d60f302-5161-638a-76cd-d7d79e5631fe@arm.com>
Date:   Tue, 9 Jul 2019 12:59:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBrwBHhD-PFO_gVnDYoFi0Su6t456WNdtBWpOe4qM+oww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 09/07/2019 11:55, Pavel Tatashin wrote:
> On Tue, Jul 9, 2019 at 6:36 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> On Tue, Jul 9, 2019 at 2:46 AM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>>> Currently, it is only allowed to reserve memory for crash kernel, because
>>> it is a requirement in order to be able to boot into crash kernel without
>>> touching memory of crashed kernel is to have memory reserved.
>>>
>>> The second benefit for having memory reserved for kexec kernel is
>>> that it does not require a relocation after segments are loaded into
>>> memory.
>>>
>>> If kexec functionality is used for a fast system update, with a minimal
>>> downtime, the relocation of kernel + initramfs might take a significant
>>> portion of reboot.
>>>
>>> In fact, on the machine that we are using, that has ARM64 processor
>>> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
>>> time:
>>>
>>> kernel shutdown 0.03s
>>> relocation      0.35s
>>> kernel startup  0.29s
>>>
>>> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
>>> time increases proportionally.
>>>
>>> While, it is possible to add 'kexeckernel=' parameters support to other
>>> architectures by modifying reserve_crashkernel(), in this series this is
>>> done for arm64 only.

>>
>> This seems like an issue with time spent while doing sha256
>> verification while in purgatory.
>>
>> Can you please try the following two patches which enable D-cache in
>> purgatory before SHA verification and disable it before switching to
>> kernel:
>>
>> http://lists.infradead.org/pipermail/kexec/2017-May/018839.html
>> http://lists.infradead.org/pipermail/kexec/2017-May/018840.html
> 
> Hi Bhupesh,
> 
> The verification was taking 2.31s. This is why it is disabled via
> kexec's '-i' flag. Therefore 0.35s is only the relocation part where
> time is spent, and with my patches the time is completely gone.
> Actually, I am glad you showed these patches to me because I might
> pull them and enable verification for our needs.
> 
>>
>> Note that these were not accepted upstream but are included in several
>> distros in some form or the other :)
> 
> Enabling MMU and D-Cache for relocation  would essentially require the
> same changes in kernel. Could you please share exactly why these were
> not accepted upstream into kexec-tools?

Because '--no-checks' is a much simpler alternative.

More of the discussion:
https://lore.kernel.org/linux-arm-kernel/5599813d-f83c-d154-287a-c131c48292ca@arm.com/

While you can make purgatory a fully-fledged operating system, it doesn't really need to
do anything on arm64. Errata-workarounds alone are a reason not do start down this path.


Thanks,

James
