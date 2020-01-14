Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB76D13B5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 00:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgANX1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 18:27:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42405 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANX1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:27:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so14404304otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttZMLAqDhxSTsHlfd8sLeyc9soxLzGATxjf7nZzKPPw=;
        b=oc++Qy1ydxir8V8MInt3cnVFzHGNZCJzwzZNIm5WnFk0aU3n2RGDhWJqPkYsRVQaxZ
         uh8uzd0hoLWpEEUoxGooxyA9jtAZB9Mmxcef0AkiGrYzwU30sgsCXl6POE8lvZ8ANwiG
         GthMSUl59S/Qzpfmu6sCXpkSKPiz0k/w+W5jSVEfZQCUscslh1N202NbuOfX31qmp23Z
         6T9RlzGReu/lDqb9pUXO4lp+bXijEPkC8gyARKS751k1364M8JKA77PU3ZnXv1mfmARD
         vHpGySLdfyu81kv4LQr8c3qeIyFJjdgEwnnzQzSuzeNntOUAeLOy09V4blGKPTTW9UoB
         g2GQ==
X-Gm-Message-State: APjAAAXSy2WnF/f4N4FaeJiDNaOrk+2BTcJxlHGjfH+z/pzhGHkHnPqv
        GmMrRkC227qh/hOt+dgPieZJH7U=
X-Google-Smtp-Source: APXvYqxDsN5FkUMyo6QVPa+7Uh4itS/NxQkvwY/TuFxVWHQjaMmeAx315uDEnmBdPpOLDD7/zwY+0w==
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr711195oto.30.1579044422035;
        Tue, 14 Jan 2020 15:27:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v25sm5847316otk.51.2020.01.14.15.27.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:27:00 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a3a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:26:59 -0600
Date:   Tue, 14 Jan 2020 17:26:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
Message-ID: <20200114232659.GA16642@bogus>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
 <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578997397-23165-3-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 12:23:12 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
