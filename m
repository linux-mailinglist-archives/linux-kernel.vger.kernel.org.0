Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3C108D73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfKYMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 07:01:35 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:63357 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKYMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:01:35 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 25 Nov
 2019 20:01:56 +0800
Subject: Re: [PATCH v2 3/3] clk: meson: a1: add support for Amlogic A1 clock
 driver
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com>
 <1571382865-41978-4-git-send-email-jian.hu@amlogic.com>
 <1jsgnmba1a.fsf@starbuckisacylon.baylibre.com>
 <49b33e94-910b-3fd9-4da1-050742d07e93@amlogic.com>
 <1jblts3v7e.fsf@starbuckisacylon.baylibre.com>
 <f02b6fb2-5b98-0930-6d47-a3e65840fb82@amlogic.com>
 <1jh839f2ue.fsf@starbuckisacylon.baylibre.com>
 <20d04452-fc63-9e9e-220f-146b493a860f@amlogic.com>
 <1695e9b0-1730-eef6-491d-fe90ac897ee9@amlogic.com>
 <1jtv6yftmm.fsf@starbuckisacylon.baylibre.com>
 <9e652ed1-384e-f630-f2a4-0aa4486df577@amlogic.com>
 <1j7e3oqn36.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <9ec317e8-136e-1ab4-4e9b-21210e7f3e05@amlogic.com>
Date:   Mon, 25 Nov 2019 20:01:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1j7e3oqn36.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/25 18:14, Jerome Brunet wrote:
> 
> On Thu 21 Nov 2019 at 04:21, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> Hi, Jerome
>>
>> On 2019/11/20 23:35, Jerome Brunet wrote:
>>>
>>> On Wed 20 Nov 2019 at 10:28, Jian Hu <jian.hu@amlogic.com> wrote:
>>>
>>>> Hi, jerome
>>>>
>>>> Is there any problem about fixed_pll_dco's parent_data?
>>>>
>>>> Now both name and fw_name are described in parent_data.
>>>
>>> Yes, there is a problem.  This approach is incorrect, as I've tried to
>>> explain a couple times already. Let me try to re-summarize why this
>>> approach is incorrect.
>>>
>>> Both fw_name and name should be provided when it is possible that
>>> the DT does not describe the input clock. IOW, it is only for controllers
>>> which relied on the global name so far and are now starting to describe
>>> the clock input in DT
>>>
>>> This is not your case.
>>> Your controller is new and DT will have the correct
>>> info
>>>
>>> You are trying work around an ordering issue by providing both fw_name
>>> and name. This is not correct and I'll continue to nack it.
>>>
>>> If the orphan clock is not reparented as you would expect, I suggest you
>>> try to look a bit further at how the reparenting of orphans is done in
>>> CCF and why it does not match your expectation.
>>>
>> I have debugged the handle for orphan clock in CCF, Maybe you are missing
>> the last email.
> 
> Nope, got it the first time
> 
>> Even though the clock index exit, it will get failed for the orphan clock's
>> parent clock due to it has not beed added to the provider.
> 
> If the provider is not registered yet, of course any query to it won't
> work. This why I have suggested to this debug *further* :
> 
> * Is the orphan reparenting done when a new provider is registered ?
> * If not, should it be done ? is this your problem ?
> 
Yes, the orphan reparenting is done when the new provider is registered.

Reparenting the orphan will be done when each clock is registered by 
devm_clk_hw_register. And at this time the provider has not been 
registered. After all clocks are registered by devm_clk_hw_register, the
provider will be registered by devm_of_clk_add_hw_provider.

Reparenting the orphan will fail when fw_name is added alone, the couse 
is that devm_clk_hw_register is always running ahead of 
devm_of_clk_add_hw_provider.

That is why it will failed to get parent for the orphan clock.



> 
> .
> 
