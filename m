Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357928A362
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfHLQbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 12:31:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:31:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so118224wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P6gN9L7PuGnp4yN0k3LkBqmw0DeVh9zL9RShIY4qL5Q=;
        b=tUCd79L3vyPF6kYNwJHWhCFBEQXQi7UzjEP/TOB9bMeaGmxfTVC2WCCw91Sm3WgzAm
         +BdRJUjUDlTyCYvdgYaS/FF5iFL3Ndwhc/bRoEW7eaEfL0ywBTTosrTFLgANX6tcgyUZ
         VmIfOKeVKZBHI5Y+acz6z6RD4G5tzrXhO4b+aokjDcotcTTQhsH8zuEHQgFmQyOsGJVS
         yOzanpYfy8JsVnvF4DPMdOMf41XfLFFlMeMROdeHwJhIVK4DGgPvQdljvrwHY5U4Z29A
         IOZ1BtKtPCNoZ9fudGe7rXh7s+Q+18vMhjFwccMIdkIEL7Cd5h8pCxUAaN1db7PR9YIa
         26RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6gN9L7PuGnp4yN0k3LkBqmw0DeVh9zL9RShIY4qL5Q=;
        b=qwW+sCSMRa2h+Je3YX4XeNudAbn13RthWMLuexun7nJbJBEfobk/rsNdLXZJHhcfp0
         JHzcxtSw+uf/1YfIoK89n3tnxj6BsFjBu+0wtS57DEaeuAt49slCgn3mZOBmC3cHj6th
         MP+i4Ep5TQpFC90qSKNvi4PUNenQiwGQsC5NUyqAsLaZcXV3I47nuEFz3oT1Yv7v4E83
         0KHEIKck7VPdG5+Pc+mIXtgENiBFVLVynwyqPppnP0Z5ffqPYAHXU8tiESLUjl99BtQn
         1QXTqSzHkM6VBosEpZVxLMeYvb1cDJ3HfD3iDauNXziNhi1wxR5NPRqsdOTCoOX5eknv
         GWYw==
X-Gm-Message-State: APjAAAVZq4/sFNOjGjXIuW2a4QdGbGpD/dAy85FLSh5PehYeDvlLAu0J
        K0btOvrYc9hx/7kJ2yxyth/IlTobTAw=
X-Google-Smtp-Source: APXvYqz/uDQdEQrKLjDtjBP9P5TOU6/orA5hdQEAzJwywM9OXUWhvYgh5kX71zbwYr4uYk3z+DjilQ==
X-Received: by 2002:a1c:4087:: with SMTP id n129mr144387wma.3.1565627462933;
        Mon, 12 Aug 2019 09:31:02 -0700 (PDT)
Received: from [172.28.172.8] ([31.217.37.102])
        by smtp.gmail.com with ESMTPSA id o20sm264509028wrh.8.2019.08.12.09.31.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:31:02 -0700 (PDT)
Subject: Re: [PATCH] ARM: ep93xx: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190808023811.GA14001@embeddedor>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <996ead9b-457d-ef9c-4838-9438887b4da9@gmail.com>
Date:   Mon, 12 Aug 2019 18:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190808023811.GA14001@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 08/08/2019 04:38, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warnings (Building: arm-ep93xx_defconfig arm):
> 
> arch/arm/mach-ep93xx/crunch.c: In function 'crunch_do':
> arch/arm/mach-ep93xx/crunch.c:46:3: warning: this statement may
> fall through [-Wimplicit-fallthrough=]
>        memset(crunch_state, 0, sizeof(*crunch_state));
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/arm/mach-ep93xx/crunch.c:53:2: note: here
>       case THREAD_NOTIFY_EXIT:
>       ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   arch/arm/mach-ep93xx/crunch.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-ep93xx/crunch.c b/arch/arm/mach-ep93xx/crunch.c
> index 1c9a4be8b503..1c05c5bf7e5c 100644
> --- a/arch/arm/mach-ep93xx/crunch.c
> +++ b/arch/arm/mach-ep93xx/crunch.c
> @@ -49,6 +49,7 @@ static int crunch_do(struct notifier_block *self, unsigned long cmd, void *t)
>   		 * FALLTHROUGH: Ensure we don't try to overwrite our newly
>   		 * initialised state information on the first fault.
>   		 */
> +		/* Fall through */
>   
>   	case THREAD_NOTIFY_EXIT:
>   		crunch_task_release(thread);
> 
