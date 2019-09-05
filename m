Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171B8AAD37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 22:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbfIEUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 16:40:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41933 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbfIEUkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:40:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so1925197pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VpJQlHdzOL058GU4wP50cEjksEXzOUX3pb5wvWLJu64=;
        b=Gey3+CNrdw64IW7vegKv4QWSElXeflb3/Gxy6dQ2wD/aUu5pkiNOpTrKaCmRUsOMSy
         zUTs/UyK7dICk5MzNYx5SWhQYTmIZ8CGeYZNwFv5FytESHKQucDLj12213hLkrRiA3h0
         ZW9R8hEaNJzR+xxm0cVuXW+OxS+SEHN3+KPDdandS5SRTgiO5VNlTu1Ano4df2zNrEMd
         DjA2BWRrdgJOoQjA61B4zk0ntC2jme7mMIdmWVUpW/u9JS2Dps+6Uq7BT0kaAOvlJGxi
         Hi4xiO33WQEvM9fSPVzsTXSMhtoegaqTVyCWvY2ocYACd2ZMXC0DDzsX74dttYU01bXd
         M+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VpJQlHdzOL058GU4wP50cEjksEXzOUX3pb5wvWLJu64=;
        b=uQ90lPdoRpi0+aBGTnbIZJiTAr1rRamaxYqTUBKNEk4f/s725Cc0B+0jPPKH8vt66C
         aALqnmrOqDO49vRDXYAOeyO9QFJPlpSfjGa/WssncbKQ/laBjgOzCFrb7z/1DQPSjLWp
         usrFf4BBNHBgvt/IqsntvKjeYimhNVJSuhrgFocnd/mRTXpH7LyYrijCVW9OqXXjmoGB
         TEFmejCitpInMMk/s5VjxzHu97xj9FZNiiS8Fwo4XYbXt25C9eZrq4y9Jfk0IXSXEfhM
         k1Uwt7xyU9ocW44iyArE16o/yig8ek0OPSBQU2eWTb5/LG45NlLtGU/B2rp4DoKgyUgg
         dxCQ==
X-Gm-Message-State: APjAAAU00WADNw6oPQfkQpMWQ25U3/MJMvSHoevtRfwnfBs+Tk2kHf+g
        2mOCn4iabEmYpswTI4BS/ZUcbw==
X-Google-Smtp-Source: APXvYqyAQ4j/FUjC8TaAxYwTxb/knA75vtgilVu+e635/0e4hiV75mi8XILgeD8bJPqHj3zWdWW4jw==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr5615924plk.173.1567716010812;
        Thu, 05 Sep 2019 13:40:10 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m4sm4706664pgs.71.2019.09.05.13.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 13:40:10 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: sm1: set gpio interrupt controller compatible
In-Reply-To: <20190902160334.14321-1-jbrunet@baylibre.com>
References: <20190902160334.14321-1-jbrunet@baylibre.com>
Date:   Thu, 05 Sep 2019 13:40:09 -0700
Message-ID: <7hpnkeqxxy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Set the appropriate gpio interrupt controller compatible for the
> sm1 SoC family. This newer version of the controller can now
> trig irq on both edge of the input signal
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued.

I may do a late round for the dev cycle of v5.4, otherwise this will go
for v5.5.  If it goes for v5.5, it should probably have a Fixes tag, no?

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 521573f3a5ba..6152e928aef2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -134,6 +134,11 @@
>  	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
>  };
>  
> +&gpio_intc {
> +	compatible = "amlogic,meson-sm1-gpio-intc",
> +		     "amlogic,meson-gpio-intc";
> +};
> +
>  &pwrc {
>  	compatible = "amlogic,meson-sm1-pwrc";
>  };
> -- 
> 2.21.0
