Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D33611AE53
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfLKOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 09:52:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:46002 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfLKOwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:52:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 06:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="203587539"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.204]) ([10.255.29.204])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2019 06:52:20 -0800
Subject: Re: [pipe] 3c0edea9b2: lmbench3.PIPE.bandwidth.MB/sec -17.0%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20191208153949.GJ32275@shao2-debian>
 <20191209085559.GA5868@dhcp22.suse.cz>
 <CAHk-=whF0mbvWC=sYKWTrpymmjWkGZcX9hnHgnm1t1M++W66zA@mail.gmail.com>
 <20191210141502.GQ32275@shao2-debian>
 <CAHk-=wjj33OvL17p4XOjTjS-_MMEr5p0RqR9yLGhKWV3cgb57w@mail.gmail.com>
From:   kernel test robot <rong.a.chen@intel.com>
Message-ID: <f96b092d-5b14-a795-819d-ad7536be4ba0@intel.com>
Date:   Wed, 11 Dec 2019 22:52:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjj33OvL17p4XOjTjS-_MMEr5p0RqR9yLGhKWV3cgb57w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2019 1:52 AM, Linus Torvalds wrote:
> On Tue, Dec 10, 2019 at 6:15 AM kernel test robot <rong.a.chen@intel.com> wrote:
>> Hi Linus,
>>
>> Sorry for the inconvenience, indeed, the regression has been fixed.
> Woohoo.. And more than fixed, it looks like. Not that I looked at
> historical data, I'm not sure how much this number normally
> fluctuates. I'm assuming the stddev is just a per-boot "do it a few
> times" rather than any long-term thing?
>
>                  Linus

Hi Linus,

Yes, the stddev is not very precise, we usually boot more than three 
times to
get the value.

Best Regards,
Rong Chen


