Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3518E981C2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 19:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfHURuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 13:50:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfHURuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:50:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C2C0B27FF55
Subject: Re: [PATCH v5 10/11] mfd: cros_ec: Use mfd_add_hotplug_devices()
 helper
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20190722133257.9336-1-enric.balletbo@collabora.com>
 <20190722133257.9336-11-enric.balletbo@collabora.com>
 <20190812072407.GD4594@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c33a07f7-6fc3-d8b9-7a2f-c4835ba2082f@collabora.com>
Date:   Wed, 21 Aug 2019 19:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812072407.GD4594@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/8/19 9:24, Lee Jones wrote:
> On Mon, 22 Jul 2019, Enric Balletbo i Serra wrote:
> 
>> Use mfd_add_hotplug_devices() helper to register the subdevices.
> 
> You need to state why this change is useful/required.
> 

The reason for this change is to avoid a bit of boiler plate and be coherent
with the new functions created to register subdevices, as Gwendal pointed to use
that. I'll make explicit in the commit comment on next version.

Thanks,
Enric

>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3:
>> - Add a new patch to use mfd_add_hoplug_devices to register subdevices
>>
>> Changes in v2: None
>>
>>  drivers/mfd/cros_ec_dev.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
