Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F05004254E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407108AbfFLMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:15:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43737 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfFLMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:15:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so11894739lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 05:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFYjM9wk0Lz17ea9speLpvagwR++tad6Xn0EKWjFYrA=;
        b=iz8jnCndeBkvP3p4bBUYrvrE0G6l+fnUrY4oU5MyfPxGojrx49R4TMU+njNn/7WkR1
         KudRDNq6DwntOfaunGUQ2Ggo7LykQcAuySfJlCxT5juyhc3dBfB+pQf/5I311Unb61Ak
         xDOd9SDmEBkAmthWSazEjw2aPFlUj9sFiYGMQb7c8R64IJKhJyDC763gJmHYUQHB2JEY
         ObuDuPWxggur9qaAQOWrQNqbA61Jj83r369UjaHpdkGB+xj6tC2Oo2lQDj2219vXZZjC
         WYTaixMFeNHwjcNo5OjrrHcq5pLGSx47JLd9HuGnPjcAo+4RnkSXgfEjH6OYMEiNgoEx
         ztdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFYjM9wk0Lz17ea9speLpvagwR++tad6Xn0EKWjFYrA=;
        b=PmRguZPRCJgjunEvY4DA3t6DW8+lm4KnDTQ+FOJUJdnjGAoCH2mM2jxSS5tRdWLrFm
         oznlxKFkuRVmC/L2WeeqVT53kwaHPD3/ujr8p7m2CAmapzXeJZEFp1Of6PYn7jG7C7g1
         3AWVItIxxA/IN/BVds2OqcqYGTKj6gbcAUg2FjhcLrXf6bzhuxndC1mtQttTAujo/bEK
         xahvHPGrSHbFczbdO2+YDtNOkWzhKyrVDXe8K8BW0CkctXl1Z/F9aql22wKpfyStuayV
         ZgPcBFsEr9oqoqla8Enb+Yu46S1L8hrHhKoawhwBixcSRaOcQjLN/OipQc5nqsGGz2rM
         LvrA==
X-Gm-Message-State: APjAAAXZ9jfBynYEKzGdbTx+z8KaM/GEzhmSpJvTyFMsOwA3Sqk1nYa2
        PYxRAeYr4jxxKCbUWAIKyVww77lSsIG/HQIg6gyIeA==
X-Google-Smtp-Source: APXvYqwy0mZMiBNpW/oi3ASfqSMigvHqJvRnpIQvSh4m+n3Y5mdNL+QhoJDfGK8Ag45DTi2N8BZsC58UGSuJHBOr+eI=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr27964836lfm.61.1560341701722;
 Wed, 12 Jun 2019 05:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190611140940.14357-1-icenowy@aosc.io>
In-Reply-To: <20190611140940.14357-1-icenowy@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 14:14:50 +0200
Message-ID: <CACRpkdbSo=oKh94GxmLX_FrhCuoZJyY27WeV8KJjBW6gTUrh=g@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Support for Allwinner V3/S3L and Sochip S3
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:10 PM Icenowy Zheng <icenowy@aosc.io> wrote:

>   dt-bindings: pinctrl: add missing compatible string for V3s
>   dt-bindings: pinctrl: add compatible string for Allwinner V3 pinctrl

I applied these two so we get down the depth of the patch stack.

Waiting for a v3 on the pinctrl patch.

Yours,
Linus Walleij
