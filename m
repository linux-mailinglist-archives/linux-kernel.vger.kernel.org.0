Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5280348B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfFDNbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:31:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43858 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfFDNbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:31:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2916DA78;
        Tue,  4 Jun 2019 06:31:19 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2E63F690;
        Tue,  4 Jun 2019 06:31:15 -0700 (PDT)
Subject: Re: [RFC PATCH 20/57] platform: Add a helper to find device by driver
To:     heiko@sntech.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com,
        hjc@rock-chips.com, eric@anholt.net
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-21-git-send-email-suzuki.poulose@arm.com>
 <2117016.xXqOXZeE10@phil>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fdd6822e-866a-5483-42ce-3a1131f35f3b@arm.com>
Date:   Tue, 4 Jun 2019 14:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2117016.xXqOXZeE10@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 04/06/2019 14:29, Heiko Stuebner wrote:
> Hi,
> 
> Am Montag, 3. Juni 2019, 17:49:46 CEST schrieb Suzuki K Poulose:
>> There are a couple of places where we reuse platform specific
>> match to find a device. Instead of spilling the global varilable
>> everywhere, let us provide a helper to do the same.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Inki Dae <inki.dae@samsung.com>
>> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
>> Cc: Sandy Huang <hjc@rock-chips.com>
>> Cc: "Heiko Stübner" <heiko@sntech.de>
>> Cc: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
>> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
>> index cc46485..a82b3ec 100644
>> --- a/include/linux/platform_device.h
>> +++ b/include/linux/platform_device.h
>> @@ -52,6 +52,9 @@ extern struct device platform_bus;
>>   extern void arch_setup_pdev_archdata(struct platform_device *);
>>   extern struct resource *platform_get_resource(struct platform_device *,
>>   					      unsigned int, unsigned int);
>> +extern struct device *
>> +platform_find_device_by_driver(struct device dev*,
>> +			       const struct device_driver *drv);
> 
> the "dev*" causes compilation errors and also doesn't match the
> function definition. With "dev*" -> "*start" it compiles again and
> my rockchip drm driver still manages to find its components, so
> after the above issue is fixed:
> 

Thanks for spotting, I have fixed this already locally.

> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks a lot for the testing !

Suzuki
