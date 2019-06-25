Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB62F52067
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 03:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfFYBpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 21:45:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:38321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfFYBpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 21:45:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 18:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="169623634"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2019 18:45:52 -0700
Subject: Re: [x86/hotplug] e1056a25da:
 WARNING:at_arch/x86/kernel/apic/apic.c:#setup_local_APIC
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, tipbuild@zytor.com, lkp@01.org
References: <20190620021856.GP7221@shao2-debian>
 <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <58ea508f-dc2e-8537-fe96-49cca0a7c799@intel.com>
Date:   Tue, 25 Jun 2019 09:46:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906212108150.5503@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/19 3:08 AM, Thomas Gleixner wrote:
> On Thu, 20 Jun 2019, kernel test robot wrote:
>
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: e1056a25daa6460c95e92d7d6853d05ad62458f7 ("x86/hotplug: Silence APIC and NMI when CPU is dead")
>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/ipi
>>
>> in testcase: locktorture
>> with following parameters:
>>
>> 	runtime: 300s
>> 	test: cpuhotplug
>>
>> test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region behaviors.
>> test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> I cannot reproduce that issue. What's the underlying hardware machine?

brand: Genuine Intel(R) CPU 000 @ 2.27GHz
model: Westmere-EX
memory: 256G
nr_node: 4
nr_cpu: 80

Best Regards,
Rong Chen


>
> Thanks,
>
> 	tglx
