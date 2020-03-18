Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168CA189C70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 13:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCRM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 08:58:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:63424 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgCRM6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:58:02 -0400
IronPort-SDR: RvbxxRczG7WdWNhsPeOiqSYS0RGD/fPyhXC4R2xRalk0a9iBIIj7CUjhJZ6TjUMxfsctqPkjhR
 T/LEyM0wB2tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 05:58:02 -0700
IronPort-SDR: aEOQ2pm0rO6THLoXW9F6ereX9BgMU5ud7ETZSpylp/E5z87zJyoffb+Rd2xI1jypSAHrkD+RmY
 Pay+mPtT4FmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,567,1574150400"; 
   d="scan'208";a="238598966"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.29.88]) ([10.255.29.88])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2020 05:57:59 -0700
Subject: Re: [PATCH] x86/cpufeatures: make bits in cpu_caps_cleared[] and
 cpu_cpus_set[] exclusive
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200318061624.150313-1-xiaoyao.li@intel.com>
 <20200318103219.GA4377@zn.tnic>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <42770941-dfdf-628b-3fe8-6ee5a871b1b4@intel.com>
Date:   Wed, 18 Mar 2020 20:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318103219.GA4377@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/2020 6:32 PM, Borislav Petkov wrote:
> On Wed, Mar 18, 2020 at 02:16:24PM +0800, Xiaoyao Li wrote:
>> In apply_forced_caps(), cpu_caps_set[] overrides cpu_caps_cleared[], so
>> that setup_clear_cpu_cap() cannot clear one cap if setup_force_cpu_cap()
>> sets the cap before it.
> 
> Context pls: what is the observation, what are you trying to do,
> reproducer, etc?

Well. I use setup_force_cup_cap(XXX) to set one flag, XXX, during early 
boot. And use setup_clear_cpu_cap(XXX) to clear this flag when something 
wrong later. However, it turns out that the flag is still set when I use 
cpu_has(c, XXX) to check when init each AP. I have to clear the flag XXX 
explicitly using clear_cpu_cap(c, XXX). However, in /proc/cpuinfo, this 
XXX flag still presents on every CPU.

> Thx.
> 

