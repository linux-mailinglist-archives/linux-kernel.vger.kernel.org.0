Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A708F2E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfHOSLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 14:11:14 -0400
Received: from foss.arm.com ([217.140.110.172]:47456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbfHOSLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:11:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3CB928;
        Thu, 15 Aug 2019 11:11:13 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1058F3F694;
        Thu, 15 Aug 2019 11:11:11 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Message-ID: <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com>
Date:   Thu, 15 Aug 2019 19:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 08/08/2019 19:44, Pavel Tatashin wrote:
> Just a friendly reminder, please send your comments on this series.

(Please don't top-post)


> It's been a week since I sent out these patches, and no feedback yet.

A week is not a lot of time, people are busy, go to conferences, some even dare to take
holiday!


> Also, I'd appreciate if anyone could test this series on vhe hardware
> with vhe kernel, it does not look like QEMU can emulate it yet

This locks up during resume from hibernate on my AMD Seattle, a regular v8.0 machine.


Please try and build the series to reduce review time. What you have here is an all-new
page-table generation API, which you switch hibernate and kexec too. This is effectively a
new implementation of hibernate and kexec. There are three things here that need review.

You have a regression in your all-new implementation of hibernate. It took six months (and
lots of review) to get the existing code right, please don't rip it out if there is
nothing wrong with it.


Instead, please just move the hibernate copy_page_tables() code, and then wire kexec up.
You shouldn't need to change anything in the copy_page_tables() code as the linear map is
the same in both cases.


It looks like you are creating the page tables just after the kexec:segments have been
loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
memory you've got mapped gets hot-removed).
This needs to be done as late as possible, so we don't waste memory, and the world can't
change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?


> On Thu, Aug 1, 2019 at 11:24 AM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
>>
>> Enable MMU during kexec relocation in order to improve reboot performance.
>>
>> If kexec functionality is used for a fast system update, with a minimal
>> downtime, the relocation of kernel + initramfs takes a significant portion
>> of reboot.
>>
>> The reason for slow relocation is because it is done without MMU, and thus
>> not benefiting from D-Cache.
>>
>> Performance data
>> ----------------
>> For this experiment, the size of kernel plus initramfs is small, only 25M.
>> If initramfs was larger, than the improvements would be greater, as time
>> spent in relocation is proportional to the size of relocation.
>>
>> Previously:
>> kernel shutdown 0.022131328s
>> relocation      0.440510736s
>> kernel startup  0.294706768s
>>
>> Relocation was taking: 58.2% of reboot time
>>
>> Now:
>> kernel shutdown 0.032066576s
>> relocation      0.022158152s
>> kernel startup  0.296055880s
>>
>> Now: Relocation takes 6.3% of reboot time
>>
>> Total reboot is x2.16 times faster.

When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
take minutes to kexec we'll get numbers that make this change more convincing.


Thanks,

James
