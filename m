Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE77C943
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfGaQz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfGaQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:55:56 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9093214DA;
        Wed, 31 Jul 2019 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592155;
        bh=bu2/IzitZpcqBSeCvVLwvyS9Pg3PnwR+a5FlsLqKfwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o/YgXu/1eTjtGCGzZ/OwQR5HDIIAYPv1s4Ry9B/VG0+8TbBTE9xc/OXQM/EHcYcZ3
         X6RpcDqanN9nOJhH5PO31520ZAzINdR7OqDxxCWR8dU1jSDIrRI0dU9GoiFRPk++8Y
         ynZqXfGcruJQ0nDV6aK5D5raa2FrgKfkWnKPg2iU=
Received: by mail-qt1-f173.google.com with SMTP id k10so67366784qtq.1;
        Wed, 31 Jul 2019 09:55:54 -0700 (PDT)
X-Gm-Message-State: APjAAAU1wdmwGOkOEmzWMDT3X18kQknjhmWkIoprLxSDadaY/Lnns8MV
        3SzSr9QvJKb1AsjXUCfV+xR47Qy+rFjn12bCMA==
X-Google-Smtp-Source: APXvYqyvNP50u9cI3UCf6+YAQwdF9Av65FYOMp2vrFwHw2oLly8ZNSDLF7JYdlfrkafL15qyfM8KXu+yB6C5vKjJVqw=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr86824910qtc.143.1564592154073;
 Wed, 31 Jul 2019 09:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-4-narmstrong@baylibre.com>
In-Reply-To: <20190731124000.22072-4-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 10:55:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFacYY06keqny2RTvCd1R6eDmZmVG5WdjoDHdfwAObgg@mail.gmail.com>
Message-ID: <CAL_JsqKFacYY06keqny2RTvCd1R6eDmZmVG5WdjoDHdfwAObgg@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: arm: amlogic: add bindings for the
 Amlogic G12B based A311D SoC
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 6:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add a specific compatible for the Amlogic G12B bases A311D SoC used
> in the Khadas VIM3.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
