Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA840179E57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgCEDkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 22:40:39 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:51371 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgCEDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:40:38 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 5 Mar
 2020 11:40:33 +0800
Received: from [10.32.64.44] (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 5 Mar
 2020 11:40:32 +0800
Subject: Re: [PATCH] x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs too
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1583288285-2804-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200304171336.GD21662@linux.intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <c3d9ad69-4a49-19de-1680-84f7d5afeb81@zhaoxin.com>
Date:   Thu, 5 Mar 2020 11:40:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200304171336.GD21662@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/03/2020 01:13, Sean Christopherson wrote:
> On Wed, Mar 04, 2020 at 10:18:05AM +0800, Tony W Wang-oc wrote:
>> New Zhaoxin family 7 CPUs support the UMIP (User-Mode Instruction
>> Prevention) feature. So, modify X86_UMIP depends on Zhaoxin CPUs too.
>>
>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> ---
>>  arch/x86/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 16a4b39..ca4beb8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -1877,7 +1877,7 @@ config X86_SMAP
>>  
>>  config X86_UMIP
>>  	def_bool y
>> -	depends on CPU_SUP_INTEL || CPU_SUP_AMD
>> +	depends on CPU_SUP_INTEL || CPU_SUP_AMD || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
> 
> The changelog only mentions Zhaoxin, but this also adds Centaur...

Sorry for this. Some Centaur family 7 CPUs also support the UMIP
feature, so will resend this patch as a patch series.

Sincerely
TonyWWang-oc
> 
>>  	prompt "User Mode Instruction Prevention" if EXPERT
>>  	---help---
>>  	  User Mode Instruction Prevention (UMIP) is a security feature in
>> -- 
>> 2.7.4
>>
> .
> 
