Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62DFB28F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfKMO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:29:09 -0500
Received: from foss.arm.com ([217.140.110.172]:53462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfKMO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:29:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8BD27A7;
        Wed, 13 Nov 2019 06:29:08 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4EF33F6C4;
        Wed, 13 Nov 2019 06:29:07 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm64: Combine workarounds for speculative AT
 errata
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20191113114118.2427-1-steven.price@arm.com>
 <20191113114118.2427-2-steven.price@arm.com>
 <566ecd45c8bf07b3cb5d75a10c9413a8@www.loen.fr>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d66a3b7f-0338-ca70-7a98-b95aba64221a@arm.com>
Date:   Wed, 13 Nov 2019 14:29:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <566ecd45c8bf07b3cb5d75a10c9413a8@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2019 12:44, Marc Zyngier wrote:
> On 2019-11-13 12:50, Steven Price wrote:
>> Cortex-A57/A72 have a similar errata to Cortex-A76 regarding speculation
>> of the AT instruction. Since the workaround for A57/A72 doesn't require
>> VHE, the restriction enforcing VHE for A76 can be removed by combining
>> the workaround flag for both errata.
> 
> Are we sure that A76 behaves the same as A57/A72 when it comes to not
> caching any of the EPD* bits in the TLB? Because the 1319367 workaround
> has a lot of the A72 microarch implicit to it, and I'm not sure this
> works as is on A76 or A55...

Hmm, well I was going purely on the errata documents which have
basically the same text for all the errata. I have to admit I do not
understand the microarch details here. Perhaps it would be better to
leave the VHE and NVHE cases separated then?

Steven

> The patch itself looks OK, but I'd like some reassurance about the
> above.
> 
>          M.

