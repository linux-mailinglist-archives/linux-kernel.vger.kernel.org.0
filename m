Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C69DA19BA62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 04:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgDBCiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 22:38:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:38:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D2D30E;
        Wed,  1 Apr 2020 19:38:50 -0700 (PDT)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D6533F71E;
        Wed,  1 Apr 2020 19:38:47 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-4-git-send-email-anshuman.khandual@arm.com>
 <54e53bb4-beb3-1a36-e8a4-2f3bda433739@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a728417c-a0b4-d1dc-5257-19e869085bd3@arm.com>
Date:   Thu, 2 Apr 2020 08:08:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54e53bb4-beb3-1a36-e8a4-2f3bda433739@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2020 11:41 PM, Suzuki K Poulose wrote:
> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
>> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
>> SpecSEI in ID_MMFR4 register per ARM DDI 0487E.a.
> 
> It might be worth adding a comment here mentioning why SpecSEI is
> HIGHER_SAFE, unlike the majority.

Sure, will do.

> 
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> With that:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
