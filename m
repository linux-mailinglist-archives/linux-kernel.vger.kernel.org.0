Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200AFA9777
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfIEACd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 20:02:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42579 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfIEACd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:02:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id w22so463243pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DMDiIQY2gVxor/9tfnSEdI8BwtB46XK7pBIB2yMTLBc=;
        b=o+xsl4lmBHGpnDImWPM+EZHQW8VVGoHi4Ms8RXruJR+FJ/vQ2e61uWD0J7ERaS4FKZ
         +LAbashurqA9qoUt55zN6vY+z7XjB8j669RaxOBPkjDMFkhUw5Poq2OE6Eoqg3rZlcOh
         67ctW4j73di+6QPuk1BgvRwvdlGOu6oA8PbE25+4TAGv2lc9R2PHjI8jYFUiPz7MEAUV
         OKa+0uv2hM12FZCfoKnuFYzUIetiBzEE+AzlYURObnb1YYQdc9k9Yy8Detsp39urQD/p
         DPPx4eT88OOb8OUMhLUvN1ABBLq3fIbijVX0O+hVzuABVav6duYiI/e8gcjoJmLsJWMr
         /pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DMDiIQY2gVxor/9tfnSEdI8BwtB46XK7pBIB2yMTLBc=;
        b=Upy0DH/ASCeqlY4brFvBXiiEDUAyFZxcOuJUsoMbR8MZEZ3qhOUG5ndrGMt7Om/17I
         8izCCl1NNVi1oc8It+8YAqWZS1qs6SNuj3adTeDjUqK5/6QFv1gd7VhtjzphRuGphwid
         OWEWrIsHCD10469bM7roEGIOaUfYu55Bs8ZoKW4wE16r8x26I1JekC5MuiTFByKb6xzv
         BOUNO60eJS2oeBvqNqSsr3Ij4Oyi/KmbHupVhkrTc7Dn/ovHA1oF7BvQ+n5ZQirc9tY2
         PypmrswgUxdfDE9bkHMeQAD4OWEZ4DH8kMyxPxiHMo2WnvEV6iPjt2uPP+zEIbIZhdQP
         vm/Q==
X-Gm-Message-State: APjAAAVVUvSlkx4a0UaTMQbH7u3yH+4Hq0J8Ax3EsulWnfLII28azDt4
        MOmp+aWTQho8TxKcFYUjOdnHiQ==
X-Google-Smtp-Source: APXvYqzc0wRcdryTLKgsgoGOwLmF9g/litQYYjhoz0VIQFDDUflUHMSdrzjEFyAFp2XzF5NH1fDC5A==
X-Received: by 2002:a63:553:: with SMTP id 80mr665691pgf.280.1567641752363;
        Wed, 04 Sep 2019 17:02:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g24sm192291pfo.178.2019.09.04.17.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 17:02:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>,
        Elie Roudninski <xademax@gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
In-Reply-To: <20190901105410.23567-1-repk@triplefau.lt>
References: <20190901105410.23567-1-repk@triplefau.lt>
Date:   Wed, 04 Sep 2019 17:02:30 -0700
Message-ID: <7h8sr3txt5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remi Pommarel <repk@triplefau.lt> writes:

> meson_saradc's irq handler uses priv->regmap so make sure that it is
> allocated before the irq get enabled.
>
> This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> managed resources are freed in the inverted order they had been
> allocated, priv->regmap was freed before the spurious fake irq that
> CONFIG_DEBUG_SHIRQ adds called the handler.
>
> Reported-by: Elie Roudninski <xademax@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
