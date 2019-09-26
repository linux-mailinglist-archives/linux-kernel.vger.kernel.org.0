Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3BDBF4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfIZONZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 10:13:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39572 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIZONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:13:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so2753853wml.4;
        Thu, 26 Sep 2019 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hBZ8CcivE1NYUxc5O3ZPMVIRE/wsSIlTMNpDwyj/BXg=;
        b=IEvvVf363u2geGo2S9jgMBQ+X78E5PxplaUygSnwwX9IKYFKkpxMu2VR10bZE6PJyT
         uF5BdQYKIXM7w1st/HEkeVUpBa/vmMm8/iIZymztHgHIQsW5YoYuiYUjh5QmUZVAKhRH
         ir2CwBtSH7qoGNZq5N+TGkeYcGpqyIarPWVU2V8jKhGdajYRMLNsUO4VMNKYxmDJR5Tu
         yoiy6SVRlnG2PFyVlbbQS83l4WCN19H5/76+1AN2W8A3f8ZTeaj/L88KCujMIM70YQUw
         mo96wVatsSsNFW8HeZtOL1IAlaKClyORbWZ+b0bblDQ+0r2yUxfH0Z2h+QuhjMU4ufd9
         NvTQ==
X-Gm-Message-State: APjAAAVt495lbWjUEGdB42EnwvJ4qkMTVlP9Utp2zHnYaBL6OF/bRa0G
        y0Gh+Qhecbq84/qPbmJV+d7McQs0
X-Google-Smtp-Source: APXvYqwFGmBsmHkzm5BSclLX9I0aHlju/5ZEtE1O/WmLwArVHDoSrkBS7RuTKuyW+Dop4GgKC7Wfrg==
X-Received: by 2002:a1c:9dc1:: with SMTP id g184mr3132920wme.77.1569507200896;
        Thu, 26 Sep 2019 07:13:20 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id h63sm4348246wmf.15.2019.09.26.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 07:13:20 -0700 (PDT)
Date:   Thu, 26 Sep 2019 16:13:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: i2s: Document clocks macros
Message-ID: <20190926141317.GA16044@pi3>
References: <CGME20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba@eucas1p2.samsung.com>
 <20190926110219.6144-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926110219.6144-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:02:19PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Document clocks macros with their description
> from 'Documentation/devicetree/bindings/sound/samsung-i2s.txt'
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added proper commit message and description
> - Moved comments to the right side
> 
> Best regards,
> Maciej Falkowski

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

