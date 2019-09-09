Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD55AD94E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfIIMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 08:45:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:31239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfIIMpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 08:45:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 05:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="383963542"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga005.fm.intel.com with ESMTP; 09 Sep 2019 05:44:58 -0700
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
 <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
 <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
 <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3d83db18-7e80-944c-fc4b-244249c71bbf@intel.com>
Date:   Mon, 9 Sep 2019 15:43:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKsk7ZN2BnD4zp53PQE22jD-BTsJLL53SL3ndZ5=OCHYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/09/19 3:16 PM, Baolin Wang wrote:
> Hi Adrian,
> 
> On Mon, 9 Sep 2019 at 20:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 6/09/19 6:52 AM, Baolin Wang wrote:
>>> Now the MMC read/write stack will always wait for previous request is
>>> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
>>> or queue a work to complete request, that will bring context switching
>>> overhead, especially for high I/O per second rates, to affect the IO
>>> performance.
>>>
>>> Thus this patch introduces virtual command queue interface, which is
>>> similar with the hardware command queue engine's idea, that can remove
>>> the context switching.
>>
>> CQHCI is a hardware interface for eMMC's that support command queuing.  What
>> you are doing is a software issue queue, unrelated to CQHCI.  I think you
> 
> Yes.
> 
>> should avoid all reference to CQHCI i.e. call it something else.
> 
> Since its process is similar with CQHCI and re-use the CQHCI's
> interfaces, I called it virtual command queue. I am not sure what else
> name is better, any thoughts? VCQHCI? Thanks.

What about swq for software queue.  Maybe Ulf can suggest something?
