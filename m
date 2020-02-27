Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48D172B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 23:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgB0Wm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 17:42:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgB0Wm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:42:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so432595pgn.5;
        Thu, 27 Feb 2020 14:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eC6XULGo71DkkbKYMEVa3CebZbR3YIk7hU1LZdfvH4Y=;
        b=qn+7NLiaVpezukxBzFBwfG+epP+sfl+YlsORRJxCCoojrQj/h+YkBxM3i6YDE0AQJs
         P7T7DFMTB9R1RXIaeliDZ/dyWhM6CuLv2kO/sytHwO7bES5aZttcq2BrppClH47OLbih
         8glkk1PmO0wSymairAZIAQPbdboYTf0jc9+6madbyvW0p84zWN/JxZ4udBJCDn6mRfqt
         jd9n5MmIClzXAQ9CHp/v1tEiTBrPm4tZ7i/cyZuEmoDelTi8Iz9b5FAUMOXDPMbqEEX7
         ODi3nQW4+kEH1AhkrhqS4TXIZWBBmPcmnkuQblEIuHdpsioRqGi/GZZCFJdDdpOtidJT
         pm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eC6XULGo71DkkbKYMEVa3CebZbR3YIk7hU1LZdfvH4Y=;
        b=b7aYEwX4WDGDY/hP/9piEacxS6zPH951CkLkqdCdqtPjMLF8Z/sveErZQhDiyN4Pu0
         GntDIpl8+knW/fE40Iy3xPMU/AIW+tCQoVmHhd25uEDmKU5OCsqSid7K4fGPKGkihjxq
         3IYN98my5W8Lqx3x0/qbgDfHR8eLkN5mOXw1wJFHop7D2lAyTTxAyjlbsIJgjr/qTFw/
         M3736BGPUiPs13Zf+Me7Rpe0WLRe+JLJl6N8ZDxOhVQ+EJdrEhHpe2ydHoMaBgdxw4Xy
         kL/KwmX8xna482aQSXVtq9Ndl/eBeaelG+6XjSSxqZ9sYLDsKNy3zYRwkgDzbrR4XZ/j
         wDpw==
X-Gm-Message-State: APjAAAUpMUgUFs7Nd8vQej6EzztBlsZWpkMk4gm3FB7//9jSJhYCDA2Y
        kY2c8FlYcsYmjMxQUTs9OCk=
X-Google-Smtp-Source: APXvYqzGTM6O1kzlusq2+UBm7XJw4SAY63lpqMM/UumlDNsXPcBi96eO1OrkgnLHxCGovebuWsNzJg==
X-Received: by 2002:a63:990a:: with SMTP id d10mr1562744pge.63.1582843374849;
        Thu, 27 Feb 2020 14:42:54 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id a22sm8278610pfk.108.2020.02.27.14.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 14:42:54 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:42:51 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH v4 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
Message-ID: <20200227224250.GC29420@taoren-ubuntu-R90MNF91>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-8-rentao.bupt@gmail.com>
 <20200227165504.GA26955@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227165504.GA26955@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Feb 27, 2020 at 10:55:04AM -0600, Rob Herring wrote:
> On Wed, 26 Feb 2020 15:03:46 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Add device tree binding documentation for aspeed usb-vhub driver.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  No change in v2/v3/v4:
> >    - the patch is added to the patch series since v4.
> > 
> >  .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-downstream-ports' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/aspeed,usb-vhub.example.dt.yaml: usb-vhub@1e6a0000: 'aspeed,vhub-generic-endpoints' is a required property
> 
> See https://patchwork.ozlabs.org/patch/1245388
> Please check and re-submit.

I ran "make dt_binding_check" in my local environment and don't see the
failures. The 2 properties are introduced in this patch set and I add
the properties in aspeed-g4/5/6 dtsi files (patch #4, #5 and #6): am I
missing something?

Sorry I forgot to add you when including the dt-binding document to the
series v4: will add you and all dt binding maintainers in v5 soon.


Cheers,

Tao
