Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D09F1304CE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgADVz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 16:55:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44704 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgADVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:55:28 -0500
Received: by mail-io1-f65.google.com with SMTP id b10so44765897iof.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/EnumApSDmaO9XbzKzz36+u0K1L2iTuLSdvygNUnhs=;
        b=Vg6EaooRqXY03K9oMl+b25+P5lBIkujd2aB70aKcgGfh6kO44sftiDSeDtgP2FYuhm
         Yh0+tuY73J56LG8Qo520f16HD6SCU63v6bZo40T+5OnwKCoddLfDmkkjRChJkUaAyJrZ
         66KAixsSMMmfPDcEay7vBbDz/7zgZFdymuVvLi8jo0xG3+3w0uiJG/INHBvhTVkhvunw
         gt2iIYj7Lm91kWiCqTA00ZOBergKESmXWbkGHYKKQrHiRpMZh7c7m7zxYprSdIkz2WhR
         hbDQxaY+MjPjMvFUZhrfFDtdDQlaaU7FabKpZ3nh8g1WE7LldI8x9DTEKN5+ffkXrcF8
         uA+Q==
X-Gm-Message-State: APjAAAWcUZiJslK6+mk+8IUalc7JYNUdgId80zl6/c2MaHUE5DAJ3J1e
        8RNa370SLud8rL56cptKR9vZxy8=
X-Google-Smtp-Source: APXvYqxT5UPtFDZaWgSN8IZidgaPNxvyu7Abr0unjO0Lv33nANOUZ/3MyhbRzjSobsKc+7sAmJLVtg==
X-Received: by 2002:a6b:1443:: with SMTP id 64mr60342089iou.116.1578174927275;
        Sat, 04 Jan 2020 13:55:27 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a9sm8306459ilk.14.2020.01.04.13.55.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:55:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:55:24 -0700
Date:   Sat, 4 Jan 2020 14:55:24 -0700
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: remove identical phrase in
 disable-wp text
Message-ID: <20200104215524.GA28188@bogus>
References: <20191219145843.3823-1-jbx6244@gmail.com>
 <20191228093059.2817-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228093059.2817-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019 10:30:58 +0100, Johan Jonker wrote:
> There are two identical phrases in the disable-wp text,
> so remove one of them.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Rob
