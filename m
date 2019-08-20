Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8996B96A90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 22:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfHTUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 16:30:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41122 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbfHTUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:30:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so6302785ota.8;
        Tue, 20 Aug 2019 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrGQupHWTyriQoaaHMHBYejqwnStP0bo0yYGdWFV+8Y=;
        b=edBJe8t3FW/Ho/MATx/w0v1bez6U7GmZnIcPcVp9+mW+Tzq86GVrTaSENPffngf6jb
         9HDiD6txhBfdHAwt9VN0/XwirDey+5QP5tCWAo0j22c8TCaK8ttiyoDOVwlfjqt3M6wC
         LidmZUfjey5NtpxfZMBvlYjPH1tg+pxIMZLqXYJN3oqfPNi+Br5wpSgSlFJku/EJRDyF
         Wm+T2nacUB3igFUJUGJofvMR9uRHxPDFIdJrruUoNx8Ot71WCS0egiKRP/AwV1J9tDUJ
         QJejL3RBsONA5pWHr72npq2v7Al90GangRz5kCzdwW5hW7auR8JgA9j8G/2CtdYn3coQ
         2ncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrGQupHWTyriQoaaHMHBYejqwnStP0bo0yYGdWFV+8Y=;
        b=sCAq3HBcTZ1AWUUALuop4OqMbErHb4qYkUdaGkROIF5gl+o9DuPwodwMz5Scwq14im
         nSkGcODCfeI/QcsiJXcEcgqOC3YFbOVa+1+1G7ffhPi/4G7j+Hs0Bp+bni4qvTiIdsjQ
         ev2t03EEKdZnGrbeyA6JPgU70djmm6ftljE8eeOJN1EUaAhC/dZ96NlLG6DLmkixJnFa
         m50Ftxs1qjSMFU8+CasoNrSw9RhvBdVJ56Souapccsgo+qHgQ4imKY+xwlx0/RnhbFk+
         WkrpbZnOn63GF93U8J0lqpBcMig07AbKtb1bR8wk1aYd7s8yS2huFL1hqgLVEJsbyqTk
         7VTw==
X-Gm-Message-State: APjAAAWVHvxUM40xnPOWAfn5To39dD/vWnIp6BXI9ToTrHLMC3/yh98W
        Kqp4WApmp+BxRjHBzRGu+XwhSyRbsvxA2LxNOeQ=
X-Google-Smtp-Source: APXvYqy1Lo7z783U1wJS86qYzKMOflQXpO+kzDeScKysRwtKbWufBka5KHmUWv08D7nxtFGp2IQwNA1COCLc+oBL5gY=
X-Received: by 2002:a9d:604a:: with SMTP id v10mr23610019otj.274.1566333002946;
 Tue, 20 Aug 2019 13:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-5-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:29:51 +0200
Message-ID: <CAFBinCA73WmyzmwY8uooMFdRCP4iGGZjaHjTU4q_6oNnZrkWqQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] arm64: dts: meson-gx: fix spifc compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:31 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxl-s805x-libretech-ac.dt.yaml: spi@8c80: compatible:0: 'amlogic,meson-gx-spifc' is not one of ['amlogic,meson6-spifc', 'amlogic,meson-gxbb-spifc']
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
