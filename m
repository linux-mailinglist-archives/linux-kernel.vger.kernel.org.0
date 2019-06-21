Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A934DE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFUAsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 20:48:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:47231 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfFUAsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:48:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 17:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="311842325"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 17:48:04 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>, <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs]  c8eaeac7b7:  aim7.jobs-per-min -11.7% regression
References: <20190513025004.GG31424@shao2-debian>
        <87blzl7itt.fsf@yhuang-dev.intel.com>
        <87v9xdymdg.fsf@yhuang-dev.intel.com>
Date:   Fri, 21 Jun 2019 08:48:03 +0800
In-Reply-To: <87v9xdymdg.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Tue, 11 Jun 2019 08:52:11 +0800")
Message-ID: <877e9fahmk.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Hi, Josef,
>>
>> kernel test robot <rong.a.chen@intel.com> writes:
>>
>>> Greeting,
>>>
>>> FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
>>>
>>>
>>> commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve
>>> delalloc metadata differently")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> in testcase: aim7
>>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
>>> with following parameters:
>>>
>>> 	disk: 4BRD_12G
>>> 	md: RAID0
>>> 	fs: btrfs
>>> 	test: disk_rr
>>> 	load: 1500
>>> 	cpufreq_governor: performance
>>>
>>> test-description: AIM7 is a traditional UNIX system level benchmark
>>> suite which is used to test and measure the performance of multiuser
>>> system.
>>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>>
>> Here's another regression, do you have time to take a look at this?
>
> Ping

Ping again ...

Best Regards,
Huang, Ying
