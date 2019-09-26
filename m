Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA13BEAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 05:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfIZDgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 23:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:38236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfIZDgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:36:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8642EACC4;
        Thu, 26 Sep 2019 03:36:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] perf script python: integrate page reclaim analyze
 script
From:   Tony Jones <tonyj@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, akpm@linux-foundation.org,
        jolsa@redhat.com, mingo@redhat.com
Cc:     linux-mm@kvack.org, florian.schmidt@nutanix.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
 <1568817522-8754-2-git-send-email-laoar.shao@gmail.com>
 <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tonyj@suse.de; prefer-encrypt=mutual; keydata=
 mQGiBEkQmbwRBACDch7wo/RzlNt2HA8jLICsO2w8yOkJ7UTzHYNn3Q83Ro0qev2KokfE3EDw
 il+vam9CDR7jIDmswHqaMe0/O+UnZtO5PlDgylZcrwNwbBzHfm/KGejbi1RBGAoETrvcfwGi
 w83bR/aDnoRXY5Ho1uphQ05/065EMpbJOOBdn9qQ4wCgv2Q6C/QeYDGsxJPRO+20nLu5K00D
 /Rde4OTZ5biM+vb6ObTmgPNeiMrTwGpMokN7audIl7njwvD+lYrlgQjmDzcaPFz29rYWwT7g
 6t6hcFgjpU1he/v3qxeQlTJoi2+u5Mqj42z//49h6DqNjT859Z/6h5IwKBo/EZC17iBIlS2G
 VXAstNiZASGiaIlONozWJ/GSjUaRA/9wZTV1nXF/+xX+qmc7SvTg1w6jWyjxVumQLoq2SeA4
 1Sy5X2IATkAGCCjbeoQGnFdbOnHRSJdlTazObgwreqGPlPnIROpr9QESkfxsaCkDiZfpl0xk
 6X069QMZBEwGAWILHYXL9UqlOjniZaU2BkVA11JEdBhyQorC8T/ji1edc7QaVG9ueSBKb25l
 cyA8dG9ueWpAc3VzZS5kZT6IYAQTEQIAIAUCSRCZvAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheAAAoJELFYWyEf4koXGmYAoKCnbv9dhAB2vR6IvSJem1ws4HpfAJ9ZqTKiXcogBGfTPaJR
 GI9QhVUieLkCDQRJEJm8EAgAzr9Zd3v7B10ODtVc7XxbMe3W6o1FdClL9ZIgLv61zhWctafK
 DMu/MUSvxmYFq00pecD/SfX8oxArA02+sQ2E+/Zb4J7NAWIAxCfmy7VE0wDBrZH/hBapIx/L
 gVqYfZ9Rw+a4FXrlk1y8oQCwhvj+kWrm7V7olR0aPOy1NFGNUyTFSMj+pbmxiNOXdCxVUQe3
 UE1k9yA+mILjyaRanwkiCLCjNvRPL88Q017BdhVBWZmz8qhwXN/RrjCcDHsPX5O0ev68MLyu
 sh5mfukuvCqzW1Y3Ql+iwfwEw5lNmQGdoV9csg7JP7saDicSFO2KcZvMbvDMqtPFipdF5UWo
 fZKZ3wADBQf/b5cVNyb5i8QI0G7BPGBNn4VlQX5n66TsPBnrRNOi3MhTTVEBCp8s+jqUjJjX
 EjjA+O4hIm7Qqdsozurw7GlcQ0A06dIzO/1RUglZZMoC0JL43ZQmJ+3+yFrLjWgGH6ev6AOb
 YLH7ZujgAB5n0Hy2ZIChzsKLKbHptFtBvpDKB8updq+GunsY4oN3wGa67h9sHqDvjyp64Czg
 n8G5uGLwx3f/edbECKz5kPUSzChEk3suK742SEP01v4ra5WX88Hn81NjGByQMz9acJLdC7Ff
 LzXvbNa0KgvDaSllYfsJIoGCz3eKVOuTWXOiaEIKuy833+3mr2PulLCyLKysAEddKohJBBgR
 AgAJBQJJEJm8AhsMAAoJELFYWyEf4koXhgQAn1EGATLZPS53At9t+p3S8BkNI9yRAJ9A0OmL
 liv+rwEesYGlGeGNaKHTJw==
Message-ID: <49489979-0bf1-881c-ebd5-87d0892a7da4@suse.de>
Date:   Wed, 25 Sep 2019 20:36:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <456c8216-a9f4-6821-e688-744e93df826f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/19 6:56 PM, Tony Jones wrote:
> On 9/18/19 7:38 AM, Yafang Shao wrote:
>> A new perf script page-reclaim is introduced in this patch. This new script
>> is used to report the page reclaim details. The possible usage of this
>> script is as bellow,
>> - identify latency spike caused by direct reclaim
>> - whehter the latency spike is relevant with pageout
>> - why is page reclaim requested, i.e. whether it is because of memory
>>   fragmentation
>> - page reclaim efficiency
>> etc
>> In the future we may also enhance it to analyze the memcg reclaim.
>>
>> Bellow is how to use this script,
>>     # Record, one of the following
>>     $ perf record -e 'vmscan:mm_vmscan_*' ./workload
>>     $ perf script record page-reclaim
>>
>>     # Report
>>     $ perf script report page-reclaim
>>
>>     # Report per process latency
>>     $ perf script report page-reclaim -- -p
> 
> 
> I tested it with global-dhp__pagereclaim-performance from mmtests and got what appears to be reasonable results and the output looks correct and useful.  However I'm not a vm expert so I can't comment further.  Hopefully someone on linux-mm can give more specific feedback.
> 
> There is one issue with Python3,  see below.  I didn't test with Python2.

Ok, I guess this wasn't actually tested with Python3 as itervalues() is Python2 only.   Any scripts need to work with both Python2.6+ and Python3.

# perf script -i /tmp/perf.out -s page-reclaim.py -- -p
...

Traceback (most recent call last):
  File "page-reclaim.py", line 305, in trace_end
    i.display_proc(),
  File "page-reclaim.py", line 268, in display_proc
    print_proc_latency(sorted(self.stat.stats['latency'].itervalues(),
AttributeError: 'dict' object has no attribute 'itervalues'
Fatal Python error: problem in Python trace event handler

Use a try/except to handle this.

Thanks

Tony



