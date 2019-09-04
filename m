Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41EA7CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfIDHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 03:46:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38298 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfIDHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:46:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so2368037wme.3;
        Wed, 04 Sep 2019 00:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALQJDHabIHIRVccnskz3EGkXYFFUSK5Bj/L/t8kK1RY=;
        b=jmAXbqRh8aAZTEPJ4YqjRbQvcgIhoc67V9Y8KIpE+ugbtQtXtS/6ZPzecA5S0oKCbg
         Q3n7D8gWrEtVYBvpL/fIGuDEADOI63DJfmWStYcp2+UWwK91rETmRHGh54Cr/yhymEOt
         FWguz/ETf2zt0hveZ0glw3KtKkKCLStIlvszy8brliU4nKGDEQH8F8c7XRVxXkUDd+i0
         f8mHaguh7+vncvEWmHg1iD2bqjm7VADXHNsUP00/vDpq2FIzBIKM5RUyjGTxkm0LVTVT
         vXaz8Q/Qv0VSSQgPLzMXE/kehY/sVDq6WRyaaSd6EgES1LXW0n6zEJ7zK4IKQ+u/KHUF
         HwaQ==
X-Gm-Message-State: APjAAAXjopGUIs72oqzxFPvXA7SVbvZuNEdG56jTAb27GE+yTZ2vLMR0
        U/U2rtYj8u6KyTqqgHzyXeyakqp48eHt9peQXBiAqhgW
X-Google-Smtp-Source: APXvYqzrei7rUgXpBmUZ0+Wydv6tghQcHo02w8csqHAigBwWnK5qkd5y5qX2Pt0XShEryT9Xgb+Ny0I/xcdxP4uJk7g=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2836990wmg.159.1567583208315;
 Wed, 04 Sep 2019 00:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <16EA1F625E922C43B00B9D82250220500871C7D7@APYOKXMS108.ap.sony.com>
In-Reply-To: <16EA1F625E922C43B00B9D82250220500871C7D7@APYOKXMS108.ap.sony.com>
From:   Felipe Balbi <balbi@kernel.org>
Date:   Wed, 4 Sep 2019 10:46:37 +0300
Message-ID: <CAH8TKc_XBksJHTue18O7jv7h0WjFSqQkJJ8Hc2aRNZaL3aRfVQ@mail.gmail.com>
Subject: Re: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
To:     Jacky.Cao@sony.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Kento.A.Kobayashi@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 4, 2019 at 9:47 AM <Jacky.Cao@sony.com> wrote:
>
> The power budget for SuperSpeed mode should be 900 mA
>
> according to USB3.0 specification, so set the power
>
> budget to 900 mA for dummy_start_ss which is only used
>
> for SuperSpeed mode.
>
>
>
> If the max power consumption of SuperSpeed device is
>
> larger than 500 mA, insufficient available bus power
>
> error happens in usb_choose_configuration function
>
> when the device connects to dummy hcd.
>
>
>
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>

You must send plain/text emails. I'm not receiving this via the
mailing list. Please, fix your
email client or use git send-email

-- 
balbi
