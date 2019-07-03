Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C85EDC3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfGCUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:43:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33950 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfGCUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:43:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so1858014plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x4TV9OuGMH2IFAWRzYFxjVpyDgSmZpX4HKATzy9i5LE=;
        b=NqpSXt2ai4FWgYUhx9YUIQd8vWtb3B9ByuyfiMWY/XFkaiWfCj1FBGxkAwtk1xNHNN
         vgKEuCm1NC9cInuq+hL1kwDFHAL7pRfhG61zNFwnu36Z3oVL48mwQVXET+K0XU4M/2U4
         MxeCSPy7BE3iLKqtqYOwH2ulvCTGQgY8QrwSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4TV9OuGMH2IFAWRzYFxjVpyDgSmZpX4HKATzy9i5LE=;
        b=bIxVcNED/T5IXzqrvXIEzEO2SfkS+x+/B/D+1kBHrxE4/xyYRWm2ZSk2OB9yz7kcCI
         Lfc7ZXK6xGcbQ466MEnKqAK6j/psnmpg59v8UvymptMhn3FJGWNkB1/p7db3NGNisLSn
         mjT/0GsAapHeiPWoQaeJjyr7bBx6SLft1VCy95eWx5KputUxW6VyZFw/e1FBrX3aBCNE
         97GzMqwvBuLnwQwnKfpEhHseRkgv5L8Vt2eRw+CKL8sJn+ysYEl2qJIWsAk2x4COdJro
         Q0//uN35wXBNruAAYbbXYf7Y8s0RwWXXVcbfjde6a5ccWF06Dw3r59hHHrHnOTVs6y2e
         3MgA==
X-Gm-Message-State: APjAAAXzCYibXfvx0AcTxhllXUW0Kn0qF/x0ZZaNGXp4FZqp/00Nbi+U
        1W6R7Bze7taHzIDhqtG0+L5QjfzWNHY=
X-Google-Smtp-Source: APXvYqykgvMApITkPMMhHzregOurly8+6C4wq2UcUc1VFL1/AiRc7obmDF5E4wOp3JP2p5uh8rmkmw==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr43660872plp.71.1562186584828;
        Wed, 03 Jul 2019 13:43:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u7sm3086441pgr.94.2019.07.03.13.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 13:43:04 -0700 (PDT)
Date:   Wed, 3 Jul 2019 13:43:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 7/7] net: phy: realtek: configure RTL8211E LEDs
Message-ID: <20190703204302.GG250418@google.com>
References: <20190703193724.246854-1-mka@chromium.org>
 <20190703193724.246854-7-mka@chromium.org>
 <20190703201032.GG18473@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703201032.GG18473@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:10:32PM +0200, Andrew Lunn wrote:
> > +	for (i = 0; i < count; i++) {
> > +		u32 val;
> > +
> > +		of_property_read_u32_index(dev->of_node,
> > +					   "realtek,led-modes", i, &val);
> 
> Please validate the value, 0 - 7.

ok, will be 0-7 and 0x10000 - 0x10007 (w/ RTL8211E_LINK_ACTIVITY) though.

This is the somewhat quirky part about the property, each value
translates to two registers. This seemed to be the cleanest solution
from the bindings perspective, but I'm open to other suggestions.
