Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1230A179315
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgCDPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 10:14:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55420 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:14:34 -0500
Received: by mail-wm1-f68.google.com with SMTP id 6so2517724wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ntkN2Bt2eytzYo8LHWkETJyp51uX20eFB3He3wFrMNw=;
        b=ZNJALoFg7NbZIlCreszRaLeqZiUnLe5Flj9+uAcQPt3PU/qA2sI14FPluBDqsdXgI/
         1fCS41eNErjZSFzRZxMeJhMget6pFDN5fOEU5+wD+RfNcrP2bq430ItHZZiyifyZQgW3
         twe3emHg0w9L/OTmr73xd+dGeQTRQaOL6mgy5YZ44MHF5lmqa0qimopn4zrnYGSfjtiF
         Kt0H38kUXf0eNP0snIMzOSgkWWvUuN2AlPcKssLWAU+OeL9TfEr6zQU8fVQNV8lLdhuC
         g1+/G1KOcW7kuW7/qYTbHWrEqg03ocpLCwmC0M+VVslR/xkjNiv41SZ3qUEhqDtWATD1
         +BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ntkN2Bt2eytzYo8LHWkETJyp51uX20eFB3He3wFrMNw=;
        b=AJW3R3sPjeJyDEaVF3VihCIM0kBFgJTxMhmECyqHTgZCso1oXMwBMub3BLkhuwxq54
         FV5NbtzintmiSvAQABGXGia9JyVAKCC1Z0nb4r+rOpskVVdELlJ/0ny/y78dn5UuyPOJ
         c1T0wI8MR8vhqGnkEg/I09NY8oIcbS+gGVenZWyt6clecLEgRdP7JlCCMFvnG6PJMsgS
         pHXmqKWnUPCCbF5RNjaigbF/AtfQV+ketJLm0qse9MIybSLeRi6U2iyikxtSMpBS/oUM
         LQKYjKv2ry8dJd5KjWXwjixXLGxT8e73pEJh9SawrIOqYacsDv9AItVP7VbT057/RWBD
         GrQQ==
X-Gm-Message-State: ANhLgQ19z+SsW+tBWaOMn6kJ6gFd4xhyG5Ises5rkkOx9/l6E41yYoFf
        z8GAUNnNRDV9HwEL/m2gUFkGOw==
X-Google-Smtp-Source: ADFU+vsy9i8tQNn4aoMQESfufuXZTbONKfMbOIzTmzcSncwnWJ+oYo6P0UZaWtHBIQA1UKlaxZJ3tA==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr4024812wmb.81.1583334872783;
        Wed, 04 Mar 2020 07:14:32 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id c11sm39066333wrp.51.2020.03.04.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:14:32 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:15:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: 
Message-ID: <20200304151512.GD3332@dell>
References: <1583249249-17380-1-git-send-email-gene.chen.richtek@gmail.com>
 <6b920875-8764-73a4-a763-788ce485b0cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b920875-8764-73a4-a763-788ce485b0cb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Mar 2020, Matthias Brugger wrote:

> Please resend with appropiate commit message.

Please refrain from top-posting and don't forget to snip.

> On 03/03/2020 16:27, Gene Chen wrote:
> > Add mfd driver for mt6360 pmic chip include

Looks like your formatting is off.

How was this patch sent?

Best practice is to use `git send-email`.

> > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> > 
> > Signed-off-by: Gene Chen <gene_chen@richtek.com
> > ---
> >  drivers/mfd/Kconfig        |  12 ++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/mt6360-core.c  | 425 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++++++
> >  4 files changed, 678 insertions(+)
> >  create mode 100644 drivers/mfd/mt6360-core.c
> >  create mode 100644 include/linux/mfd/mt6360.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
