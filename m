Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9D163AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 04:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgBSDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 22:02:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38938 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgBSDC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:02:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so21716155oty.6;
        Tue, 18 Feb 2020 19:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wM36jiU/uEy31IzeR1mb5iKzvzrpChL40oT2SOGRUi0=;
        b=qzskkf1RXfl7KmjISWu0PLlSrs2kIyEPEHbiHpF3eLRENVEvhyfxeKgDBWx1ZUvbYz
         Shve/mgNLvkGEEdMsIJE4fjgQewaSooGPXqmyalV7CXRgOhEWyFmdEktaoTF2/aM1uuY
         uVpRcFCobrVdaGfdQMJkbXzL60byL5G5P2f16HvzvnSNvnSAn3vbzLrtp65cSUDMFItl
         FS4AbYXl8FqbeFqzVctYyfcXgGb9OeN0Psb1vQXn+2EVPh5JNM44CZGtu5EvK4SHY/bh
         TFuS6wr3EFy+GPdbcAI1c84Yowb7TTx9JkeYNrilXlA2hixBUh2KgaKIkmpQXRjA2LFT
         GXKw==
X-Gm-Message-State: APjAAAVhCqStcEPGrJftglz/4k16poa2JDve43k6ufUc+Ls/lV1193Vv
        qdzco7FDRk06NQvbYKPVVQ==
X-Google-Smtp-Source: APXvYqyK+6EWyXhC3a/7xDZK0yFV9OL48vn100QsFjIeQ8ddy37zTQgKDMZU5KOrzSI/ZG374IuWig==
X-Received: by 2002:a9d:4c8e:: with SMTP id m14mr17131477otf.245.1582081348149;
        Tue, 18 Feb 2020 19:02:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm199703otl.60.2020.02.18.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:02:27 -0800 (PST)
Received: (nullmailer pid 14862 invoked by uid 1000);
        Wed, 19 Feb 2020 03:02:25 -0000
Date:   Tue, 18 Feb 2020 21:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: mmc: mediatek: Add document for
 mt6779
Message-ID: <20200219030225.GA14824@bogus>
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
 <1581922564-24914-5-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581922564-24914-5-git-send-email-chun-hung.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 14:56:04 +0800, Chun-Hung Wu wrote:
> Add compatible node for mt6779 mmc
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
