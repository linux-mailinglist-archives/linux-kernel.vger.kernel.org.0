Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5713D2EA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 04:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgAPDvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 22:51:31 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:26363 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728925AbgAPDva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:51:30 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Jan
 2020 11:51:28 +0800
Received: from [10.32.64.11] (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Thu, 16 Jan
 2020 11:51:27 +0800
Subject: Re: [PATCH] x86/cpu: clear X86_BUG_SPECTRE_V2 on Zhaoxin family 7
 CPUs
To:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1579075500-7065-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <87h80wxsze.fsf@nanos.tec.linutronix.de>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <d85ca29e-2249-a55d-5f2a-0cefc10772b2@zhaoxin.com>
Date:   Thu, 16 Jan 2020 11:51:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h80wxsze.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 06:19, Thomas Gleixner wrote:
> Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> writes:
> 
>> These CPUs are not affected by spectre_v2, so clear spectre_v2 bug flag
>> in their specific initialization code.
>>  
>>  	if (cpu_has(c, X86_FEATURE_VMX))
>>  		centaur_detect_vmx_virtcap(c);
>> +
>> +	if (c->x86 == 7) {
>> +		setup_clear_cpu_cap(X86_BUG_SPECTRE_V2);
>> +		clear_bit(X86_BUG_SPECTRE_V2, (unsigned long *)cpu_caps_set);
> 
> No. Please use cpu_vuln_whitelist. It exists for exactly this
> purpose. You just need to extend it with a NO_SPECTRE_V2 bit.

Got, done.

Sincerely
TonyWWang-oc

