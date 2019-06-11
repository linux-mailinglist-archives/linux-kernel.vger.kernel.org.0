Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030183CDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfFKN5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:57:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:42646 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387835AbfFKN5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:57:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 06:57:18 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2019 06:57:16 -0700
Subject: Re: A potential broken at platform driver?
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Romain Izard <romain.izard.pro@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
 <20190603180255.GA18054@kroah.com> <20190604103241.GA4097@5WDYG62>
 <20190604142803.GA28355@kroah.com>
 <e3adbd00-e500-70af-1c27-e4c064486561@linux.intel.com>
 <20190604170310.GC14605@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <f484ce9f-a86e-ce33-686b-b42dc293beb8@linux.intel.com>
Date:   Tue, 11 Jun 2019 09:10:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604170310.GC14605@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 6/4/19 12:03 PM, Greg KH wrote:
> On Tue, Jun 04, 2019 at 11:13:02AM -0500, Richard Gong wrote:
>>
>> Hi Greg,
>>
>> On 6/4/19 9:28 AM, Greg KH wrote:
>>> On Tue, Jun 04, 2019 at 12:33:03PM +0200, Romain Izard wrote:
>>>> On Mon, Jun 03, 2019 at 08:02:55PM +0200, Greg KH wrote:
>>>>>> @@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
>>>>>>    	.remove = stratix10_rsu_remove,
>>>>>>    	.driver = {
>>>>>>    		.name = "stratix10-rsu",
>>>>>> -		.groups = rsu_groups,
>>>>>> +//		.groups = rsu_groups,
>>>>>
>>>>> Are you sure this is the correct pointer?  I think that might be
>>>>> pointing to the driver's attributes, not the device's attributes.
>>>>>
>>>>> If platform drivers do not have a way to register groups properly, then
>>>>> that really needs to be fixed, as trying to register it by yourself as
>>>>> you are doing, is ripe for racing with userspace.
>>>> This is a very common issue with platform drivers, and it seems to me that
>>>> it is not possible to add device attributes when binding a device to a
>>>> driver without entering the race condition.
>>>>
>>>> My understanding is the following one:
>>>>
>>>> The root cause is that the device has already been created and reported
>>>> to the userspace with a KOBJ_ADD uevent before the device and the driver
>>>> are bound together. On receiving this event, userspace will react, and
>>>> it will try to read the device's attributes. In parallel the kernel will
>>>> try to find a matching driver. If a driver is found, the kernel will
>>>> call the probe function from the driver with the device as a parameter,
>>>> and if successful a KOBJ_BIND uevent will be sent to userspace, but this
>>>> is a recent addition.
>>>>
>>>> Unfortunately, not all created devices will be bound to a driver, and the
>>>> existing udev code relies on KOBJ_ADD uevents rather than KOBJ_BIND uevents.
>>>> If new per-device attributes have been added to the device during the
>>>> binding stage userspace may or may not see them, depending on when userspace
>>>> tries to read the device's attributes.
>>>>
>>>> I have this possible workaround, but I do not know if it is a good solution:
>>>>
>>>> When binding the device and the driver together, create a new device as a
>>>> child to the current device, and fill its "groups" member to point to the
>>>> per-device attributes' group. As the device will be created with all the
>>>> attributes, it will not be affected by the race issues. The functions
>>>> handling the attributes will need to be modified to use the parents of their
>>>> "device" parameter, instead of the device itself. Additionnaly, the sysfs
>>>> location of the attributes will be different, as the child device will show
>>>> up in the sysfs path. But for a newly introduced device this will not be
>>>> a problem.
>>>>
>>>> Is this a good compromise ?
>>>
>>> Not really.  You just want the attributes on the platform device itself.
>>>
>>> Given the horrible hack that platform devices are today, what's one more
>>> hack!
>>>
>>> Here's a patch below of what should probably be done here.  Richard, can
>>> you change your code to use the new dev_groups pointer in the struct
>>> platform_driver and this patch and let me know if that works or not?
>>>
>>> Note, I've only compiled this code, not tested it...
>>>
>>
>> Your patch works.
>>
>> Many thanks for your help!
> 
> Nice!
> 
> I guess I need to turn it into a real patch now.  Let me do that tonight
> and see if I can convert some existing drivers to use it as well...
> 

Sorry for asking.

I haven't seen your patch, did you release that?

Regards,
Richard

> thanks,
> 
> greg k-h
> 
