Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1631A441B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391928AbfFMQQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:16:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:34431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfFMIlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:41:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 01:41:31 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2019 01:41:28 -0700
Subject: Re: [PATCH 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
To:     Raul Rangel <rrangel@chromium.org>
Cc:     linux-mmc@vger.kernel.org, ernest.zhang@bayhubtech.com,
        djkurtz@chromium.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <20190610185354.35310-2-rrangel@chromium.org>
 <d4939761-317c-ee78-b1e5-c2cdd86a12b4@intel.com>
 <20190612150832.GB27989@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <94fa2a5e-e96d-acb3-46c2-5f6b1dea6711@intel.com>
Date:   Thu, 13 Jun 2019 11:40:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612150832.GB27989@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/19 6:08 PM, Raul Rangel wrote:
> On Wed, Jun 12, 2019 at 04:09:47PM +0300, Adrian Hunter wrote:
>> On 10/06/19 9:53 PM, Raul E Rangel wrote:
>>> The O2 controller supports 8-bit EMMC access. mmc_select_bus_width()
>>> will be used to determine if the MMC supports 8-bit or 4-bit access.
>>
>> The problem is that the bit indicates a host controller capability, not how
>> many data lines there actually are on the board.  Will this break something
>> that does not have 8 lines?
> 
> So I asked the controller vendor about that:
>> The capability shows the host controller can support 1,4,and 8 bit bus
>> data transfer but it also depends on if HW can support it. Driver or FW
>> should implement the bus testing procedure that is defined in A.6.3.a
>> in JESD84-B51 spec to decide the real bus width that is supported in HW.
> 
> This seems to be what `mmc_select_bus_width()` is doing.

Good point.  Can you add this information to the commit message and add a
comment in the code.

> 
> I don't actually have any 4-bit hardware to test with though.
> 
> Thanks for the review!
> 

