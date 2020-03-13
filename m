Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B659D1842C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 09:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMIg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 04:36:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:46987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgCMIg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:36:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 01:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="322729313"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2020 01:36:26 -0700
Received: from [10.226.39.34] (unknown [10.226.39.34])
        by linux.intel.com (Postfix) with ESMTP id 160B3580107;
        Fri, 13 Mar 2020 01:36:23 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add YAML schemas for Intel
 Combophy
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1583127977.git.eswara.kota@linux.intel.com>
 <20200303015051.GA780@bogus>
 <5b71670d-91a6-9760-f4da-1b6f014a1ea2@linux.intel.com>
 <CAL_JsqLKFbaiaeNAq_b9xDQRWVG8dXkWt2+cKucRPEzynC20XQ@mail.gmail.com>
 <068bcf8c-83b0-57ee-3fb8-c0fe1bf6e5d8@linux.intel.com>
Message-ID: <80c837f0-b708-5f5a-ae65-cd20ae71a2d6@linux.intel.com>
Date:   Fri, 13 Mar 2020 16:36:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <068bcf8c-83b0-57ee-3fb8-c0fe1bf6e5d8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 3/4/2020 5:16 PM, Dilip Kota wrote:
>
> On 3/4/2020 12:26 AM, Rob Herring wrote:
>> On Tue, Mar 3, 2020 at 3:24 AM Dilip Kota 
>> <eswara.kota@linux.intel.com> wrote:
>>>
>>> On 3/3/2020 9:50 AM, Rob Herring wrote:
>>>> On Mon, Mar 02, 2020 at 04:43:24PM +0800, Dilip Kota wrote:
>>>>> Combophy subsystem provides PHY support to various
>>>>> controllers, viz. PCIe, SATA and EMAC.
>>>>> Adding YAML schemas for the same.
...
>>>>> +  - |
>>>>> +    #include <dt-bindings/phy/phy-intel-combophy.h>
>>>>> +    combophy@d0a00000 {
>>>>> +        compatible = "intel,combophy-lgm", "intel,combo-phy";
>>>>> +        clocks = <&cgu0 1>;
>>>>> +        reg = <0xd0a00000 0x40000>,
>>>>> +              <0xd0a40000 0x1000>;
>>>>> +        reg-names = "core", "app";
>>>>> +        resets = <&rcu0 0x50 6>,
>>>>> +                 <&rcu0 0x50 17>;
>>>>> +        reset-names = "phy", "core";
>>>>> +        intel,syscfg = <&sysconf 0>;
>>>>> +        intel,hsio = <&hsiol 0>;
>>>>> +        intel,phy-mode = <COMBO_PHY_PCIE>;
>>>>> +
>>>>> +        phy@0 {
>>>> You need a 'reg' property to go with a unit-address.
>>>>
>>>> Really, I'd just simplify this to make parent 'resets' be 4 entries 
>>>> and
>>>> put '#phy-cells = <1>;' in the parent. Then you don't need these child
>>>> nodes.
>>> If child nodes are not present, use case like PCIe controller-0 using
>>> phy@0 and PCIe controller-1 using phy@1 wont be possible.
>> Yes, it will be.
>>
>> For controller-0:
>> phys = <&phy 0>;
>>
>> For controller-1:
>> phys = <&phy 1>;
>
> OH got it, arg cell can be utilized for PHY id.
> I started working on your suggestion in simplifying it, but below 
> point is haunting while doing the changes. So felt to check with you 
> whether the better one is going with existing DT node or the one 
> without child nodes!.
>      Existing DT node skeleton, replicates hardware design ComboPhy 
> with 2 PHYs. (ComboPhy as parent node and 2PHYs as child nodes)
In the patchwork, i see the patch state is 'Change Requested', so felt 
to keep a remainder mail for your inputs on above query.
I have waiting to push the appropriate code changes based on your comment.

Thanks,
Dilip

>
> Regards,
> Dilip
>
>>
>> Rob
