Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7298F8CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLKSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 05:18:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:18:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id d22so5610499lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Xgtqaq5OYEXrCsRgCNIoFMf/+WJUCVEYKYpGpS7YU8=;
        b=QQBueBwfI/a7fkqzDqYfGKTiu/1xAnqYnlus26HLvfFunwYj6bVpWCIUI8G9tbxOZi
         53A+CrzFDXdVTfm2YM+t4ZgqfN4vN62YPnOckvmvKqDqSY2Uq6Pr7JABpzrQG0N5BQmz
         CAXucylRYS/kztC3mymlfEvuOJeGfdHbfQeG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Xgtqaq5OYEXrCsRgCNIoFMf/+WJUCVEYKYpGpS7YU8=;
        b=CYF7Vp9u4oNFaN3sSCtnFxALumbR71COthEO6TEb3sZaHaT1dBb5y0rpEBCxte4ohg
         hREt9AaT3YCsIQDEEqFdrBZ8228VAhQMXNn5iq5+SqZ+PNuu33FV+e5ILtVdfZmpNjLc
         rk3Ck/A8Tt4pezRuFLneGSJtyLsHuV3N4y8NRElvopQqfGrTBXk6XchN9DWa7LFmhjzd
         WOp6Dny0KIzbKxsMMoi1pWNX+vmFvV9iXOceCUAlgP0cc5nhFoUSMW97BjidHV4VV9RQ
         R5sp8Xtjmn3+bdh+RioZ8cZqzxQGHC1qCMN/Y552ml/oNnds6PuEs2rL8402/0oa5cH8
         XP3g==
X-Gm-Message-State: APjAAAVwHV86JfgwHeUzmMhhrW66gjiiC4FG6h6e/rIf3qy6ygy1b9ew
        CrUiAVbWOq7Ic4TZOdGYjbz6dg==
X-Google-Smtp-Source: APXvYqxpqr5aC5YVuq0isONYu2VTTVwq6M2eWXZo2QouyL+jPA+MxTDE/jtPVwzrkEaBAVG9irXCjA==
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr19808666ljj.252.1573553894776;
        Tue, 12 Nov 2019 02:18:14 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a18sm8340189ljp.33.2019.11.12.02.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:18:14 -0800 (PST)
Subject: Re: [PATCH v7 0/2] Add support for Layerscape external interrupt
 lines
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
References: <20191107122115.6244-1-linux@rasmusvillemoes.dk>
 <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <184b684a-7712-a280-fdc2-83d7abd3cbd4@rasmusvillemoes.dk>
Date:   Tue, 12 Nov 2019 11:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ea802f081d1f1d4c5359707ff4553004@www.loen.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2019 11.24, Marc Zyngier wrote:
> On 2019-11-07 13:30, Rasmus Villemoes wrote:

>> Rasmus Villemoes (2):
>>   dt/bindings: Add bindings for Layerscape external irqs
>>   irqchip: add support for Layerscape external interrupt lines
>>
>>  .../interrupt-controller/fsl,ls-extirq.txt    |  49 +++++
>>  drivers/irqchip/Kconfig                       |   4 +
>>  drivers/irqchip/Makefile                      |   1 +
>>  drivers/irqchip/irq-ls-extirq.c               | 197 ++++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644
>>
>> Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
>>  create mode 100644 drivers/irqchip/irq-ls-extirq.c
> 
> Applied to irqchip-next.

Thanks! Can I assume that branch doesn't get rebased so 87cd38dfd9e6 is
a stable SHA1? I want to send a patch adding the node to ls1021a.dtsi,
and I hope not to have to wait another release cycle.

Rasmus
