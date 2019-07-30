Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD447AC24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfG3PTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 11:19:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42483 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfG3PTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:19:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so62464652lje.9;
        Tue, 30 Jul 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41cV7dKBXD1+Ahztwm+17BUt7uOsIXebGJ7liP6Dr1Q=;
        b=fr7J4bJ48BQhcslss9rejTyZdj4FPrdCEqvatF01xmxmUsIyyYwBzjPDgZx6PtGE+g
         HwYtVBxrTJN5kM1cPkjQIT/6JjCXz4MpWL3Fo3H4uI5sXCKufNCQdoYuL1Ij8H2DfV/7
         NFQzrhBp7GwGUVncuJfMWzEt3dHIrjPOv21vcDhz89QEdO6TOONuGfWGfqyyNOGnBTFK
         uHUWnAlu4k1m5qhmQjRZj0HaUa5nr7tx1EcZFpW2/SruphDDDzA3jzJxsQc6T5svr8J3
         IeLX8hApx/ujA+n0wMFc6deIowlh/HZie+RtHmgrV2y0zQwAYsvbu1TjC6BBiCAGXwmg
         JOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41cV7dKBXD1+Ahztwm+17BUt7uOsIXebGJ7liP6Dr1Q=;
        b=lIeIoRERk1OyNUGCjyPXaAyGRJKiTiPJQ3ylmw2GURqOPkMku3XAy47ua44n45b49t
         iiEPMvZfdkCJNn9rk/EivKVnGm6ZZkXW+7l8zdlHRIH7P2i2n79B/sb+8YyW62QvKMa6
         87CojP9LEwEwtFoE6C82IzWUbKsb8i6LrgFqDsqguopotzfoy8qCgvCGk1IxF1Brk7sQ
         JWZD8RkeHki4KKYkRm44SzsNjwhN4KgGX21pDr/cy8juUyVVfhnNcikn7QwzF4u79uty
         N71+cmaot+eVBEyeboEAQhfdGyR0IzNTwBEOLrlGAZVi5J9tyLyGNqtaqcKETXbVjAJw
         39Wg==
X-Gm-Message-State: APjAAAUxUXP6SeUB2ZpKXAwqRbhnOIH6KHSqVYtufAIRxYes3hAWw052
        v6E1yHsA69+q6dPRKbNjWeOBr8q5p0EH4AsIOoM=
X-Google-Smtp-Source: APXvYqwbkHjJY94CJHMfxOymen4JekQBc6rBpZA6GX9FmhyRgQ8kFvXZ03CUkI7urj04jzey1TKg8zskVaDviN58ToQ=
X-Received: by 2002:a2e:2c07:: with SMTP id s7mr24431008ljs.44.1564499992535;
 Tue, 30 Jul 2019 08:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190730150552.24927-1-lukma@denx.de>
In-Reply-To: <20190730150552.24927-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 12:19:57 -0300
Message-ID: <CAOMZO5AxPHHobQQhq30fjLVeSroLdvdT0+GqCWi8it1ejhDONA@mail.gmail.com>
Subject: Re: [PATCH] ARM: DTS: vybrid: Update qspi node description for VF610
 BK4 board
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Subject line could be improved:

ARM: dts: vf610-bk4: Fix qspi node description

On Tue, Jul 30, 2019 at 12:06 PM Lukasz Majewski <lukma@denx.de> wrote:
>
> Before this change the device tree description of qspi node for
> second memory on BK4 board was wrong (applicable to old, in-house
> tunned fsl-quadspi.c driver).
>
> As a result this memory was not recognized correctly when used
> with the new spi-fsl-qspi.c driver.
>
> From the dt-bindings:
>
> "Required SPI slave node properties:
>   - reg: There are two buses (A and B) with two chip selects each.
> This encodes to which bus and CS the flash is connected:
> <0>: Bus A, CS 0
> <1>: Bus A, CS 1
> <2>: Bus B, CS 0
> <3>: Bus B, CS 1"
>
> According to above with new driver the second SPI-NOR memory shall
> have reg=<2> as it is connected to Bus B, CS 0.

I am glad you got it working!

This looks very familiar with the suggestion I sent yesterday:
http://lists.infradead.org/pipermail/linux-mtd/2019-July/090655.html

It is a good practice to give some credit to someone who has helped in
finding the solution of your problem.

Adding a Suggested-by: Fabio Estevam <festevam@gmail.com> would be nice here.

This also needs a Fixes tag.
