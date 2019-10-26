Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D1E5F7E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJZU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 16:29:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfJZU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:29:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so5935160wrq.5;
        Sat, 26 Oct 2019 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4wh2U9sFqBwfDf0nZQjTsklg9xDf789GQammhgh2Mgk=;
        b=Ng6Wb1aF1JapsK21o9YGhhN0Gq/K5h8CZdHpp03cEYgiP9phvjBE8cMdi4kymm1P8e
         gu/IHjGcSm0cg07Y4OIR5tGgiZKYeZcTzwBxCXPR/jJk32d+7sMP0EQbFEf2NSVWVEa9
         WoxCfz9nQ7o+DP1RwLbPQEeujjo80bL5xeMlXtGXiANxF+E60spWqbvcDj2Prrygl6OX
         Ejinwfdu9/Uhh7j4iPQv+8EqObyvFDJecwt9Mb8RpJCVpGPwGZJBd2f75uXuVrxar97p
         oll++7fKauBP5UI4WatmoNValG4goyRGDgjarRETIAUAQW//iTCDV8luH/lLFBVrXzKZ
         CSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4wh2U9sFqBwfDf0nZQjTsklg9xDf789GQammhgh2Mgk=;
        b=apXo+P2ISpmCctIPf0zwkoXrLNW6LNoKtp2ARbHe7Bp2enyivWV7uJYaNtMXxoPfnU
         6eAWR1t4T4Vy+LWR+Kuvyk7IjDcw5bhAMCZF6K0Y6tAfCh4EKackXEfm6wyUd4Oa6Cxy
         ESFNYswHJ9t9PsEbS2Skt6ZAF2VKG6bO7+DeWXsQ7XBK65MxbVl0LGQ0UkJxOgRv1Mnz
         5OFOiKqW+UwSq79r+rZmHe1zRMZRCYxGYflz8U+uqp+qM3bGb1+c7QygopBh/0Fexi+G
         zVtZUdwtRDFsTwqV07IE4mbQOOOXW0d2DlvrdxebHrayR4MMgYl1KqCUO5xiTYT5rrY9
         71xw==
X-Gm-Message-State: APjAAAVZEvIigeC9+gCEH6wsUIH6t4iFu9RhODe8VOyx0Pv2RTxxXjLe
        bZRb4FYHwYQHtLJ7pzucG7w=
X-Google-Smtp-Source: APXvYqwsbzOzEv8luTR5JkVcDrsSwIx1FRcxy8PcdF6PXF/pUnvtJ3sO8D6jECnzWTal9dI5ljapLg==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr8907763wrs.146.1572121785248;
        Sat, 26 Oct 2019 13:29:45 -0700 (PDT)
Received: from ?IPv6:2a01:cb19:16b:9900:c490:d472:7a6:b387? ([2a01:cb19:16b:9900:c490:d472:7a6:b387])
        by smtp.gmail.com with ESMTPSA id u7sm6776609wre.59.2019.10.26.13.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 13:29:44 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: imx7d-pico: Add LCD support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20191025082247.3371-1-offougajoris@gmail.com>
 <20191025184544.7gwwbsrketjtwrwi@pengutronix.de>
 <5a73d00e-397a-f4ed-2bfa-bb26324685ba@gmail.com>
 <CAOMZO5CPg=mJSKNuNVFF=zGUaZqMpr9Ocv89msS-120Shc0=RA@mail.gmail.com>
From:   Joris Offouga <offougajoris@gmail.com>
Message-ID: <3a75c40b-c1bc-1461-08e1-f5ac89d73c80@gmail.com>
Date:   Sat, 26 Oct 2019 22:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CPg=mJSKNuNVFF=zGUaZqMpr9Ocv89msS-120Shc0=RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Le 26/10/2019 à 21:20, Fabio Estevam a écrit :
> Hi Joris,
>
> On Fri, Oct 25, 2019 at 6:16 PM Joris Offouga <offougajoris@gmail.com> wrote:
>
>> otherwise Fabio made me notice that I should leave his From however with
>> the changes made I should put mine?
> It is normal when we submit someone else's patch and we need to change
> a few things based on review feedback.
>
> Even so, the original From should be kept.

Thanks for your reply, i send v3 with Marco's feedback

Best regards,

Joris

