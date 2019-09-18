Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FEB60E9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfIRJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 05:59:35 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48367 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfIRJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:59:34 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1A7AE240013;
        Wed, 18 Sep 2019 09:59:26 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Remove wrong spinlock usage
In-Reply-To: <20190918094800.GJ21254@piout.net>
References: <20190918094114.15867-1-gregory.clement@bootlin.com> <20190918094800.GJ21254@piout.net>
Date:   Wed, 18 Sep 2019 11:59:25 +0200
Message-ID: <87impq7wn6.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> On 18/09/2019 11:41:14+0200, Gregory CLEMENT wrote:
>> A potential bug was reported in the email "[BUG] atmel_ssc_dai: a
>> possible sleep-in-atomic bug in atmel_ssc_shutdown"[1]
>> 
>> Indeed in the function atmel_ssc_shutdown() free_irq() was called in a
>> critical section protected by spinlock.
>> 
>> However this spinlock is only used in atmel_ssc_shutdown() and
>> atmel_ssc_startup() functions. After further analysis, it occurred that
>> the call to these function are already protected by mutex used on the
>> calling functions.
>> 
>> Then we can remove the spinlock which will fix this bug as a side
>> effect. Thanks to this patch the following message disappears:
>> 
>> "BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:909"
>> 
>> [1]: https://www.spinics.net/lists/alsa-devel/msg71286.html
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  sound/soc/atmel/atmel_ssc_dai.c | 7 -------
>>  1 file changed, 7 deletions(-)
>> 
>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
>> index 6f89483ac88c..365957e86419 100644
>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>> @@ -116,19 +116,16 @@ static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
>>  static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
>>  	{
>>  	.name		= "ssc0",
>> -	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
>
> This member is now unused and can be removed from the struct.
>
> Once fixed, Reviewed-by: Alexandre Belloni
> <alexandre.belloni@bootlin.com>

Indeed I wanted to do this but finally forgot.
I am sending a v2.

Thanks,

Gregory

>
>>  	.dir_mask	= SSC_DIR_MASK_UNUSED,
>>  	.initialized	= 0,
>>  	},
>>  	{
>>  	.name		= "ssc1",
>> -	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
>>  	.dir_mask	= SSC_DIR_MASK_UNUSED,
>>  	.initialized	= 0,
>>  	},
>>  	{
>>  	.name		= "ssc2",
>> -	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
>>  	.dir_mask	= SSC_DIR_MASK_UNUSED,
>>  	.initialized	= 0,
>>  	},
>> @@ -317,13 +314,11 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>  
>>  	snd_soc_dai_set_dma_data(dai, substream, dma_params);
>>  
>> -	spin_lock_irq(&ssc_p->lock);
>>  	if (ssc_p->dir_mask & dir_mask) {
>>  		spin_unlock_irq(&ssc_p->lock);
>>  		return -EBUSY;
>>  	}
>>  	ssc_p->dir_mask |= dir_mask;
>> -	spin_unlock_irq(&ssc_p->lock);
>>  
>>  	return 0;
>>  }
>> @@ -355,7 +350,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>>  
>>  	dir_mask = 1 << dir;
>>  
>> -	spin_lock_irq(&ssc_p->lock);
>>  	ssc_p->dir_mask &= ~dir_mask;
>>  	if (!ssc_p->dir_mask) {
>>  		if (ssc_p->initialized) {
>> @@ -369,7 +363,6 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>>  		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
>>  		ssc_p->forced_divider = 0;
>>  	}
>> -	spin_unlock_irq(&ssc_p->lock);
>>  
>>  	/* Shutdown the SSC clock. */
>>  	pr_debug("atmel_ssc_dai: Stopping clock\n");
>> -- 
>> 2.23.0
>> 
>
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
