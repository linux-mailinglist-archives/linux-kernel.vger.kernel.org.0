Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BC189785
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 10:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCRJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 05:01:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgCRJB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:01:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A10E631B;
        Wed, 18 Mar 2020 02:01:58 -0700 (PDT)
Received: from [10.37.12.57] (unknown [10.37.12.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31F5D3F52E;
        Wed, 18 Mar 2020 02:01:57 -0700 (PDT)
Subject: Re: [PATCH v5 00/13] SCMI Notifications Core Support
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com
References: <20200316150334.47463-1-cristian.marussi@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e51598b5-2c7b-56f2-4426-9cce3d5d3d52@arm.com>
Date:   Wed, 18 Mar 2020 09:01:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200316150334.47463-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 3/16/20 3:03 PM, Cristian Marussi wrote:
> Hi all,
> 
> this series wants to introduce SCMI Notification Support, built on top of
> the standard Kernel notification chain subsystem.
> 
> At initialization time each SCMI Protocol takes care to register with the
> new SCMI notification core the set of its own events which it intends to
> support.
> 
> Using the API exposed via scmi_handle.notify_ops a Kernel user can register
> its own notifier_t callback (via a notifier_block as usual) against any
> registered event as identified by the tuple:
> 
> 		(proto_id, event_id, src_id)
> 
> where src_id represents a generic source identifier which is protocol
> dependent like domain_id, performance_id, sensor_id and so forth.
> (users can anyway do NOT provide any src_id, and subscribe instead to ALL
>   the existing (if any) src_id sources for that proto_id/evt_id combination)
> 
> Each of the above tuple-specified event will be served on its own dedicated
> blocking notification chain, dynamically allocated on-demand when at least
> one user has shown interest on that event.
> 
> Upon a notification delivery all the users' registered notifier_t callbacks
> will be in turn invoked and fed with the event_id as @action param and a
> generated custom per-event struct _report as @data param.
> (as in include/linux/scmi_protocol.h)
> 
> The final step of notification delivery via users' callback invocation is
> instead delegated to a pool of deferred workers (Kernel cmwq): each
> SCMI protocol has its own dedicated worker and dedicated queue to push
> events from the rx ISR to the worker.
> 

Could you give an example how the notification would be delivered
further to the upper layers, like hwmon driver, cpufreq or thermal?
For example, for sensor protocol which delivers event
SENSOR_TRIP_POINT_EVENT indicating a trip point was crossed.

Would it be possible for:
drivers/hwmon/scmi-hwmon.c
to get this temperature events like an interrupt?

I couldn't find it in the implementation of the registered handlers.

Regards,
Lukasz
