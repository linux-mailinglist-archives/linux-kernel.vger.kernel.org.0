Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4CA59EC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfIBOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:55:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42947 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbfIBOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:55:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so14305870wrq.9;
        Mon, 02 Sep 2019 07:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05naA+tRFr1oVP7UyroxrvoG5G6/VszoOUPqo59hvhc=;
        b=H0U6QMs0axwnl5sxwRXiPWipAAarGf4uyOts/CANRQwnqw1F/ivTZtH71lYY7hJNAN
         XFkMNRTF1vjJlOV/uOpe5BZ5B3uHp676SMYpjkis4hlGPjH2Gp+W4Aa6OgXkE07BrmUt
         5xaOSxsfXHsiltHNiov8NCfH3AYjIx51z+ZJ3wTh8ZBEHW7PeJ7BTm5kofdk0RKDdqB4
         Kzi+AsT+mcWSrM38U7oZzPEDewdxCRQFZbbif/3gz3hK8/4cWHaubf5EuaB8XAbhsxmY
         fC5OJutlEWd7ICbhdFK4K4xqVVXwNQ3HJEPSsZPSl7GiuJ7yT1w0zNkmzTDBxto/s1AA
         PBCA==
X-Gm-Message-State: APjAAAVfBVeoMO28QoREuweqRtoslP2ULm74CC6121keGhgjOlYE046g
        RtPnOFhZGH3IdZ6RA6wn+A==
X-Google-Smtp-Source: APXvYqyIDvYfiwAUsbogEBML9p8lY5maoaCIAtBAckCgpS3h5i2lNutbJF7IUlph/pRFUQtWBPP5xg==
X-Received: by 2002:adf:e947:: with SMTP id m7mr22629133wrn.178.1567436118161;
        Mon, 02 Sep 2019 07:55:18 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id a17sm16865787wmm.47.2019.09.02.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:55:17 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:55:17 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 5/5] dt-bindings: arm: idle-states: Move exit-latency-us
 explanation
Message-ID: <20190902145517.GA18377@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-6-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:03:02 +0200, Geert Uytterhoeven wrote:
> Move exit-latency-us explanation to exit-latency-us section.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
