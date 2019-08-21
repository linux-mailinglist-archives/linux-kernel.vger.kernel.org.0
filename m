Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CC98665
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 23:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfHUVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 17:15:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43002 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfHUVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:15:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id o6so2725849oic.9;
        Wed, 21 Aug 2019 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f11r5rDIrPHkeH+HjkUpHOS2su3knSlDIuohz37NErM=;
        b=b6p5/u/3tSHVdNTddkdJYeuyTycpn608S/Ffw98gMhYlEzN/fNlicwctGXe7dTarhI
         fhITIj0x8uY+xBequHvjilYoNHB7bIv8PpZ41t/jpuR219c0uoHLvEFnIlfTTB/PZi+w
         5xZ2XPDYoyFeLNvZRGi4+4vmaaudb+p+iZSvQfumNNG0+Q7CZbvBLb5F6JJVph51jmFQ
         /sAwC36dvjGgAl95/cBVtd4K3cYcU2fIN71oAyusPjTPA3yZZW0xVcZ1uWfKlUCMDlE+
         xjgrq+Z0NdrhEMhpSsTBVQBilY5FHB6zmcLZZWe8m0zJV0cASv9ZbtCdkB7M4cTwoSSE
         xojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f11r5rDIrPHkeH+HjkUpHOS2su3knSlDIuohz37NErM=;
        b=RewMOb6Jx8QuxZZrvS0y+qtkTtnxERB7pVd7SnMAKLVYevF+Kh83Fjvr5HIV3kn8Y1
         jDivG/5bCR4b4vf5hFXhtU70tDv8bdymdeiEZd+BMB/sy6SWeBRpnvnlzG6LhVEplkJ4
         rmhSdODL+0Otz7eh/MJ5PzPsOPBLbpuKhVsoEzd6QnqpKOC3JwKCwpMxrSDqpYqnsqLJ
         F2h9LtL2Ox09GqdVhQtbGQ2psDcYNjNTXU9DKsAF8u90XNtST/E686UFcG6mi3NUmkcZ
         sorL5/npKTrQmGqMAw95PIIEJy6kEQAm3ekAUfkGYL1TYW3E+0MzUJOagC9zfecHP5ka
         XB2A==
X-Gm-Message-State: APjAAAWVArG1ivyPEpMfOGNc/4gmaGGhnENj7uKh2F9edtMK82lM+Jtt
        vr7FklMno/5XBxo0AEA9Hn1Zwpr81Bvd/g3FuIM=
X-Google-Smtp-Source: APXvYqzWYLbDJgY7jblPNDvJdCDNspP35RWDkTdkhOJypCJj8+By07BAkOd+Pc2Ew6gsVJok0cawdVBqY3xnEvZFnyI=
X-Received: by 2002:aca:d650:: with SMTP id n77mr1514987oig.129.1566422111539;
 Wed, 21 Aug 2019 14:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190821142043.14649-1-narmstrong@baylibre.com> <20190821142043.14649-13-narmstrong@baylibre.com>
In-Reply-To: <20190821142043.14649-13-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 21 Aug 2019 23:15:00 +0200
Message-ID: <CAFBinCAb+mxh_FPa4P8pe4gGEACJD8qH+jJMb7b9pd8nAt5hqw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] arm64: dts: meson-gxbb-nanopi-k2: add missing model
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 4:24 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxbb-nanopi-k2.dt.yaml: /: 'model' is a required property
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
