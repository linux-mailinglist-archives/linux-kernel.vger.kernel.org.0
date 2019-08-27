Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74F9E743
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfH0MBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfH0MBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:01:13 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158CE22CF5;
        Tue, 27 Aug 2019 12:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566907272;
        bh=+qDRaZrhhb1AnXiN2Q6owroXAmMbmaNMt1oSngi0vxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kgZKzWyNadkQtNARRc1kbQlQ/WqYEk4l/taMGSezQMcG60hiIgIYMg8ExvVaybs+u
         zFUlKdXzmw5W7d5bGWOP+KluMTFo/rBz736H6LPK53jWo6joBHjLJlWy62dw/9dzDx
         ywdb4M1KVJwXKM2jHpcQb3T7eNKK2nS7SDy8kitU=
Received: by mail-qt1-f177.google.com with SMTP id z4so20996207qtc.3;
        Tue, 27 Aug 2019 05:01:12 -0700 (PDT)
X-Gm-Message-State: APjAAAW7NfL3scbmKC4/qmhZZStWVEZ6o7yFRXKF6/TYH4/NdlN9Ty4N
        XsoFiXnw+8yDnYvqjdTURH307yzIXWksOv6O2A==
X-Google-Smtp-Source: APXvYqyEt2vkODWvj59K6AZBb5LQezLcB8zz2BLGw5qL8r/voX1ixWgv8a0d3shB2fnZUTj0/du4MZQda3++8ScIa+w=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr22661391qtc.110.1566907271254;
 Tue, 27 Aug 2019 05:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190822092643.593488-1-lkundrak@v3.sk> <20190822092643.593488-4-lkundrak@v3.sk>
In-Reply-To: <20190822092643.593488-4-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Aug 2019 07:00:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKb4j5Yz2RvOY=H7iCQzMS6Y6pqhkSv+CLzQ2L=jzSHTg@mail.gmail.com>
Message-ID: <CAL_JsqKb4j5Yz2RvOY=H7iCQzMS6Y6pqhkSv+CLzQ2L=jzSHTg@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] dt-bindings: arm: mrvl: Document MMP3 compatible string
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

On Thu, Aug 22, 2019 at 4:33 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Marvel MMP3 is a successor to MMP2, containing similar peripherals with two
> PJ4B cores.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> ---
> Changes since v1:
> - Rebased on top of mrvl.txt->mrvl.yaml conversion
>
>  Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
