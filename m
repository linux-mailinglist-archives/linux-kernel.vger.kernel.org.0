Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661049CF31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfHZMLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 08:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbfHZMLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:11:33 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953492187F;
        Mon, 26 Aug 2019 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566821492;
        bh=YjOhHVNb3S+TKmqIRau91HDeiF/9aMDjoGnlxjpwtFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXGicwi8LQMcrqtLzIDuXd2LskmnWsntr0uvzQtncJ+uBbM8dsai6PA6n9rZG3gIj
         a3B0I+mcQe2sdxhq3J11jzfVQZaccPj66WqPYLJBGrBvvKUac/qJCUXOYaTVoqz/Qx
         BWxu6sEVnIUFWYZiVrbCphZdvtqiIA96t3Gn3OUI=
Received: by mail-qk1-f170.google.com with SMTP id 125so13774282qkl.6;
        Mon, 26 Aug 2019 05:11:32 -0700 (PDT)
X-Gm-Message-State: APjAAAU/AqaktpcFHCPSQBVrSzrpQaHlQItyqognBR9pw/7wB0qtUO2e
        aRzTEFJiP1OWJCwlU5VbolbQcBNdJPTVNnl+rA==
X-Google-Smtp-Source: APXvYqxagKO99F9mS7t6DaXXxukZkMZEy/9XN2GKqINovi5R7IFk0Zl3h+jg5Zq3YC4qsFWsngg9N8DwLKv0FhuW7S8=
X-Received: by 2002:a37:4941:: with SMTP id w62mr14601999qka.119.1566821491710;
 Mon, 26 Aug 2019 05:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <1566633850-9421-1-git-send-email-christianshewitt@gmail.com> <1566633850-9421-3-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1566633850-9421-3-git-send-email-christianshewitt@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Aug 2019 07:11:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJvyYpAb2n1aq7RRKrgnt+oL2yd47b4jh=QiZdu6t39A@mail.gmail.com>
Message-ID: <CAL_JsqKJvyYpAb2n1aq7RRKrgnt+oL2yd47b4jh=QiZdu6t39A@mail.gmail.com>
Subject: Re: [PATCH v2,2/3] dt-bindings: arm: amlogic: Add support for the
 Ugoos AM6
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Ivanov <balbes-150@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 3:05 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
> S922X chipset.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
