Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03532FFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfE3QI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 12:08:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3QI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:08:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so2751667plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCzOFuBrRzsjGJT6QYZDplwoC8znNP+oEnCTc9pJCd8=;
        b=cVdkU0UsiubYEXpbBQbS7cvSuFjQe08Adw6e346iSTE5OsA/QADaLcgAVFLBakmg6z
         2Q2O38L63Bn80R60xkrnN8k4evgFKp+1SBFNsoKvL2F2vTQOA/WqzUnFi3fuWiBpjCnh
         bf2mpR9Tm+9Kh9qyWRGBinlrH9NFfRCKnnjE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCzOFuBrRzsjGJT6QYZDplwoC8znNP+oEnCTc9pJCd8=;
        b=oh7h/DNpopf5iBqkkIyYb9eHll7x+nUAqxzOKO9kvz3AkUVZwS3uElPKyNFdjI0HD9
         UgAkRtMD4q5+7JVHyspORyEUwIDmRfZDDbaJ76hFaEq2G7rAWb+eV1P7z5RtLFqITFbx
         gEJCnpFBpno3RsSFmU/psBOuhcQmqUXndUGf/Ab4s1rOGCJkXLM3lveegP1M8KLGcvSb
         rxM/82MM5nc6ZaYOqkVia6ZFargMStISXiqdgF5SstxXt6uKyuZ+vkToKj7/KNxf93Mt
         WRL0IH+m1JvrtaTmrAIDVvIhHSWDM7s2d0LhIZO0tqWfl66QMjWJIWRX6t78QQJsDQ76
         HxAg==
X-Gm-Message-State: APjAAAU9vgSKpaJl9ybo+YHO2eejzuoQAMI8LVP6HP3P+/RmHZI2Rho3
        4mO4x5lpHNDC6Adc3Ky3h06jNg==
X-Google-Smtp-Source: APXvYqwTufU4ReY8GoGuWrjOS8pyLhEFpYHGf/dPgPB2mg1+d5otdc1js0QS6kCxqXlGXEcw9FpdAA==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr4416976plk.149.1559232506416;
        Thu, 30 May 2019 09:08:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a69sm4045967pfa.81.2019.05.30.09.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 09:08:25 -0700 (PDT)
Date:   Thu, 30 May 2019 09:08:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "michael.kao" <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/8] arm64: dts: mt8183: add thermal zone node
Message-ID: <20190530160825.GM40515@google.com>
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
 <1557494826-6044-2-git-send-email-michael.kao@mediatek.com>
 <CAJMQK-giJTeERnqjxoSMjF-JXxW9SPmeARWf3f9ZyRgBsYN5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJMQK-giJTeERnqjxoSMjF-JXxW9SPmeARWf3f9ZyRgBsYN5fg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:27:28PM +0800, Hsin-Yi Wang wrote:
> On Fri, May 10, 2019 at 9:27 PM michael.kao <michael.kao@mediatek.com> wrote:
> 
> > +
> > +                       tzts1: tzts1 {
> > +                               polling-delay-passive = <0>;
> > +                               polling-delay = <0>;
> > +                               thermal-sensors = <&thermal 1>;
> > +                               sustainable-power = <0>;
> > +                               trips {};
> > +                               cooling-maps {};
> > +                       };
> > +
> Is 0 a valid initial sustainable-power setting? Since we'll still get
> warning[1] about this, though it might not be harmful.
> 
> If 0 is a valid setting, maybe we should consider showing the warning
> of not setting this property in [2]?
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/power_allocator.c#L570
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/thermal/of-thermal.c#L1049

IIUC a value of 0 is pointless, the thermal framework will still use
an estimated value:

https://elixir.bootlin.com/linux/v5.1.5/source/drivers/thermal/power_allocator.c#L203

As commented on v1 (https://patchwork.kernel.org/patch/10926519/#22620905)
the value of the property may depend on the thermal characteristics of
the device, there is not one correct value per SoC/core. If it is
specified at SoC level device makers should be aware that they might
have to override it for 'optimal' behavior on their device.
