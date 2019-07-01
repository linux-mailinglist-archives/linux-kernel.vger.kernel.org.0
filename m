Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C11625C445
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGAUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 16:23:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42811 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGAUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:23:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so14545992lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yeezC43PYS18W/SIzQiodt0jp2d2/Hn/sPPvB7Hkrs=;
        b=fvRVEuWalo7Pr6238+rkM+9g1mlIvP6z++a9qdgrfo11+VJyASL1zgTmiIwKi5iMMT
         YShRpuwPqGemeFZ7Z1VHUgwgWQVG4CtuVQki/LnGJ/ZSHEYN8zuBYrVylZDsn+HKSYbp
         kBYu5NSjWoUZTfta3+Lvc1Cabxww2yqA6eBvfAoNI3iFLNr4murQmwNjSQqHjEiA/6kE
         CMQT6EWcfQhNt2/XgGug8SxMLCVnV8ec3pNaGs0S04+U8TV+oYfv5Dq/+LzzRQVB8zpJ
         CyNinv4oxe6ZcmMyqSVS1+GAOu2jd7E9RJ9EGZQ6IggtKvPw+34fkt0kOCVGw3+OIHRj
         FeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yeezC43PYS18W/SIzQiodt0jp2d2/Hn/sPPvB7Hkrs=;
        b=C6vj2+r7o4m4sRymY7CDwChP5IQbxApX2iZ+aXalgr/7avmuGyNHN0QE3MTE17Soav
         yrmGU582ZtvYghjllVnnvF1NCyfd9RpAetF1YEaKwuiFqMUecnRjrLZS26JAAe7MzUpH
         zyo40OQo5MZ7lxA3IT6JnHtNBdIxV2s965rl9BJrtgjp5cLxtfnokM76mL2mM6CvRYn6
         WVhxJ6C599wlxltN69NaRAwM+VUzz2R+II/HKM4/MghlSw+qru/KVsUltcDkQ+vBDWeJ
         HQMTQuweRKz/SFGv5F7OozGD+5MwL4rvZ0AWKpx4Fg3N2Pk47B3w+SSUV2E0TdsSM1L5
         CiYA==
X-Gm-Message-State: APjAAAUsGD6uv/qkHkYTQB01ZXSBd7+wSyLMsj1N4g4bLEs7YRfBVgHr
        jTZezArUxROrDvNPshL74L8RmqA26TDqM1JR4W0WWQ==
X-Google-Smtp-Source: APXvYqyUxzE1vHY3FGSByUi6GK2txxEik41ysV2f+vH6fGH86OktUnzJ178axhcKMNZYGvJVxtG9YJ2PxCvsjyXPERM=
X-Received: by 2002:a2e:81d8:: with SMTP id s24mr15172028ljg.37.1562012622393;
 Mon, 01 Jul 2019 13:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190701152723.624-1-paweldembicki@gmail.com> <45ff597a-5090-3874-b43d-5b5f45d2d2f6@gmail.com>
In-Reply-To: <45ff597a-5090-3874-b43d-5b5f45d2d2f6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Jul 2019 22:23:30 +0200
Message-ID: <CACRpkdaQhv+4RG8k+QaCE9F3-Oeo8-rjSqGgakr8r2pyOkyoGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: dsa: Change DT bindings for Vitesse VSC73xx switches
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 6:44 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> Take b53 for instance which supports MDIO and SPI by default, and
> optionally memory mapped and SRAB (indirect memory map) accesses, they
> all have the same compatible strings. Whether the switches will appear
> as spi_device, platform_device, or something else is entirely based on
> how the Device Tree is laid out.

That's clever.

Pawel can you restructure the series around this observation?

Yours,
Linus Walleij
