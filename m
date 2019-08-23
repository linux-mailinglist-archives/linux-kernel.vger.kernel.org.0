Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752779A5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfHWCqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 22:46:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:28858 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfHWCqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:46:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 19:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; 
   d="scan'208";a="173339882"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 22 Aug 2019 19:46:34 -0700
Received: from [10.226.38.19] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.19])
        by linux.intel.com (Postfix) with ESMTP id 6781F580258;
        Thu, 22 Aug 2019 19:46:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190822102843.47964-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqJEW0UDqYDTvOeRsZh9WJTeT99JZP8PtkvbnBU2dhYJEQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <bb31715a-64de-3b44-ef43-09bc73819f73@linux.intel.com>
Date:   Fri, 23 Aug 2019 10:46:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJEW0UDqYDTvOeRsZh9WJTeT99JZP8PtkvbnBU2dhYJEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 22/8/2019 8:49 PM, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 5:28 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>> changes in v4:
>>    - As per Rob's review: validate 5.2 and 5.3
>>    - drop unrelated items.
>>
>> changes in v3:
>>    - resolve 'make dt_binding_check' warnings
>>
>> changes in v2:
>>    As per Rob Herring review comments, the following updates
>>   - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>>   - filename is the compatible string plus .yaml
>>   - LGM: Lightning Mountain
>>   - update maintainer
>>   - add intel,syscon under property list
>>   - keep one example instead of two
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you so much for the review and your time.

With Best Regards
Vadivel Murugan
