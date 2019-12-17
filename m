Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C250122AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfLQLzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 06:55:10 -0500
Received: from olimex.com ([184.105.72.32]:57858 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:55:10 -0500
Received: from 94.155.250.134 ([94.155.250.134])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:54:59 -0800
Subject: Re: [PATCH 1/1] drm/sun4i: hdmi: Check for null pointer before
 cleanup
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20191216144348.7540-1-stefan@olimex.com>
 <20191216161258.lmkq2ersfm746t7q@gilmour.lan>
 <cebda755-2649-79a1-fd08-79b13edef1a5@olimex.com>
 <20191217114603.6cyrfx3sekn6uwmp@gilmour.lan>
 <20191217114906.lrjup35tngrjhwuj@gilmour.lan>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <83088170-1753-6a2f-aa25-c4f6f54462d6@olimex.com>
Date:   Tue, 17 Dec 2019 13:54:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217114906.lrjup35tngrjhwuj@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/17/19 1:49 PM, Maxime Ripard wrote:
> On Tue, Dec 17, 2019 at 12:46:03PM +0100, Maxime Ripard wrote:
>> On Tue, Dec 17, 2019 at 08:45:07AM +0200, Stefan Mavrodiev wrote:
>>> Hi,
>>>
>>> On 12/16/19 6:12 PM, Maxime Ripard wrote:
>>>> Hi,
>>>>
>>>> On Mon, Dec 16, 2019 at 04:43:48PM +0200, Stefan Mavrodiev wrote:
>>>>> It's possible hdmi->connector and hdmi->encoder divices to be NULL.
>>>>> This can happen when building as kernel module and you try to remove
>>>>> the module.
>>>>>
>>>>> This patch make simple null check, before calling the cleanup functions.
>>>>>
>>>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>>>> ---
>>>>>    drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>>>>> index a7c4654445c7..b61e00f2ecb8 100644
>>>>> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>>>>> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
>>>>> @@ -685,8 +685,10 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
>>>>>    	struct sun4i_hdmi *hdmi = dev_get_drvdata(dev);
>>>>>
>>>>>    	cec_unregister_adapter(hdmi->cec_adap);
>>>>> -	drm_connector_cleanup(&hdmi->connector);
>>>>> -	drm_encoder_cleanup(&hdmi->encoder);
>>>>> +	if (hdmi->connector.dev)
>>>>> +		drm_connector_cleanup(&hdmi->connector);
>>>>> +	if (hdmi->encoder.dev)
>>>>> +		drm_encoder_cleanup(&hdmi->encoder);
>>>> Hmmm, this doesn't look right. Do you have more information on how you
>>>> can reproduce it?
>>> Just build sun4i_drm_hdmi as module (CONFIG_DRM_SUN4I_HDMI=m). Then try to
>>> unload the module:
>>>
>>> # rmmod sun4i_drm_hdmi
>>>
>>> And you get this:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>> pgd = 6b032436
>>> [00000000] *pgd=00000000
>>> Internal error: Oops: 5 [#1] SMP ARM
>>> Modules linked in: sun4i_drm_hdmi(-)
>>> CPU: 0 PID: 1081 Comm: rmmod Not tainted 5.5.0-rc1-00030-g6ec417030d93 #33
>>> Hardware name: Allwinner sun7i (A20) Family
>>> PC is at drm_connector_cleanup+0x40/0x208
>>> LR is at sun4i_hdmi_unbind+0x10/0x54 [sun4i_drm_hdmi]
>>> ...
>>>
>>>
>>> I've tested that with sunxi/for-next branch on A20-OLinuXino board.
>> Yeah, you detailed the symptoms nicely in the commit log, but my point
>> was that we shouldn't end up in that situation in the first place.
>>
>> Your patch works around it, but it doesn't fix the underlying
>> issue. Is drm_connector_cleanup (or the encoder variant) called twice?
> Answering myself, yes it is. It's both the destroy call back and
> called in unbind. We should just remove the one in the unbind then.

Should I do this or leave it to you?

Stefan

>
> Maxime
