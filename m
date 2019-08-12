Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195378A6AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfHLS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 14:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfHLS6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:58:02 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E41220684;
        Mon, 12 Aug 2019 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565636282;
        bh=/KjUbN4S4cg6Wx088EupOk/aYRMhP1qDGEYMVvueRVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D9qYsj5LWfjHJ6CObn5s8xYmjgy/0hM3xZQLPkyi+bEQMpTUOB11WHBj+7uTsOGWK
         +XFIipl/LQjiE/0WJwZ09DwMmBmLh1K8rBHS8DYmzSFSKtJggAcXh6Du24YE6yfpba
         yQm9lmLzh1eWiOh1Gx4T+IxnWgs47wpfsdd1TAkk=
Received: by mail-qt1-f171.google.com with SMTP id z4so103982861qtc.3;
        Mon, 12 Aug 2019 11:58:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVvqbDA338+3yAayRqWgjznNJTimrXWZrslDnQFjwURyqWg++Uv
        iNn4gcXm/q9ts9N2uIiGWVYoYgMKdF4bIkKFzw==
X-Google-Smtp-Source: APXvYqyRqIRy/JRTGiKAgusS3nr3ls85FyjwyvVTVo4EiRNmt609rPVypfT2vXE1taQf0kjr/XZde/uV4mb154zysxo=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr3150956qtc.110.1565636281433;
 Mon, 12 Aug 2019 11:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190809093158.7969-1-lkundrak@v3.sk> <20190809093158.7969-2-lkundrak@v3.sk>
In-Reply-To: <20190809093158.7969-2-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 12:57:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyQjRNONDQT=RM0kYzztd4PdsSZssjiVfd8WUwCjFUVA@mail.gmail.com>
Message-ID: <CAL_JsqLyQjRNONDQT=RM0kYzztd4PdsSZssjiVfd8WUwCjFUVA@mail.gmail.com>
Subject: Re: [PATCH 01/19] dt-bindings: arm: cpu: Add Marvell MMP3 SMP enable method
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 3:32 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Add the enable method for the second PJ4B core of the Marvell MMP3 SoC.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
