Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1BB1CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfIMMBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 08:01:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55404 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfIMMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:01:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 03BAD28BB6B
Subject: Re: [PATCH 0/2] drm/panfrost: Tidy up the devfreq implementation
To:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190912112804.10104-1-steven.price@arm.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <8be4769c-3162-efbb-ea66-05b8404188fc@collabora.com>
Date:   Thu, 12 Sep 2019 15:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190912112804.10104-1-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/19 12:28 PM, Steven Price wrote:
> The devfreq implementation in panfrost is unnecessarily open coded. It
> also tracks utilisation metrics per slot which isn't very useful. Let's
> tidy it up!
> 
> This should be picked up along with Mark's change[1] to fix
> regulator_get_optional() misuse. This also deletes the code changes from
> 52282163dfa6 and e21dd290881b which would otherwise need reverting, see
> the previous discussion[2].

Both patches look great.

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks!

Tomeu

> [1] https://lore.kernel.org/lkml/20190904123032.23263-1-broonie@kernel.org/
> [2] https://lore.kernel.org/lkml/ccd81530-2dbd-3c02-ca0a-1085b00663b5@arm.com/
> 
> Steven Price (2):
>    drm/panfrost: Use generic code for devfreq
>    drm/panfrost: Simplify devfreq utilisation tracking
> 
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 126 ++++++--------------
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h |   3 +-
>   drivers/gpu/drm/panfrost/panfrost_device.h  |  14 +--
>   drivers/gpu/drm/panfrost/panfrost_job.c     |  14 +--
>   4 files changed, 48 insertions(+), 109 deletions(-)
> 
