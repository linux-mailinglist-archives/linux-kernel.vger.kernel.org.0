Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B2812FF9C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgADAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 19:33:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35325 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgADAdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:33:44 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so38042258ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jtU2GwA92LWxQFkeCrbjyJNc+9eRgZ+rt7rVVu7gPA=;
        b=tQet3jVEn8mdrrl4FNQmQbwSSGu4U5lOe/9qCAgHU3uHnFNiZiSOtGNNourmAAti6z
         h7pkAOZgJGNNA4JTjjZPsaI/zCVioPIvJpwyOF5Qn3H1QFdxMjQGisQ20wC9VVO3b4oG
         CF1datDs1PQ+w2jPcG9LR9Op5NKLD6I+HafpPnvzH3fKFpJEBdsMgFq+tT6yNjeyZHlA
         Rc7j6srqQNObQ9/QNaEPca+mFiiaYsXwtSFpLbuMGxxjIT5jDnmYRvWED1xsXnBH51Zs
         xGUCFV1fHK45wIQ8xEfyesaD0TJA/xIFxnm4ds7UDmiYUcT859372p0uiJshMNwsj13p
         gWBw==
X-Gm-Message-State: APjAAAUiwakKynB1XJfP7/kU2novPnbpiDgXNNdk3kcp9S4FtyT+wG4Y
        yrD4JxBjvc40ZOdL0qjkGwDcxmg=
X-Google-Smtp-Source: APXvYqzCXGOKXDNLVyLzD5xXDXyFebS/Ev7PoDzB/g25B25QHSqUmPv2rhOY3wkYEFVn5Esu7xnUUw==
X-Received: by 2002:a92:47c9:: with SMTP id e70mr75233471ilk.144.1578098023970;
        Fri, 03 Jan 2020 16:33:43 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v7sm15375106iom.58.2020.01.03.16.33.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:33:43 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a53
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:33:41 -0700
Date:   Fri, 3 Jan 2020 17:33:41 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/16] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA
 Tegra support
Message-ID: <20200104003341.GA5889@bogus>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228203358.23490-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2019 23:33:43 +0300, Dmitry Osipenko wrote:
> NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.
> 
> Acked-by: Peter Chen <peter.chen@nxp.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
