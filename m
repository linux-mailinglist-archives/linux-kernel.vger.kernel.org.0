Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331B4168747
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 20:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgBUTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 14:11:38 -0500
Received: from foss.arm.com ([217.140.110.172]:46268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgBUTLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:11:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A474E30E;
        Fri, 21 Feb 2020 11:11:36 -0800 (PST)
Received: from [10.37.12.243] (unknown [10.37.12.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3460D3F6CF;
        Fri, 21 Feb 2020 11:11:34 -0800 (PST)
Subject: Re: [RFC PATCH v2 07/13] firmware: arm_scmi: Add notification
 dispatch and delivery
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200214153535.32046-1-cristian.marussi@arm.com>
 <20200214153535.32046-8-cristian.marussi@arm.com>
 <e45e87e2-aaaf-c35b-b864-c080fd6e0ba6@arm.com>
 <d59c3f3e-324b-05fe-547d-1e64bf4c6a69@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <af8d2a1e-e78e-6d0e-4ffc-3af94cdc6784@arm.com>
Date:   Fri, 21 Feb 2020 19:11:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d59c3f3e-324b-05fe-547d-1e64bf4c6a69@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/20 7:01 PM, Cristian Marussi wrote:
> Hi Lukasz
> 
> Thanks for your feedback !
> 
> On 21/02/2020 13:25, Lukasz Luba wrote:
>> Hi Cristian,
>>
>> I didn't want to jump into your discussion with Jim in other broader
>> thread with this small thought, so I added a comment below.
>>
>> On 2/14/20 3:35 PM, Cristian Marussi wrote:
>>> Add core SCMI Notifications dispatch and delivery support logic which is
>> [snip]
>>
>>>    
>>> @@ -840,6 +1071,11 @@ static struct scmi_notify_ops notify_ops = {
>>>     */
>>>    int scmi_notification_init(struct scmi_handle *handle)
>>>    {
>>> +	scmi_notify_wq = alloc_workqueue("scmi_notify",
>>> +					 WQ_UNBOUND | WQ_FREEZABLE, 0);
>>
>> I think it might limit some platforms. It depends on their workload.
>> If they have some high priority workloads which rely on this mechanisms,
>> they might need a RT task here. The workqueues would be scheduled in
>> CFS, so it depends on workload in there (we might even see 10s ms delays
>> in scheduling-up them). If we use RT we would grab the CPU from CFS.
>>
>> It would be good if it is a customization option: which mechanism
>> to use based on some a parameter. Then we could create:
>> a) workqueue with the flags above
>> b) workqueue with WQ_HIGHPRI (limited by minimum nice)
>> c) kthread_create_worker() with RT/DL/FIFO sched policy
>>     (with also a parameterized priority)
>> In default clients might use a) but when they want to tune their
>> platform, they might change only a parameter in their scmi code,
>> not maintaining a patch for the RT function out of tree.
> 
> In this series, I have not addressed configurability issues at all (as noted in the cover):
> in fact I was thinking that stuff like WQ_HIGHPRI flags and per-protocol queue sizes could
> be beneficial to be customizable depending on the specific platform, but I had not gone to
> the extreme of thinking of adopting a dedicated RT kthread as a worker...good point...it
> makes surely sense to have this configurable option to try to reduce the latency where possible.
> 
> I think it's important to give the user the possibility to configure the deferred worker
> as you suggested, if the user decides to rely on Linux to handle a critical notification,
> but I'd prefer queuing up this work you suggested on a different series on top of this one.
> (which is starting to be a little to much voluminous...for being just the core support)

Agree, you can build these features incrementally.

Regards,
Lukasz

