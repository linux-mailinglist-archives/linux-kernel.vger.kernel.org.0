Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB41209D2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfLPPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 10:38:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43219 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfLPPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:38:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so9651396oth.10;
        Mon, 16 Dec 2019 07:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnkOsuCyZ6LgZA6WK8OXgo4HhYM+KMZyOo083tpZJdo=;
        b=DHWXi3B2EuQPj2acgSTCsKNdEERZM6dWeMROsadeuqeymcjaVl0cjfk42U7Tq191dx
         qbSrD1RCDGjEwuANHB4IvGXnuL8sMTt0ZMsHAoN05V8AQgAnehk+xYN4VnB1L17333QM
         i1mAJL2vsQn/0ff5yBt/cGyf3acsz1pfcP8HIR2QAM8u6DfNq6NA9tegY/jD98KUI+7v
         /4b/z/z2ui+iL4CTpBXzP0vD6AWhCdtSXmK69z3Q+GZFX8gQnsxAnT0P8N6OkSH9bTmZ
         NDd4OnXfkfXWXNVdjVCKsmi4QUIqAMYpIcgVN7E3RGJj8InXe/kJVSc4yYeOdkrL3wEt
         QyBQ==
X-Gm-Message-State: APjAAAXAQbGakSz8by6TUqoYtlZwp1enXcbO9ZHghjv9pevonyOEPftx
        e/ORijXYZwqRi7pcR4hf8g==
X-Google-Smtp-Source: APXvYqya7T3obFF+cjuSfK72FvIz81CcveEAuSaKiMd+yY6Eg9+cGk/LensHd5maeRqxLJRZ1Bd7pg==
X-Received: by 2002:a05:6830:2110:: with SMTP id i16mr31523282otc.337.1576510714277;
        Mon, 16 Dec 2019 07:38:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t3sm6863170otq.32.2019.12.16.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:38:33 -0800 (PST)
Date:   Mon, 16 Dec 2019 09:38:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     devicetree@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        JohanHovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: add "hub,interval" property
Message-ID: <20191216153833.GA18715@bogus>
References: <20191203101536.199222-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203101536.199222-1-ikjn@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 06:15:36PM +0800, Ikjoon Jang wrote:
> Add "hub,interval" property to usb-device, so hub device can override
> endpoint descriptor's bInterval.
> 
> When we know reducing autosuspend delay for built-in HIDs is better for
> power saving, we can reduce it to the optimal value. But if a parent hub
> has a long bInterval, mouse lags a lot from more frequent autosuspend.
> So this enables overriding bInterval for a hard wired hub device only
> when we know that reduces the power consumption.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> index 036be172b1ae..44bef2ff2704 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -66,6 +66,9 @@ Required properties for host-controller nodes with device nodes:
>  - #size-cells: shall be 0
>  
>  
> +Optional properties for hub nodes
> +- hub,interval: bInterval of status change endpoint. The range is 1-255.

'hub' is not a vendor.

'b-interval' instead.

Rob
