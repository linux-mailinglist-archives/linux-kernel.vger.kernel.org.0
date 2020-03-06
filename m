Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C717B995
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCFJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 04:51:38 -0500
Received: from foss.arm.com ([217.140.110.172]:58688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgCFJvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:51:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A96831B;
        Fri,  6 Mar 2020 01:51:37 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01543F6C4;
        Fri,  6 Mar 2020 01:51:35 -0800 (PST)
Subject: Re: [PATCH] drm: komeda: Make rt_pm_ops dependent on CONFIG_PM
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, nd@arm.com
References: <20200304145412.33936-1-vincenzo.frascino@arm.com>
 <20200305184255.GH364558@e110455-lin.cambridge.arm.com>
 <20200306041407.GA27096@jamwan02-TSP300>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <053abb02-cdeb-76f8-d651-88734a338010@arm.com>
Date:   Fri, 6 Mar 2020 09:51:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200306041407.GA27096@jamwan02-TSP300>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/6/20 4:14 AM, james qian wang (Arm Technology China) wrote:
> On Fri, Mar 06, 2020 at 02:42:55AM +0800, Liviu Dudau wrote:
>> On Wed, Mar 04, 2020 at 02:54:12PM +0000, Vincenzo Frascino wrote:
>>> komeda_rt_pm_suspend() and komeda_rt_pm_resume() are compiled only when
>>> CONFIG_PM is enabled. Having it disabled triggers the following warning
>>> at compile time:
>>>
>>> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:156:12:
>>> warning: ‘komeda_rt_pm_resume’ defined but not used [-Wunused-function]
>>>  static int komeda_rt_pm_resume(struct device *dev)
>>>             ^~~~~~~~~~~~~~~~~~~
>>> linux/drivers/gpu/drm/arm/display/komeda/komeda_drv.c:149:12:
>>> warning: ‘komeda_rt_pm_suspend’ defined but not used [-Wunused-function]
>>>  static int komeda_rt_pm_suspend(struct device *dev)
>>>
>>> Make komeda_rt_pm_suspend() and komeda_rt_pm_resume() dependent on
>>> CONFIG_PM to address the issue.
>>>
>>> Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
>>> Cc: Brian Starkey <brian.starkey@arm.com>
>>> Cc: David Airlie <airlied@linux.ie>
>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
> 
> Hi Vincenzo:
> 
> Thanks for the patch.
> 
> and Vincenzo & Liviu, sorry
> 
> Since there is a patch for this problem already:
> https://patchwork.freedesktop.org/series/71721/
> 
> And I have pushed that old fix to drm-misc-fixes just before I saw
> this mail. sorry.
> 

No issue, as far as it is fixed :) It is annoying stepping on it during
randconfig :)

Thanks for letting me know!

[...]

-- 
Regards,
Vincenzo
