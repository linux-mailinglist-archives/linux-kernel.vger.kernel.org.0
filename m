Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCFFE510E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505545AbfJYQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 12:20:04 -0400
Received: from mail.netline.ch ([148.251.143.178]:57909 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502253AbfJYQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:20:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 210712A6046;
        Fri, 25 Oct 2019 18:20:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id cDFWOZDoYXzC; Fri, 25 Oct 2019 18:20:01 +0200 (CEST)
Received: from thor (116.245.63.188.dynamic.wline.res.cust.swisscom.ch [188.63.245.116])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id CC4982A6045;
        Fri, 25 Oct 2019 18:20:01 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.92.3)
        (envelope-from <michel@daenzer.net>)
        id 1iO2Jl-0005jU-GJ; Fri, 25 Oct 2019 18:20:01 +0200
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
To:     Will Deacon <will@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nicolas Waisman <nico@semmle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20191025110450.10474-1-will@kernel.org>
 <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
 <20191025161804.GA12335@willie-the-truck>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <e2f87ecc-0a8e-253d-107c-5cf6486c4b6a@daenzer.net>
Date:   Fri, 25 Oct 2019 18:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025161804.GA12335@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 6:18 p.m., Will Deacon wrote:
> On Fri, Oct 25, 2019 at 06:06:26PM +0200, Michel Dänzer wrote:
>> On 2019-10-25 1:04 p.m., Will Deacon wrote:
>>> In the highly unlikely event that we fail to allocate the "radeon-crtc"
>>> workqueue, we should bail cleanly rather than blindly march on with a
>>> NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
>>> structure.
>>>
>>> This was reported previously by Nicolas, but I don't think his fix was
>>> correct:
>>
>> Neither is this one I'm afraid. See my feedback on
>> https://patchwork.freedesktop.org/patch/331534/ .
> 
> Thanks. Although I agree with you wrt the original patch, I don't think
> the workqueue allocation failure is distinguishable from the CRTC allocation
> failure with my patch. Are you saying that the error path there is broken
> too?

The driver won't actually work if radeon_crtc_init bails silently, it'll
just fall over at some later point.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
