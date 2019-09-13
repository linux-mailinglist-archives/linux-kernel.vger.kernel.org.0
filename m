Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64D8B1A87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbfIMJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 05:12:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbfIMJM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:12:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F2FD28;
        Fri, 13 Sep 2019 02:12:56 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823273F59C;
        Fri, 13 Sep 2019 02:12:55 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20190905121141.42820-1-steven.price@arm.com>
 <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
 <d0fb9ba9-d8af-1523-192c-23376e467f12@arm.com>
 <CAKMK7uF1PYEPjQBvZwFOzAtjQ4YbY7AWj5mV106fvk_e=2ohsw@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3a82ea91-c178-0ada-d762-3f3802dfc7c5@arm.com>
Date:   Fri, 13 Sep 2019 10:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uF1PYEPjQBvZwFOzAtjQ4YbY7AWj5mV106fvk_e=2ohsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2019 20:36, Daniel Vetter wrote:
> On Fri, Sep 6, 2019 at 2:42 PM Steven Price <steven.price@arm.com> wrote:
>>
>> On 06/09/2019 12:10, Rob Herring wrote:
>>> On Thu, Sep 5, 2019 at 1:11 PM Steven Price <steven.price@arm.com> wrote:
>>>>
>>>> When handling a GPU page fault addr_to_drm_mm_node() is used to
>>>> translate the GPU address to a buffer object. However it is possible for
>>>> the buffer object to be freed after the function has returned resulting
>>>> in a use-after-free of the BO.
>>>>
>>>> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
>>>> extra reference on it, preventing the BO from being freed until after
>>>> the page fault has been handled.
>>>>
>>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>>> ---
>>>>
>>>> I've managed to trigger this, generating the following stack trace.
>>>
>>> Humm, the assumption was that a fault could only happen during a job
>>> and so a reference would already be held. Otherwise, couldn't the GPU
>>> also be accessing the BO after it is freed?
>>
>> Ah, I guess I missed that in the commit message. This is assuming that
>> user space doesn't include the BO in the job even though the GPU then
>> does try to access it. AIUI mesa wouldn't do this, but this is still
>> easily possible if user space wants to crash the kernel.
> 
> Do we have some nice regression tests for uapi exploits and corner
> cases like this? Maybe even in igt?
> -Daniel

Not currently, I've been playing with the idea of getting the
closed-source DDK blob running on Panfrost and this is what generates
the "not-quite-mesa" usage.

It would definitely be good extend the test cases in IGT, I have a
synthetic test which can trigger this - I just need to get approval to
post it.

Steve
