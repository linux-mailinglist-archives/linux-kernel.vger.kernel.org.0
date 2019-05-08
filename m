Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE917866
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 13:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfEHLff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 07:35:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50200 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfEHLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:35:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id p21so2844949wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hAMl/+DqKNLcQ9uIhpIg0nMuYp4Zd7mNyRn5drWdpI0=;
        b=ptEhLMvtKWiWv+dp59FqYZsQybRnwOnRQqtLk4CJKo7J3FNsfcfKJa9PuIZyQM3UMQ
         6vFu56gumTM0/5BQp1riuwRFWJTqXB6c/fxLN03veEV4K8gO3zeGJN6M1ZvcDOe7HgcH
         30dMBzCfldQYcEMUJ71HQOpiTeSKHYUvAeYqdcLH4eo1UGKj/pEhJWTLTFJT4Zv3Ui1s
         /zjTA/PeiK7dQiuHpcl8x/WWW1aGmBWAaHy5Jl6GDsk78oKbRgDONQEqYzg3/TAKhO0i
         a0hWu3TDQbb3tRZK1wAzNTJ5kb3Nxh9ceBdDn8KEBnZwpNiW2Oc06U6UKDqCo/yfGIPG
         ZhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hAMl/+DqKNLcQ9uIhpIg0nMuYp4Zd7mNyRn5drWdpI0=;
        b=S3yKvvdvclGZcch3PoOpwanx9uSu+KDSzL1DKh8ILv8iKIPVHbvD5B7FnA34zxD9ct
         JJ2TkZpQo4KFNwyUg8CUmvjwWoZaPre6j49aTT43cJPpbW3Cks9dN8c4zmeJdId286S7
         8iDbhwBxP57Pl+ukDvdmRFyyxc9sma+r2gc7BbG3e5nN2tj/vOK+QSQcM8BDVj7uNfuW
         q6tubJe5VmvjKUOeKJhHs8T9EDh1U9HN8CCBYTtDvV/oerAzYbrFZDIHsD1n31SQ+qkv
         y2OPi3VXW9WGucSffsdOe0ftKSzBrlp1JBfhgTAyLMgbrDkTXgEHSoMF5NjkcoAS4TOL
         bIyA==
X-Gm-Message-State: APjAAAWDB6KdM6HjVK70butYYcbdfO7RaciJG51LboekOFORS/v0fL6Y
        jK6DEA/HhBAPXBbv+DCbVoDIjg==
X-Google-Smtp-Source: APXvYqxHoBEM8HLpvRpwmchrMCOZfR7Ng9ZIg90jSpCNLWdHtkuM3mJuFjkDJNPP8tm3QMKL03HBQg==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2799407wml.28.1557315333317;
        Wed, 08 May 2019 04:35:33 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id r64sm7768004wmr.0.2019.05.08.04.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:35:32 -0700 (PDT)
Date:   Wed, 8 May 2019 12:35:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/7] dt-bindings: mfd: LMU: Add the ramp up/down
 property
Message-ID: <20190508113531.GB31645@dell>
References: <20190506191614.25051-1-dmurphy@ti.com>
 <20190506191614.25051-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506191614.25051-3-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2019, Dan Murphy wrote:

> Document the ramp-up and ramp-down property in the binding.
> Removing the "sec" from the property definition as seconds is
> implied.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
