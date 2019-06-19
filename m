Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533814B464
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 10:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfFSIy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 04:54:28 -0400
Received: from foss.arm.com ([217.140.110.172]:56492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfFSIy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8981ECFC;
        Wed, 19 Jun 2019 01:54:27 -0700 (PDT)
Received: from [10.37.12.160] (unknown [10.37.12.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5CD3F246;
        Wed, 19 Jun 2019 01:54:22 -0700 (PDT)
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, aou@eecs.berkeley.edu,
        gary@garyguo.net, Atish.Patra@wdc.com, hch@infradead.org,
        paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
Date:   Wed, 19 Jun 2019 09:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/19 9:07 AM, Guo Ren wrote:
> Hi Julien,

Hi,

> 
> You forgot CCing C-SKY folks :P

I wasn't aware you could be interested :).

> 
> Move arm asid allocator code in a generic one is a agood idea, I've
> made a patchset for C-SKY and test is on processing, See:
> https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
> 
> If you plan to seperate it into generic one, I could co-work with you.

Was the ASID allocator work out of box on C-Sky? If so, I can easily 
move the code in a generic place (maybe lib/asid.c).

Cheers,

-- 
Julien Grall
