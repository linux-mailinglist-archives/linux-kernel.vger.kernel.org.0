Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77A6F7148
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKJ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:59:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46724 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:59:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so13845021wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eD2mFxfVr7jqwjCQLkcsr471D4SkGotzfy35wgYgUMM=;
        b=RMN2bA4+lMAKFdwR+4JeDk0HISR2OU0FOBH3RzzHhI/3G7Aeehalukuq8QJv4Iaw4u
         D87xCtfvNz2KS+6hRDw9iic7hESPaOmQVDI5cqXwZxaKfoOKwohZvJCreG2uDfCbO9Ob
         pVYsTBYV0s8KAOnyoFmcGQZyFn/NNVuIQr6G5NlXgnEeRcwJIKFJ2Ef91rhf8aZayj18
         poEvX7X6+puOeqqfaJUF6t0tXUPzylfEDQYHhJF2LFBMArOPABUWOe4qSFXkrqHcXllV
         Tt8ihTjn1PbSxdQnSP6n/njk7ICTSj0UA6XmKtzNqwPKneov+0K9K9JHaecUGUBN3ADb
         7L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eD2mFxfVr7jqwjCQLkcsr471D4SkGotzfy35wgYgUMM=;
        b=i2SeDuYB7SqrHg+nZoeQ4Vk1yQ6QND/ss0Y7+mkYGDTaB9Pqb3/MbJgIG9sift9b1J
         nELKnyjGaxU+hLYP7OZGk7HiGBT/NLIRysMrz2/bAsQjME0RX+Ts82W+hzrBmJ1QekHj
         RJupB3zxgS9jel2ViYQxhM8KZYJzojXy0t+aeBvg5sLyYGdoIh4CLBzEMVU+CF4e+0r1
         2j7tsjm2378kXK1JCVGKKTNLPLglUUcMrO+Cv+e/ERfsaNMX8JKNXHC7sgIa56tzsc3g
         rTgrc35okZA2fzdwZn6gPgY3MDdklz6lu8hDYxpO4gSExS8vetCZzWYFLAkuorFFSWuv
         kwUQ==
X-Gm-Message-State: APjAAAVYgxQu5uAv/Ha4sW1oNLFePSCOBnLhb+4j1amm0b4HvdLi1W9c
        KOCw66sOIexcksbm7LSL9jYkYg==
X-Google-Smtp-Source: APXvYqyP3ss0XlR714UlyWGfjXdVI34ShILsdqamZSJmStxPFOuXee/ehWWpIIjd+7QdhhoQvF5zJg==
X-Received: by 2002:adf:de86:: with SMTP id w6mr19953529wrl.220.1573466353227;
        Mon, 11 Nov 2019 01:59:13 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id n23sm14842601wmc.18.2019.11.11.01.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:59:12 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:59:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] power: supply: MAX17040: Add IRQ for low level
 and alert SOC changes
Message-ID: <20191111095905.GD3218@dell>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107031710.5672-1-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Nov 2019, Matheus Castello wrote:

> This series add IRQ handler for low level SOC alert, define a devicetree
> binding attribute to configure the alert level threshold and check for
> changes in SOC and power supply status for send uevents.
> 
> Max17043/17044 have a pin for alert host about low level state of charge and
> this alert can be configured in a threshold from 1% up to 32% of SOC.
> 
> Tested on Toradex Colibri iMX7D, with a SparkFun Lipo Fuel Gauge module
> based on MAXIM MAX17043.
> 
> Thanks Krzysztof for your time reviewing it. Let me know what you think about
> the fixes.
> 
> Changes since v5:
> (Suggested by Krzysztof Kozlowski)
> - Rearrange code and add max17040_enable_alert_irq on patch 1/5
> - Remove useless dev_info

Just something to bear in mind in the future:

When submitting subsequent versions, could you please do so as
separate sets? Attaching them to previous submissions gets confusing
real quick.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
