Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4779B44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfG2Vht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:37:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39324 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388789AbfG2Vhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:37:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so43085664lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6SGKTpDBVf1QoMNMHV2QxgTIUw60sPAmgJMLuUozsA=;
        b=u8iapjwNjwnZ7jcCyKefFe+jgiBX5u5HsLpuFvT0Z1yV+9VtwjFOQcc8ZOMl6KvFPF
         M7QYUd9GHwY89FO/oIy6Vs7z2LpUu7VvpqsZcilOTsOKDmMpm2e5QMU1PO9cNUZZbgSl
         E7qc0BLNAU+W0cXByg1aaGz7e1qqPtAIKoeDdHRcuRXAV/U8FwFMO2v9GRT6O4lnbmv0
         STtsybUIKUHzspa5YXLLFmIVORmtDhBfSpcRz6FxasXB3ukoXv4J6Xx0nc1CqaS0brjS
         KAatnGipYKvOgHMS/jo0jJcdLtJrjGEIa+gqcxm6qIaCuw0UWtIpdSCMFAF/cUigb6S6
         L2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6SGKTpDBVf1QoMNMHV2QxgTIUw60sPAmgJMLuUozsA=;
        b=pydrhIk9L6Nw7obDoaTyhb5kNQei972L6DTB3+Kv8ihakb0VOOa8hBYlhjRBSBSpnJ
         pXIEKZoyWm9zVvJDS2M0zXQ1dOosPSB3kawj4YaizaygkSW3ZLl8+ZG/N6FK/BlTmLZt
         +ndHbNM5msF1VlRMK+ttYU7BSuKe70Zo0R9HGplufJgGKZEZzHKEkl1a2srI2BFfihKR
         AzchQFrT3I322GPSawcUR4115YPlx47Dvl+XODnntMruGC1u7ckIB6JSrwKJkxGIcxHr
         Zrh2t1xKRQHJgItKy520FN01kdaJnmjJldzp/jNuP7V+2wWZeKW/UBAU9Pig5BeFrRuq
         x9Nw==
X-Gm-Message-State: APjAAAVW2d26YAyhXqX4hy08Vme/90tbC8tRi/WXF6VzumxUR7pxVXwg
        L++ayp0DHVJV+k3319fAOHks14Pkf/JJnpJaYYux7Q==
X-Google-Smtp-Source: APXvYqz3UTZrxCuWCFpHX9xCUQzE7FgKee1vYyZDSUrGPt39sYEtKuROQUXJZ4DR6J5QXxct4aus6tuGSmQowU3As4s=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr54407619lfc.60.1564436266269;
 Mon, 29 Jul 2019 14:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190712061721.26645-1-andrew@aj.id.au>
In-Reply-To: <20190712061721.26645-1-andrew@aj.id.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 23:37:35 +0200
Message-ID: <CACRpkdZxcRqV18tfcJHNVD=FUwDShwJsJm-v9+SVrxGPC5jvxg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: aspeed: Strip unnecessary quotes
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 8:17 AM Andrew Jeffery <andrew@aj.id.au> wrote:

> Rob pointed out that we didn't need the noise of the quotes in a
> separate review[1], so strip them out for consistency and avoid setting
> a bad example.
>
> [1] https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/002009.html
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied.

Yours,
Linus Walleij
