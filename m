Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309F513BA82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAOHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 02:54:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34980 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAOHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:54:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so14718116wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 23:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=15L7jlFqNO2Bso518qKUnevC0GsYD/ESd/nGLMhwY18=;
        b=YvUkGk7+bHFbBiHvppN2kI5YCnCNxnXe3u7oi6v/yBKhT0qQ/TUefkDTiAscRl6mJU
         9+PNZhlEvHQKdI9U3T9G+drI9Bu1AAsx4FOTyEjfy3XUi9Bn4Zl1qnfj/g6L8y2/2sMQ
         NtWrWvvsc6KubXhZu5tA4a15M9I3G6heuTACJ///AKb339G4xRF1OUQDwuls0BNHj6Dd
         L+Ao+9F6DyIGDmlExl1k6P91ReYIN3xWIVpMaL/vUlNo5n0UkHMmtI+SU+9i6s4wQefw
         cAa2en57TyecoCFj7V2uTmp3Sdl6biCxiHChJnF7z9QB2zNP10RiP0Dz/4UHcPuNjkvP
         /aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=15L7jlFqNO2Bso518qKUnevC0GsYD/ESd/nGLMhwY18=;
        b=rC2X/qs8vKXClOICei2RmyJZbMEHbIExEQwlBYpiKMJIVNR+r2OGNrKB5PttkG7Pvw
         LqQw19PwhYlwjcdlBxynl0HLJrdHUkdjkMIVvRQzZAXEu1IgfxsDj6W97x/HNx3Ao2aY
         YNZ9U1yZ3saDxvJyaoLZeUxdZTqoKun5EDIwwdJgqAulE3A/XnuOgl30HIj6QMWZBbIJ
         c/Ew2DOI35Kn/fRb0wp6X5xuXFcSTLJLHu2Fy2kB4lzs6i118pCFKUpoheS7qLbkl+VZ
         BitF8rccaVT/w318OUaVvtxvColRU3khug9ciuKXlxmd9dT/dPByD+rIIsze64RDeDg5
         eqPQ==
X-Gm-Message-State: APjAAAXXzYy/hRpkJVvHXl/YaLNF8uJicU4lqpZXyEHDIqdUd2PE3Pr1
        /gmbY+YVP7YDAAPrVv/L9vtLMQ==
X-Google-Smtp-Source: APXvYqyGZdgYfY2VItz4h8XSNP932dhDZZ7eluAWOElft/WQQOcEsxckB+CTyI0jPiwls4B9Ze0uDw==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr28623351wrs.363.1579074892536;
        Tue, 14 Jan 2020 23:54:52 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id o4sm22723616wrx.25.2020.01.14.23.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 23:54:51 -0800 (PST)
Date:   Wed, 15 Jan 2020 07:55:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v7] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200115075511.GB325@dell>
References: <20200107153314.21486-1-gene.chen.richtek@gmail.com>
 <CAE+NS34ULhk=CLo+e6gAO3SF9NW1cTAZcpMvX1yLfChNCJTpRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS34ULhk=CLo+e6gAO3SF9NW1cTAZcpMvX1yLfChNCJTpRA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Gene Chen wrote:

> Hi Lee/Matthias,
> 
>     Could you please help to review new fix change, thanks

a) If you think a submission has been accidentally dropped, you should
   resubmit it as a "RESEND".  Please do not send contentless pings.

b) It looks like you have complains from the 'build test robot'.  You
   need to address them first, before review.  Or at least justify
   them.

> Gene Chen <gene.chen.richtek@gmail.com> 於 2020年1月7日 週二 下午11:33寫道：
> >
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > Add mfd driver for mt6360 pmic chip include
> > Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> >
> > Signed-off-by: Gene Chen <gene_chen@richtek.com
> > ---
> >  drivers/mfd/Kconfig        |  12 ++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/mt6360-core.c  | 424 +++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++
> >  4 files changed, 677 insertions(+)
> >  create mode 100644 drivers/mfd/mt6360-core.c
> >  create mode 100644 include/linux/mfd/mt6360.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
