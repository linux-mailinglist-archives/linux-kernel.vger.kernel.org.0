Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6709D1CE51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 19:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfENRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 13:51:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35641 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfENRvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:51:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id n14so9151270otk.2;
        Tue, 14 May 2019 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeIjbYQKQe1rgNNMG4zx8eoPc0eGIBAjjn8fpznrZGo=;
        b=bgZgUlNo3WNdcwpSQgNVohMeqfQGBnkBXDE5vnfOEbUakRgnqM/6uyp9+25kbl0yd4
         cRP51o344MRMmBi+HfIuQjUM/UI8lnEw0g4AJXeb0ZGDkuFqqwUvu5FhXRNja+UbJ4P+
         85eHR4PGQGnof9AIMN8mW4qGZJfELFoYXVY8qpxEQUDy8uSJo5c6AXqqHd0EerDNiCYf
         VHkr0qcQ1A/NbBy3GU8Up2hs9RmYTvVD2chrNX44FPDNBWp19yvofELh+c4FN1XFrXd2
         PsNSHJOJ5ezS/NKeRlluLRbBLNEHnnfAm+MV+TeOm5FDNyUpkKNvUJaahy1ETDHhUJI5
         MRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeIjbYQKQe1rgNNMG4zx8eoPc0eGIBAjjn8fpznrZGo=;
        b=MkDcK7XIgBJaeKYP/p6Y+srYOE3gqRV7XP6X5VpfQg2VpevVP4HXSc3hsR1RzZ1TgD
         nIkD20XQthTnqqEavSD7zcP4hXgZpmgBmQV2Yu4dODYeFYHbAJCH77hzpHDAym5BEOT4
         /whJGrhQiL2Y+PzctTViXBm/f2t0JtgeujZRTqf8eJ54WJmoLNS2kxMGoyChsZzjo0JY
         ayR5vgq5Cg2hnjY3BOfGIyj57wXj/7SxbFdCFo86P9dOno15Io1VBY0n/cEpP7T+r1kk
         gpkn1NrpY/Jq3As4E633yKtsIYSoCMgZkA2gB5dXs6HKwAkfppMgw/bX15bStnCcObiK
         jNYA==
X-Gm-Message-State: APjAAAWtmAxTS3xrnneuzmDQUclbm7VUmjlSJUvovCIBTFWjBKC62u5h
        GJAAZAsOfbSP1qpIBJcQl7tBWH4Y2HyG1w5kTtA=
X-Google-Smtp-Source: APXvYqy+LHfc5aRuY5FakA4b+0V7yv1+nWIt3h3VKxRRI2OrJlfvSL5wBlgz3UhXafyHTlSVj4LTjzRgEbrJdxMFVpo=
X-Received: by 2002:a9d:4586:: with SMTP id x6mr17937986ote.38.1557856281480;
 Tue, 14 May 2019 10:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-4-narmstrong@baylibre.com>
In-Reply-To: <20190513091548.16674-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 19:51:10 +0200
Message-ID: <CAFBinCC5NADRuZkBiD8Zs9efNKp2fhZVqQ8aRnQ1gs+GbQCKdg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12a: add ddr-access-quirk property
 to SDIO controller
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com,
        baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:17 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
> mark this specific controller with the amlogic,ddr-access-quirk property.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
