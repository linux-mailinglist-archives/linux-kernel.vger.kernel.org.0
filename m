Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D96380A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 16:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 10:38:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36255 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:38:41 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so28066846iom.3;
        Tue, 09 Jul 2019 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+prWP/l+NiaYOcrIk/R8mV2BTVhCl2S22LwiNWpEL0Q=;
        b=Ax9PXdoO5Cn1pUF6+EACh4GI81NYTMp5t5PhYKxqFPzjO8Pf/0UQC86EMuI4rqH6BL
         IqMACuhQ6aWR1YJkuqPT+DMjFM8m9noWJ45Xyx49m1BBTwtoxR63MhveYs5OVHQ/Ihrw
         yug1U71C7439xL6BaHeJAZOsw5WgpEFZTSRJFTdeb31BoXrQnNlWC98FRj1M2XY+sWjC
         b157r2SnEZ2NOIyTg46EwA3sltsT0lh9wJDZc07nrdLmSytN5QouxXLBLyjX8I8IvhNI
         GKzcUZFntKrf5jzDXd85fO/oUUFH3GAWYyl5PDEz5AMiM0E5ARj0cnzp8zSbcNsitgUt
         lL/Q==
X-Gm-Message-State: APjAAAXLax8Q7zdJsaBbn5YLwGXydboBoZl6Pd46hdTokZxnZ5w8Qm5U
        Q5xZ0KseMUClrr74DS6p6Q==
X-Google-Smtp-Source: APXvYqySHhAtm9GlvHKsUPEMTbTk1st1sP64SKKq5dl6tEvxnFV5wYea+XzPa0VvC7nIO5Guff5xRg==
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr556026iod.254.1562683120146;
        Tue, 09 Jul 2019 07:38:40 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j1sm17618610iop.14.2019.07.09.07.38.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:38:39 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:38:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: serial: add optional pinctrl states
Message-ID: <20190709143838.GA5665@bogus>
References: <1560433800-12255-1-git-send-email-erwan.leray@st.com>
 <1560433800-12255-3-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560433800-12255-3-git-send-email-erwan.leray@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:49:52PM +0200, Erwan Le Ray wrote:
> From: Bich Hemon <bich.hemon@st.com>
> 
> Add options for pinctrl states:
> - "sleep" for low power
> - "idle" for low power and wakeup capabilities enabled
> - "no_console_suspend" for enabling console messages in low power
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index 5ec80c1..64a5ea9 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -13,7 +13,14 @@ Required properties:
>  - clocks: The input clock of the USART instance
>  
>  Optional properties:
> -- pinctrl: The reference on the pins configuration
> +- pinctrl-names: Set to "default". An additional "sleep" state can be defined
> +  to set pins in sleep state when in low power. In case the device is used as
> +  a wakeup source, "idle" state is defined in order to keep RX pin active.
> +  For a console device, an optional state "no_console_suspend" can be defined
> +  to enable console messages during suspend. Typically, "no_console_suspend" and
> +  "default" states can refer to the same pin configuration.

no_console_suspend is a linux thing and doesn't belong in DT.

Rob
