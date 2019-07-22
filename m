Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732426FAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGVIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 04:05:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:6792 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGVIFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:05:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 01:03:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; 
   d="scan'208";a="170796484"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2019 01:03:09 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs] c8eaeac7b7: aim7.jobs-per-min -11.7% regression
References: <20190513025004.GG31424@shao2-debian>
        <87blzl7itt.fsf@yhuang-dev.intel.com>
        <87v9xdymdg.fsf@yhuang-dev.intel.com>
        <877e9fahmk.fsf@yhuang-dev.intel.com>
        <20190625142242.oxltqbj2veuckoxo@MacBook-Pro-91.local>
        <a80ab85b-635f-90fe-24da-5f746c613811@intel.com>
        <20190626031726.dd457kxc3zyuekyf@MacBook-Pro-91.local>
        <a8cd42e0-339d-f8a7-40f7-bc0cd4fe9bff@intel.com>
        <87pnml0zrk.fsf@yhuang-dev.intel.com>
Date:   Mon, 22 Jul 2019 16:03:09 +0800
In-Reply-To: <87pnml0zrk.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Mon, 8 Jul 2019 15:08:31 +0800")
Message-ID: <874l3ebio2.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Rong Chen <rong.a.chen@intel.com> writes:
>
>> On 6/26/19 11:17 AM, Josef Bacik wrote:
>>> On Wed, Jun 26, 2019 at 10:39:36AM +0800, Rong Chen wrote:
>>>> On 6/25/19 10:22 PM, Josef Bacik wrote:
>>>>> On Fri, Jun 21, 2019 at 08:48:03AM +0800, Huang, Ying wrote:
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>>
>>>>>>>> Hi, Josef,
>>>>>>>>
>>>>>>>> kernel test robot <rong.a.chen@intel.com> writes:
>>>>>>>>
>>>>>>>>> Greeting,
>>>>>>>>>
>>>>>>>>> FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve
>>>>>>>>> delalloc metadata differently")
>>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>>>>>>
>>>>>>>>> in testcase: aim7
>>>>>>>>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @
>>>>>>>>> 3.00GHz with 384G memory
>>>>>>>>> with following parameters:
>>>>>>>>>
>>>>>>>>> 	disk: 4BRD_12G
>>>>>>>>> 	md: RAID0
>>>>>>>>> 	fs: btrfs
>>>>>>>>> 	test: disk_rr
>>>>>>>>> 	load: 1500
>>>>>>>>> 	cpufreq_governor: performance
>>>>>>>>>
>>>>>>>>> test-description: AIM7 is a traditional UNIX system level benchmark
>>>>>>>>> suite which is used to test and measure the performance of multiuser
>>>>>>>>> system.
>>>>>>>>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>>>>>>>> Here's another regression, do you have time to take a look at this?
>>>>>>> Ping
>>>>>> Ping again ...
>>>>>>
>>>>> Finally got time to look at this but I can't get the reproducer to work
>>>>>
>>>>> root@destiny ~/lkp-tests# bin/lkp run ~/job-aim.yaml
>>>>> Traceback (most recent call last):
>>>>>           11: from /root/lkp-tests/bin/run-local:18:in `<main>'
>>>>>           10: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            9: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            8: from /root/lkp-tests/lib/yaml.rb:5:in `<top (required)>'
>>>>>            7: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            6: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            5: from /root/lkp-tests/lib/common.rb:9:in `<top (required)>'
>>>>>            4: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            3: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>>            2: from /root/lkp-tests/lib/array_ext.rb:3:in `<top (required)>'
>>>>>            1: from /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require'
>>>>> /usr/share/rubygems/rubygems/core_ext/kernel_require.rb:54:in `require': cannot load such file -- active_support/core_ext/enumerable (LoadError)
>>>> Hi Josef,
>>>>
>>>> I tried the latest lkp-tests, and didn't have the problem. Could you please
>>>> update the lkp-tests repo and run "lkp install" again?
>>>>
>>> I updated it this morning, and I just updated it now, my tree is on
>>>
>>> 2c5b1a95b08dbe81bba64419c482a877a3b424ac
>>>
>>> lkp install says everything is installed except
>>>
>>> No match for argument: libipc-run-perl
>>
>> I've just fixed it. could you add "libipc-run-perl: perl-IPC-Run" to
>> the end of distro/adaptation/fedora?
>>
>> Thanks,
>> Rong Chen
>>
>>
>>>
>>> and it still doesn't run properly.  Thanks,
>
> Hi, Josef,
>
> Do you have time to try it again?  The latest lkp-tests code has the fix merged.

Ping...

Best Regards,
Huang, Ying
