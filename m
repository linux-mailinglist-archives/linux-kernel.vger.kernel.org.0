Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9985DDA55
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 03:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfD2B0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Apr 2019 21:26:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:27973 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfD2B0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 21:26:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 18:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,407,1549958400"; 
   d="scan'208";a="146630812"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2019 18:26:49 -0700
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
 <20190427085816.GB12360@zn.tnic>
 <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
 <20190428100309.GA2334@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <4c5ca6d7-ffb1-a5a5-9e46-9057802318e0@intel.com>
Date:   Mon, 29 Apr 2019 09:24:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190428100309.GA2334@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月28日 18:03, Borislav Petkov wrote:
> On Sun, Apr 28, 2019 at 09:56:35AM +0800, Zhao, Yakui wrote:
>> Thanks for the reminder about the access width.
>> It is 64-bit register. What I said is the "movq", not "movl".
>> (I understand that movl is incorrect for 64-bit register).
> 
> I didn't say anything about movl. I think what you're trying to say is
> that because your inputs like hcall_id and param1/2 are unsigned longs,
> you want a 64-bit move.

Yes. "movq" only indicates explicitly that it is 64-bit mov as ACRN 
guest only works under 64-bit mode.
I also check the usage of "mov" and "movq" in this scenario. There is no 
difference except that the movq is an explicit 64-op.
Of course "mov" is also ok to me that if you prefer the "mov".

Thanks
   Yakui
> 
