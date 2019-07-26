Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A176C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfGZO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:57:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55968 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfGZO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:57:08 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D6EE85C02B3;
        Fri, 26 Jul 2019 16:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1564153026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKw/2BALKQNgmImrcFcR8qt4PZbrmJFQiHxkm8oGnN0=;
        b=IF6peK+cmaLIt7j7RZ7TU9ze6nNP7kz+xzoXwfKhB8cYiMZCzvc6jsy/cQQvAM8pPKBVhm
        /PC5gP1r95Xmk0H433os/KLAO2si4zkauLP7EpHjCEWEqUcPkEIVqHm7bgGgtNHjDlDeAt
        uRiWb1fcfMmKA5gfsUDYuQNSK1BGLQA=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Fri, 26 Jul 2019 16:57:05 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: return with probe defer if GPIO subsystem is
 not ready
In-Reply-To: <f035a8ba-ffa7-b98b-a444-db8b4bbd34ec@gmail.com>
References: <20180726133606.14587-1-stefan@agner.ch>
 <de84d04c902d1f7f22b6f024b853a1c7@agner.ch>
 <cd14bca0a1f1e097265602a1d5f0c0f5@agner.ch>
 <f035a8ba-ffa7-b98b-a444-db8b4bbd34ec@gmail.com>
Message-ID: <d02d9605797d784dc941c9d98769bf5d@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 16:46, Dmitry Osipenko wrote:
> 26.07.2019 17:23, Stefan Agner пишет:
>> Hi Thierry, Hi Dave,
>>
>> On 2018-09-07 01:31, Stefan Agner wrote:
>>> On 26.07.2018 06:36, Stefan Agner wrote:
>>>> If the GPIO subsystem is not ready make sure to return -EPROBE_DEFER
>>>> instead of silently continuing without HPD.
>>>>
>>>> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>
>>> I think this did not get merged yet, any chance to get it in?
>>
>> Any chance to get this in in the next merge window?
> 
> The patch isn't relevant anymore (since v5.3) because the code was
> changed and now propagates the proper error code in a case of error,
> please see [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.3-rc1&id=bbad640709fd43ff77b8838c409c977c0b28430c

Oh I see, I accidentally checked in Linux 5.2. Sorry for the noise and
thanks for the link!

--
Stefan
