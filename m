Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D613142A29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgATMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 07:10:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgATMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5E31C292B10
Subject: Re: [PATCH] regulator: vctrl-regulator: Avoid deadlock getting and
 setting the voltage
To:     Mark Brown <broonie@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        drinkcat@chromium.org, dianders@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>, mka@chromium.org
References: <20200116094543.2847321-1-enric.balletbo@collabora.com>
 <1fdaed3c-05e0-4756-5013-5cc59a766e2f@gmail.com>
 <20200120120830.GA6852@sirena.org.uk>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <73a24487-d9ff-88c3-2516-69ae89915c88@collabora.com>
Date:   Mon, 20 Jan 2020 13:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120120830.GA6852@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/20 13:08, Mark Brown wrote:
> On Fri, Jan 17, 2020 at 07:28:04PM +0300, Dmitry Osipenko wrote:
>> 16.01.2020 12:45, Enric Balletbo i Serra пишет:
> 
>>> +EXPORT_SYMBOL(regulator_set_voltage_rdev);
>>>  
>>>  static int regulator_limit_voltage_step(struct regulator_dev *rdev,
>>>  					int *current_uV, int *min_uV)
>>> @@ -4034,6 +4035,7 @@ int regulator_get_voltage_rdev(struct regulator_dev *rdev)
>>>  		return ret;
>>>  	return ret - rdev->constraints->uV_offset;
>>>  }
>>> +EXPORT_SYMBOL(regulator_get_voltage_rdev);
> 
>> I think it should be EXPORT_SYMBOL_GPL().
> 
> Yes, you're right.
> 

Oops, right, Mark do you want me to send a follow-up patch, a second version or
you can just apply a fix?

Thanks,
 Enric
