Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB2172AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgB0WH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:07:28 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41446 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbgB0WH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:07:27 -0500
Received: by mail-ua1-f66.google.com with SMTP id f7so249785uaa.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8QGsDauXMWl04pUSYOUK2oYeibV2ZardTahQjqaKFk=;
        b=HggjBvjjWDPJZSURFuVLSTpxwz1KWndp/rAWYhrL+pln1rYsnyCMEyQ3snRtzaNEHg
         n9IRY4ZR5Wo1EHVL64wxWm9xoF5McMgaU5AOtlrZ+WFnqVK2tbpUk0G/Ph785hgt6It4
         oS3tzrIWm2mJXWPO4lcujLYuwTH+J1DQiTTc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8QGsDauXMWl04pUSYOUK2oYeibV2ZardTahQjqaKFk=;
        b=HlG4lNSfiNgsjjXLb0yeRrqKQoe5e5bRpyHRcyNRuxRV57fiwT3vxwl01DlczicYWv
         GPxCwZvfR2HVgOqdIaCsV8ygZoAtVcvBprRZOEyvLHw5h2KgX3rqzNDKGy15iU9Ajx7C
         7Vt/Z488f9yaAlld4vWZtIOsfOWPrjinuwrAz7/HGf0ohC9MHAtDUR4QkZ8sq3lMbL6U
         JfL3r6l7SlIry7EEFS6kmoOGGPoAvsdlq8rRiU9L0JdY8Cin2TjiQ/QBPUn4lBVoNljA
         WtUa7rVwNBJ9kLFgrO1Z1siiqTmSgAdmOwiqOlptcXZzOswze2GsBIvYIlNZ0jIOgnGV
         xb7A==
X-Gm-Message-State: ANhLgQ3RG9VrukqsE3lpjBh9SGBDXY9+Wx40lqIxU/1JFTfNzkiKVMOd
        vDkTo60nNtyceF4XM3/RaPnDh+A5mM4=
X-Google-Smtp-Source: ADFU+vtMN7JI89YF47oCW3XyHKerQ1/DIAQrV/dBe6k3rQ6PAmnfp9ezE6vFB4jsvfLjt0whq3Nt5Q==
X-Received: by 2002:ab0:3496:: with SMTP id c22mr537511uar.134.1582841246696;
        Thu, 27 Feb 2020 14:07:26 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id c21sm1807389uaq.12.2020.02.27.14.07.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 14:07:26 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id o42so246748uad.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 14:07:25 -0800 (PST)
X-Received: by 2002:ab0:6605:: with SMTP id r5mr531711uam.0.1582841245045;
 Thu, 27 Feb 2020 14:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-5-linux@roeck-us.net>
In-Reply-To: <20200226210414.28133-5-linux@roeck-us.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 27 Feb 2020 14:07:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VZYOV-uNwPB3zBpfdWV6U0qFeC1HTqwEWR1+x962J3mA@mail.gmail.com>
Message-ID: <CAD=FV=VZYOV-uNwPB3zBpfdWV6U0qFeC1HTqwEWR1+x962J3mA@mail.gmail.com>
Subject: Re: [RFT PATCH 4/4] usb: dwc2: Make "trimming xfer length" a debug message
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 26, 2020 at 1:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With some USB network adapters, such as DM96xx, the following message
> is seen for each maximum size receive packet.
>
> dwc2 ff540000.usb: dwc2_update_urb_state(): trimming xfer length
>
> This happens because the packet size requested by the driver is 1522
> bytes, wMaxPacketSize is 64, the dwc2 driver configures the chip to
> receive 24*64 = 1536 bytes, and the chip does indeed send more than
> 1522 bytes of data. Since the event does not indicate an error condition,
> the message is just noise. Demote it to debug level.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/dwc2/hcd_intr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Suggest a "Fixes" or "Cc: stable" tag.  This one isn't as important as
the others, but presumably you'll start hitting it a lot more now
(whereas previously we'd just crash).

Reviewed-by: Douglas Anderson <dianders@chromium.org>
