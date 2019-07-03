Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF355EDB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGCUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:36:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44774 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCUgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:36:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so1814097pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfHYB+lTiI64lxTRcrT8/UH1l7TT30GDFo4j4mMP0os=;
        b=lzqeBcEuokgv9F+An1HdqVa1FTlpZRSoxJVcua0QQjegnNqpBg13lqdi5uQD9G4S1A
         zzo2oYALjBRFRF6PsnkhuJjeEtqUHtc4uzNZKKitT/lsjVFmiwZrCIepl+bIri9ldgo/
         kOhgUwfQa1yH/168NopNHSZYBWEp/1YkmWVUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfHYB+lTiI64lxTRcrT8/UH1l7TT30GDFo4j4mMP0os=;
        b=fWCU9DGGaT8mFQ4ulRwBwl9BGT5NbHwoV2HiH/5QrLYndCQYFOOQ/5c2riqx1QUl2O
         ZrMbQfzRttLt6VEEbEODX0QMsvYZfBQ2IeX9OQ5ojF/j+dmQv/z5j/8HEoraVHTUmyaJ
         Do1onQflt5rYCcYv/iIr8ezk6zq5b7NrnE0x34GAInUQ45VdFbtZNSm+uRPJo2FSoTxU
         YeLPxctxr4vMLsq+vwPvFq3QKkS/y1w+ZmJIpUczi52rwtrqZeBlmtXXFn2kJYP95SdY
         sSRaXXvzIaqyUf6UIATLstVriC+pOC2fNUuSVBN3kU2gua4+DMrmNe96MbEHxk1D4t+U
         tSqw==
X-Gm-Message-State: APjAAAXGFrHu8X/y0kOqaMbrVDc2AuUSKyxmVlkuYcwHenLGP/xMtMWH
        8gShT8/gwm4SHfYmlAtcUUMFtw==
X-Google-Smtp-Source: APXvYqzQxQSIwg820yjADqUQOcipDJH4aw/rukCrBqhLYubTwlnkIxMpQhcr9BOdFoKBZowj+r6xTQ==
X-Received: by 2002:a63:f817:: with SMTP id n23mr39418076pgh.35.1562186212565;
        Wed, 03 Jul 2019 13:36:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u7sm3080371pgr.94.2019.07.03.13.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:36:51 -0700 (PDT)
Date:   Wed, 3 Jul 2019 13:36:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 4/7] net: phy: realtek: Enable accessing RTL8211E
 extension pages
Message-ID: <20190703203650.GF250418@google.com>
References: <20190703193724.246854-1-mka@chromium.org>
 <20190703193724.246854-4-mka@chromium.org>
 <dd7a569b-41e4-5925-88fc-227e69c82f67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7a569b-41e4-5925-88fc-227e69c82f67@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:12:12PM +0200, Heiner Kallweit wrote:
> On 03.07.2019 21:37, Matthias Kaehlcke wrote:
> > The RTL8211E has extension pages, which can be accessed after
> > selecting a page through a custom method. Add a function to
> > modify bits in a register of an extension page and a helper for
> > selecting an ext page.
> > 
> > rtl8211e_modify_ext_paged() is inspired by its counterpart
> > phy_modify_paged().
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - assign .read/write_page handlers for RTL8211E
> 
> Maybe this was planned, but it's not part of the patch.

Oops, it was definitely there when I tested ... I guess this got
somehow lost when changing the patch order and resolving minor
conflicts, seems like I only build tested after that :/

> > - use phy_select_page() and phy_restore_page(), get rid of
> >   rtl8211e_restore_page()
> > - s/rtl821e_select_ext_page/rtl8211e_select_ext_page/
> > - updated commit message
> > ---
> >  drivers/net/phy/realtek.c | 42 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index eb815cbe1e72..9cd6241e2a6d 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -27,6 +27,9 @@
> >  #define RTL821x_EXT_PAGE_SELECT			0x1e
> >  #define RTL821x_PAGE_SELECT			0x1f
> >  
> > +#define RTL8211E_EXT_PAGE			7
> > +#define RTL8211E_EPAGSR				0x1e
> > +
> >  /* RTL8211E page 5 */
> >  #define RTL8211E_EEE_LED_MODE1			0x05
> >  #define RTL8211E_EEE_LED_MODE2			0x06
> > @@ -58,6 +61,44 @@ static int rtl821x_write_page(struct phy_device *phydev, int page)
> >  	return __phy_write(phydev, RTL821x_PAGE_SELECT, page);
> >  }
> >  
> > +static int rtl8211e_select_ext_page(struct phy_device *phydev, int page)
> > +{
> > +	int ret, oldpage;
> > +
> > +	oldpage = phy_select_page(phydev, RTL8211E_EXT_PAGE);
> > +	if (oldpage < 0)
> > +		return oldpage;
> > +
> > +	ret = __phy_write(phydev, RTL8211E_EPAGSR, page);
> > +	if (ret)
> > +		return phy_restore_page(phydev, page, ret);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused rtl8211e_modify_ext_paged(struct phy_device *phydev,
> > +				    int page, u32 regnum, u16 mask, u16 set)
> 
> This __maybe_unused isn't too nice as you use the function in a subsequent patch.

It's needed to avoid a compiler warning (unless we don't care about
that for an interim version), the attribute is removed again in the
next patch.
