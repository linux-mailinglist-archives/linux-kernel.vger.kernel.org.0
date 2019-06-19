Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90C94BC58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfFSPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:05:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41787 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfFSPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:05:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id s21so3605481lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDvPZcVC+gwwybYP6ypnMMEtrxI72JBl/3PlooRRbfQ=;
        b=nwNBXy7ugHOIpZRcqq/rviBTBBpICuuG2sMFsTUx8q7ghVnffYjoh226yLeNczTF5Q
         QiiYiaiIc65I16YWjKfCI1sKStqQmEeYP5ZcV45bAlTGIMUkZsZn+RJXNVF4M2oHZ9DJ
         Kv97PrR2qOCaBip2yTuA05gd2YQGXd+2Xdtcdkp5/Al/FmzdmGFC+Zwg3xHcO/Fz67Vp
         8OmnowgxqSMY+JeKLQ/9d6rMl4QVb1w8OGdoW2l3JbxbmsUZAkqjy5LhLC8R9awH0MIj
         h8ijKFkzC6ZYj2MLpaebB5Jl/XaJPRrnAZL6FT89ThmOITgCtC1jdtrivJusj7h//Rbs
         /xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDvPZcVC+gwwybYP6ypnMMEtrxI72JBl/3PlooRRbfQ=;
        b=nsL4lvPvqKBU+ctjkAXIx0GcHwBdFzWpoRMcLBv5TR7t88QGqDC6I0DoZHgc7WaP9K
         Rslil1hUWsr8hJk0Av11xHTagoz0rZAqHmN/obz+Fzt/1pHyqnjvdq+LwvHnWRcr8dpI
         uVST+GFnaCEm9YVxI5zQLICKtCM36ST1kZQ6DXO9qwxMlnKrhjyMuNX6vOpksaG3Fnb8
         00HWB3dej4SLtT8z/oosn5k4G56+b9cRXTf4qFMwcqjqTeGBmWbz6x+q0XkL3w9fBdwK
         fCpS8oEwmB3/H39BpssEGuS323VzqV06EbyDtObWLNUY0HAKOfrdtUHTH5t0wM+Bv4sI
         CFag==
X-Gm-Message-State: APjAAAW65wQ5GTzN4k/LcGEvecwMYYBSHiVD63MrMMjJsj8ViuC0O4ea
        GOZE2bikSNu2ZKSKCvfPaadXgg==
X-Google-Smtp-Source: APXvYqwx5U2uWXAu+vwQMCy9hcnvOqeOjcjGcEeeSmsWGmC1iZtQE4bHSeFmxejgtQLupjolK6lIwQ==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr7118830ljg.33.1560956756417;
        Wed, 19 Jun 2019 08:05:56 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q1sm2736416lfc.79.2019.06.19.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 08:05:54 -0700 (PDT)
Date:   Wed, 19 Jun 2019 07:09:24 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] ARM: configs: Remove useless UEVENT_HELPER_PATH
Message-ID: <20190619140924.cl33iuqndoigldgi@localhost>
References: <1559636093-26005-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559636093-26005-1-git-send-email-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:14:53AM +0200, Krzysztof Kozlowski wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> ---
> 
> Changes since v2:
> 1. Remove unrelated files.
> 2. Add Geert's ack.

So your other patch added mini2440 in a follow-up patch, but this one doesn't?!

Applied with that fixup.


-Olof
