Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B403F1634CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 22:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBRVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 16:24:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45542 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:24:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so21625879oic.12;
        Tue, 18 Feb 2020 13:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wtMHXyFhYbqyTVO0vF6Kcqe6OQmnz/7Cal/xbWgxM1k=;
        b=Bg94CE7hqPzevjYJg2NB4gxfRVWaF6/4Tdeum73/RVvwbMarGkaw11gultWRJja5PQ
         0Y/gq/qqKk2qbbyzLqKOEDRttEyl8K9p0Vj5IHUszbvJgTwGQhkf6HhPYMfSLgTKFGv6
         8cFq76OQMsh/IZaBKcuBBzq95nJO549hO815uJbW+J8lpkGaKXqNgLyRFIWYEXkWIkt8
         0JFBzbmpudn+57Va7rYaJRfayuzYLgHi1JminW7xKyyroSetrm9U0yeWE69gZl2Rx89t
         r+yUuDDXUU+SGkOP1VZXJLVzI5GgnacNltweu1Vrc8ogcmPTXBnavTjIsCf8OnrkcIUE
         zLPQ==
X-Gm-Message-State: APjAAAU/mXlQ/kDc2ZJcAr4lNK8zslK8oGpZCQUPcxkpeEZVz3ZETbYS
        lQCtFa3wfNEfpEjFyU5LPg==
X-Google-Smtp-Source: APXvYqzRApOAzxWTuj6FxZU0qh45JNaX3foVD2D6h/wVsRSCi4UeCotVaoEUHsPi9xiZdnGVL+n19A==
X-Received: by 2002:aca:c1c2:: with SMTP id r185mr2676756oif.19.1582061060244;
        Tue, 18 Feb 2020 13:24:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm17411oib.42.2020.02.18.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:24:19 -0800 (PST)
Received: (nullmailer pid 29988 invoked by uid 1000);
        Tue, 18 Feb 2020 21:24:18 -0000
Date:   Tue, 18 Feb 2020 15:24:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        fabrice.gasnier@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: Document STM32 low power timer
 bindings
Message-ID: <20200218212418.GA29946@bogus>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217134546.14562-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 14:45:44 +0100, Benjamin Gaignard wrote:
> Add a subnode to STM low power timer bindings to support timer driver
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 4:
> - change compatible and subnode names
> - document wakeup-source property
> 
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml        | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
