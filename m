Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C830C99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEaKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 06:31:48 -0400
Received: from smtp65.ord1d.emailsrvr.com ([184.106.54.65]:42102 "EHLO
        smtp65.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbfEaKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:31:47 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 06:31:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1559298357;
        bh=+RyXWqRhvrx46/X9uDvSyUTN7HW9qCylh6KVuj6gMts=;
        h=Subject:To:From:Date:From;
        b=HrTvH2rfJc3JxXza8WwraZ7VbrPncQJsSJinzEHEoln6GccBuDQxq9B4g5kyYoWOW
         JryjYPZvi2RhKOAn/cRTIKCiR7E7gxr5baAfAvuiRyCxKz8Tf8EEfSafxDR5eygFA6
         hTGsVLtCRHOrVbZ3D+gQxJlDHKL6AV5CpB7svr3E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1559298357;
        bh=+RyXWqRhvrx46/X9uDvSyUTN7HW9qCylh6KVuj6gMts=;
        h=Subject:To:From:Date:From;
        b=cvZXbugWw23POqggq5TbKOn/+todCezZby6ZEdzFBsKDmXgNR9jm2aLsDhloYR+Lj
         lRvmKBq1ClFcHCVHfETPN73C/u7VCG8TK+SMzqKlp3kgtLsvG+sqSkp0iIL261YmRT
         WJm5WvH2OQHZEeZyWcwW05BiSM6iBcET1avUYKlI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 158AA4015F;
        Fri, 31 May 2019 06:25:55 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 31 May 2019 06:25:57 -0400
Subject: Re: [PATCH] staging: comedi: Remove variable runflags
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        olsonse@umich.edu, jkhasdev@gmail.com,
        giulio.benetti@micronovasrl.com, nishadkamdar@gmail.com,
        kas.sandesh@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20190530205131.29955-1-nishkadg.linux@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <8292224d-9c4a-d29e-4a86-d3352fcd2be1@mev.co.uk>
Date:   Fri, 31 May 2019 11:25:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530205131.29955-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2019 21:51, Nishka Dasgupta wrote:
> Remove variable runflags and use its value directly. Issue found with
> checkpatch.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index f6d1287c7b83..b84ee9293903 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -676,16 +676,12 @@ EXPORT_SYMBOL_GPL(comedi_is_subdevice_running);
>   
>   static bool __comedi_is_subdevice_running(struct comedi_subdevice *s)
>   {
> -	unsigned int runflags = __comedi_get_subdevice_runflags(s);
> -
> -	return comedi_is_runflags_running(runflags);
> +	return comedi_is_runflags_running(__comedi_get_subdevice_runflags(s));
>   }
>   
>   bool comedi_can_auto_free_spriv(struct comedi_subdevice *s)
>   {
> -	unsigned int runflags = __comedi_get_subdevice_runflags(s);
> -
> -	return runflags & COMEDI_SRF_FREE_SPRIV;
> +	return __comedi_get_subdevice_runflags(s) & COMEDI_SRF_FREE_SPRIV;
>   }
>   
>   /**
> 

I couldn't reproduce this checkpatch issue, even with '--subjective'.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
