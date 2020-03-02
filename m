Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21214175DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCBO6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 09:58:38 -0500
Received: from foss.arm.com ([217.140.110.172]:33832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCBO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:58:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99EA1045;
        Mon,  2 Mar 2020 06:58:35 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 673023F534;
        Mon,  2 Mar 2020 06:58:34 -0800 (PST)
Subject: Re: [PATCH RFT v2 0/3] devfreq fixes for panfrost
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, sudeep.holla@arm.com,
        linux-amlogic@lists.infradead.org, robin.murphy@arm.com,
        alyssa@rosenzweig.io
References: <20200112001623.2121227-1-martin.blumenstingl@googlemail.com>
 <CAFBinCBLJyPxOBv0JNe7o0ME3rvPi+2Qv7Lwgw6T92f15ZXcxA@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <6f0693f9-3efe-d1f0-18b1-90dda7b3d0a4@arm.com>
Date:   Mon, 2 Mar 2020 14:58:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBLJyPxOBv0JNe7o0ME3rvPi+2Qv7Lwgw6T92f15ZXcxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2020 19:42, Martin Blumenstingl wrote:
> Hi Steven,
> 
> On Sun, Jan 12, 2020 at 1:16 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
[...]
>>
>>
>> Martin Blumenstingl (3):
>>   drm/panfrost: enable devfreq based the "operating-points-v2" property
>>   drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
>>   drm/panfrost: Use the mali-supply regulator for control again
> I don't have time to work on these patches in the near future
> can you (or if someone else is interested then please speak up) please
> take these over? you are familiar with the panfrost devfreq code and
> you have at least one board where the GPU regulator actually has to
> change the voltage (which means you can test this properly; on Amlogic
> SoCs the GPU voltage is fixed across all frequencies).

Hi Martin,

Sorry for the slow response - yes I can pick this up. Although I've got
some other things to catch up with first.

Thanks,

Steve
