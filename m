Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696C91185D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLJLGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 06:06:44 -0500
Received: from smtp114.ord1c.emailsrvr.com ([108.166.43.114]:37713 "EHLO
        smtp114.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbfLJLGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:06:43 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 06:06:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1575975523;
        bh=s930yeVuZ/OBWf+Xggci74+j0vX0OnxEmUgFeVwwphc=;
        h=Subject:To:From:Date:From;
        b=Oar1jshLInKThEcIkjd+TTC0hkswIxu8mjRLLJkdqqPyb9/9EzmYS98epw011eOuz
         quFMLQdzII3KAY7BFOO9EAPPxfPBxlfXj+GFqv1+vV+y1ZqtEJVbNcmrVLygKsbcsS
         4dydcRmMkOimaloGXfiBr9Zidg1dfW1P1OAMqbTI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1575975523;
        bh=s930yeVuZ/OBWf+Xggci74+j0vX0OnxEmUgFeVwwphc=;
        h=Subject:To:From:Date:From;
        b=Bjj9V8IyStZQSOYzOtC39eOZ+CdyL5otXWSI/4e3msEnu6MaIvFuFWvXfzF7X+RXo
         56qBkMZ0qzOSakrhprRDxpI3R3GPcCgkrMq9gGv0qMBtA5a+c5+MtIYKARIBMxvta8
         SwmCoz79zPBh81//PHyG0J4CkQiww5v/W7kGaRko=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 29CA9400EE;
        Tue, 10 Dec 2019 05:58:41 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 10 Dec 2019 05:58:42 -0500
Subject: Re: [PATCH] staging: comedi: comedi_test: return error when
 comedi_test_init fails
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cheah Kok Cheong <thrust73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191210091451.23505-1-hslester96@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <ca049de4-92f1-409c-6aa7-9c2ddc336638@mev.co.uk>
Date:   Tue, 10 Dec 2019 10:58:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210091451.23505-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 09:14, Chuhong Yuan wrote:
> comedi_test_init() forgets to return error when it fails.
> Modify the return value to fix it.
> 
> Fixes: 9ff7400bd38c ("Staging: comedi: drivers: comedi_test: Add auto-configuration capability")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>   drivers/staging/comedi/drivers/comedi_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
> index ef4c7c8a2b71..133ed99a89f1 100644
> --- a/drivers/staging/comedi/drivers/comedi_test.c
> +++ b/drivers/staging/comedi/drivers/comedi_test.c
> @@ -799,12 +799,14 @@ static int __init comedi_test_init(void)
>   	if (!config_mode) {
>   		ctcls = class_create(THIS_MODULE, CLASS_NAME);
>   		if (IS_ERR(ctcls)) {
> +			ret = PTR_ERR(ctcls);
>   			pr_warn("comedi_test: unable to create class\n");
>   			goto clean3;
>   		}
>   
>   		ctdev = device_create(ctcls, NULL, MKDEV(0, 0), NULL, DEV_NAME);
>   		if (IS_ERR(ctdev)) {
> +			ret = PTR_ERR(ctdev);
>   			pr_warn("comedi_test: unable to create device\n");
>   			goto clean2;
>   		}
> @@ -826,7 +828,7 @@ static int __init comedi_test_init(void)
>   clean3:
>   	ctcls = NULL;
>   
> -	return 0;
> +	return ret;
>   }
>   module_init(comedi_test_init);
>   
> 

I suspect the current behaviour was by design because the module is not 
completely broken if it fails to create the "comedi_test" device.  The 
module will just behave as if the "noauto" module parameter (which sets 
the 'config_mode' variable) was set to "true" if there is an error 
during class or device creation.  That's probably why the kernel log 
messages are written with 'pr_warn()' rather than 'pr_err()'.

As long as the core "comedi" module has been loaded with the 
"comedi_num_legacy_minors" module parameter set to a non-zero value, it 
would still be possible to configure one of the "legacy" comedi devices 
to use the "comedi_test" driver via the COMEDI_DEVCONFIG ioctl.

However, returning an error might be preferable here, especially since 
the comedi core module's "comedi_num_legacy_minors" parameter defaults 
to zero.

I'm happy with the change of behaviour, but would suggest changing the 
'pr_warn()' calls to 'pr_err()' to match this change.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
