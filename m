Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5125C862D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfHHNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 09:16:55 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48864 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbfHHNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:16:55 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F38935C2324;
        Thu,  8 Aug 2019 15:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1565270214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAyN24AzAzO1awwqHODdXPWc78B4O/mVcZTdCznoEes=;
        b=ihji1C0POjshqOnHilzCuIJvCLQiIHTYUZvITc2HhVRGqAwz7VUPA7HyZnNVoj8M0cxJog
        0o304WNpDEQmark5ttYGQwnbMGUwQnc854J8a+oymFH6jw8IuoNb96izgE5X3BZlI++rwL
        nFxk2rEl1AJFBrbrXLmQMig+I+bNdJw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 15:16:53 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz,
        Stefan Agner <stefan.agner@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
In-Reply-To: <s5hftmbiyuc.wl-tiwai@suse.de>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk> <s5hlfw3izhl.wl-tiwai@suse.de>
 <20190808130217.GE3795@sirena.co.uk> <s5hftmbiyuc.wl-tiwai@suse.de>
Message-ID: <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-08 15:14, Takashi Iwai wrote:
> On Thu, 08 Aug 2019 15:02:17 +0200,
> Mark Brown wrote:
>>
>> On Thu, Aug 08, 2019 at 03:00:06PM +0200, Takashi Iwai wrote:
>> > Mark Brown wrote:
>>
>> > > No, they absolutely should tell the user why they are deferring so the
>> > > user has some information to go on when they're trying to figure out why
>> > > their device isn't instantiating.
>>
>> > But it's no real error that *must* be printed on the console, either.
>> > Maybe downgrading the printk level?
>>
>> Yes, downgrading can be OK though it does bloat the code.
> 
> I guess we can use dev_printk() with the conditional level choice.
> 

How about use dev_info always? We get a dev_err message from
soc_init_dai_link in error cases...

		ret = soc_init_dai_link(card, dai_link);
		if (ret && ret != -EPROBE_DEFER) {
			dev_info(card->dev, "ASoC: failed to init link %s: %d\n",
				 dai_link->name, ret);
		}
		if (ret) {
			soc_cleanup_platform(card);
			mutex_unlock(&client_mutex);
			return ret;
		}

--
Stefan
