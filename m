Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107341CF02
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfENSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 14:24:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36863 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:24:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so16170462otr.3;
        Tue, 14 May 2019 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6J8S1G1oUeNsO21G9dTvWZ7yrw8d+Sc+qmFLWzLEdI=;
        b=CYe+ksV2i4t0hrZM9i6qO8u4EWzJCoKreEJL7J8csh5q6BamJBq+VMmseJIOXVnafx
         awnucyvIDNJSIYz8kjI8AX1lZ3DXxj9ZF+qIGbm9gbeJrbQelanLhOeBH/4trStfvllg
         NdePzcLUgIx2HT85cSyRdi4r66Tw+xHUwYJzIX3mDZnvNg8KK/M10q9FmpvleijpZU37
         mm0ddsIRWqe3ueyJp15ZjulQfHhhI0U+nFJ+3exYfWjny7OMTy0gP+xqDQUj1YQXw7zD
         kcCz6A+xwXB+Z3wQehi9s19GvV4cPQIcyiSKEAt81DiOCh9fAg0El8h3mg/rEVYyXKr+
         bqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6J8S1G1oUeNsO21G9dTvWZ7yrw8d+Sc+qmFLWzLEdI=;
        b=aMwPrxIMF7MCcJqavXzLNZo7KwYOke2nWkE/2shV1WtdUio5ezd/8hhcQIccBXajiK
         l7Cb2QxP6AD8CfGSr3XRgcZcRNum+X5c2sEUbk/q+Aq8kGr+H2MRVSn2XsXXzWaAOnuQ
         oN9Mfl8DCoIM0CH+p1NnmydO0iB5kF2ZROeGHK+W+ptlyE4jVC9sXPvE17hI0BXFuc6g
         AoIXvJlN4FclJ+BKPrZ0TMEIU9j7qPzDKPNxeF43gNMIhSquH9tnyqwUiF0vex/VF1AW
         zRWImLjWZRYs6X6yq4OBgx8PrJ9eExrJtWWIEspLOhstcpa4t9JxMxGYCDIyh8IGumgv
         dbQg==
X-Gm-Message-State: APjAAAUkrjoqn6AQbKRr8+yrqPvmB0QZsyiUR0fzghys28di3UMynbCq
        i9qTxgkv7lZiYnvGY6xiDoJNyocJw1CYo8Tft+Y=
X-Google-Smtp-Source: APXvYqzmxaC0RQ97CjQ+lyytbY9vc2WIYQ1LcGILX0ZudiL4HpDZrSs1tUWgtk+2LYMebilQ5zrWQdpQFiHpciVbaCQ=
X-Received: by 2002:a9d:4586:: with SMTP id x6mr18052074ote.38.1557858279484;
 Tue, 14 May 2019 11:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190514091611.15278-1-jbrunet@baylibre.com> <20190514091611.15278-4-jbrunet@baylibre.com>
In-Reply-To: <20190514091611.15278-4-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:24:28 +0200
Message-ID: <CAFBinCD8BLQ-5pLs2-gbX87kxkWgTibtM2TZWKu88uRg2euzkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson: sei510: add sd and emmc
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:16 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Enable eMMC and SDCard on the g12a sei510 board
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I compared the GPIOs with the Odroid-N2 schematics because I'm
assuming that they will be the same on all G12A/G12B boards:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
