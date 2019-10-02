Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605A4C4A30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfJBJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 05:04:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37795 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJBJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:04:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so6088528wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=NUl5H/X55FwqiGWpQnEfkahJrpZC2qJ4sf7YHZbx+Mo=;
        b=nGMwtOVq6c+feMh+KqdhlBh7+TRijtwX5wnIuxZmPu8W540zZ1Nu8EGAU0zrua3PbJ
         uN5mrg0k9pe+ELk0VqDhYVlgKP+ftu2SC3CkuZJgqKmeswDdzIpbz5yZYBwcgEvuwoUP
         TJoAyKXu6IVDGKAM3Ae5ENk9zZRqM/culu8SSruFe+JvgJmwuJmilpxk/bpxABGzF+5Z
         WmOkRac2WtJwWKiAhV/qo74PCxN5yj1Bg4SP1cl1RACQpYkfu6HDPGoBLx+MZNWfLZoh
         1zhU5jlyLsS+xVJMg8K2RthVgC/QfavM1mv5cPB2XmoDzjtPtGLKWOuxACh8syRH/0nZ
         v2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=NUl5H/X55FwqiGWpQnEfkahJrpZC2qJ4sf7YHZbx+Mo=;
        b=Kjd/P9MeOLECSKuWCRksaWI9C45bycLw6GO4oFNCn8eNAMtWWVbRfx0a+68lrtVH9Y
         OgDl3KlfPkopnHG5VkrEDG/bscf3enN7t5Cd9u0klhPIrYM+YFGpLCRe/lU1JsvJozip
         oCH8Hf5W09kFrVuVMefJx2T5nezMai8B5S6dmMBISdnd4Wmd17aeUzefBNWITB5eCPaH
         1DjA+bp67z7CWKZ2K2Ue6p8TGJu54JF+1cv1mG5C9DWp9HZLSjVRvZvNesor16tgrLrI
         BeS/hkzq67OyK1qe+cQ5J7qjO83kaHifJmChfztkh+cmC1LsmfGppOp4EU/jKd/rrasv
         4VZQ==
X-Gm-Message-State: APjAAAU55C8v/j5dpg2vdWdYY39l1GuB4vOXQC8zQ/jTfnIn0ur/sSxd
        6f3+C72wApTCmvvJ3J+fELgUZg==
X-Google-Smtp-Source: APXvYqxt+M7/70wLUwWopsHlywqqp7CNL3Dj65++dXEA9VyT5aKdfM9l9wqePVfd0PRNaGcjORzcnw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr2017915wmh.19.1570007084692;
        Wed, 02 Oct 2019 02:04:44 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f186sm5961453wmg.21.2019.10.02.02.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:04:43 -0700 (PDT)
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com> <20190921151835.770263-3-martin.blumenstingl@googlemail.com> <1jftkcr3uy.fsf@starbuckisacylon.baylibre.com> <CAFBinCCED4YWYkdtrfrC80C8WLE=fyMJdjTa3wFNMJgC1OsoOA@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: meson: add a driver for the Meson8/8b/8m2 DDR clock controller
In-reply-to: <CAFBinCCED4YWYkdtrfrC80C8WLE=fyMJdjTa3wFNMJgC1OsoOA@mail.gmail.com>
Date:   Wed, 02 Oct 2019 11:04:42 +0200
Message-ID: <1jbluzr00l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 01 Oct 2019 at 20:53, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

>
> [...]
>> > +static struct clk_hw_onecell_data meson8_ddr_clk_hw_onecell_data = {
>> > +     .hws = {
>> > +             [DDR_CLKID_DDR_PLL_DCO]         = &meson8_ddr_pll_dco.hw,
>> > +             [DDR_CLKID_DDR_PLL]             = &meson8_ddr_pll.hw,
>>
>> I wonder if onecell is not overkill for this driver. We won't expose the
>> DCO, so only the post divider remains
>>
>> Do you expect this provider to have more than one leaf clock ?
>> If not, maybe you could use of_clk_hw_simple_get() instead ?
> there's some more clock bits in DDR_CLK_CNTL - the public A311D
> datasheet has a description for these bits but I'm not sure they do
> the same on Meson8/Meson8b/Meson8m2
> all I know is that some magic bytes are written to DDR_CLK_CNTL in the
> old u-boot code
>
> that's why I don't want to make any assumptions and play safe here (by
> using a onecell clock provider)

Understood. Let's keep onecell then.
