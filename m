Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F489125CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 09:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 03:34:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45536 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfLSIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:34:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so3683801lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=taX3HoxwkEVB7pXAcY+Ri+PyRxj8E80icnv90TNS3CU=;
        b=naz3+STHjMphw1sGKzwtcsWblBGGkqnZUFM8Fo/D2ib3OFqybDV54Fgm6dF/A4RZ61
         ZSAyiPStc2psl1X2tDaUJTBJFlxpb1MK3/OSvbpn19aqs+IQvraV4OLed+S70nCk/KYJ
         c4r8b2UMw6p7TIIY0fnrjUzLX2LFt2boGQ9w+iySYhO4uxhXl2V6Ui0IqhiHofuMT+Il
         v8Ul4LgIgycMb0tfiO0pJ5+dlByvuaLlP51UR0vGbMKPybivEqX7gnjCpHHMqqACaGmy
         +xfxTXwSJTDtbXww2rAzwB2OelFHVXoLESuI8ALflrVgOsOEQPRq3htvpgCRPlYEGeIi
         2kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=taX3HoxwkEVB7pXAcY+Ri+PyRxj8E80icnv90TNS3CU=;
        b=Zn4TNWpvX2gdlPLqJ28A7BbE7acyN2pCJWFzaG7SeiLFcvJc51rbH7zHl3o51AzRwy
         IRxEobMgKDz7D72CSUVekG539UIX6lV544VdvS4KkwUCXsB/UKq/OUcFmGzOqy1kGHSW
         bf/Q0T4OT0QOWm8xyLw3JPeQA5kg7f4W6GPY7mvzWsDO8/8o/6rh6qON/dBOOG6wj8Io
         MyA0MmmfmCLdsj32JUk0vATOyGfiCKax9pAMb5Aff7vlLCthE/INvK3uwebxH4oln51S
         9NpSQgJDS2G3dKf2u+K2azbx8cXTM2QhD13g6KtGiNnHUgV+A+G/T77yyybTNE+Dj/RI
         +U6Q==
X-Gm-Message-State: APjAAAXQkaVBVEhidMGJJvofoZ3YKOzSRh4Bhbk4idpZW+zTzNvD3t2L
        yNH4XB9XNoJPQ5MtP1zOzSPGF2JL8iWR/zIiIbwB8w==
X-Google-Smtp-Source: APXvYqyd9rjB5aj6i4ChpgDIEs1Yag+wZMWm8rCkrgw+wMRtis/I8Z20t1/Brk6ZFBE7LxJh4nTT76LiCUWT4HSvGW0=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr4545920lfp.133.1576744444532;
 Thu, 19 Dec 2019 00:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20191219041039.23396-1-dan@dlrobertson.com> <20191219041039.23396-3-dan@dlrobertson.com>
In-Reply-To: <20191219041039.23396-3-dan@dlrobertson.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 09:33:52 +0100
Message-ID: <CACRpkdaO3ZYHXBn=Lsg9s=fxBzxH06LYKCnavN=TxFtCZYfT4w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] iio: (bma400) add driver for the BMA400
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:27 AM Dan Robertson <dan@dlrobertson.com> wrote:

> Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
> The driver supports reading from the acceleration and temperature
> registers. The driver also supports reading and configuring the output data
> rate, oversampling ratio, and scale.
>
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
