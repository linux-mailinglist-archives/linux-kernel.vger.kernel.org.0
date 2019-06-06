Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 809D837A28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfFFQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 12:54:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39749 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfFFQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:54:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so1864358pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uP+0RK/olOLeLANX1udo5x/E16Z31PJSvZb1HggqSws=;
        b=N63CQleFfxxkHFbTvUxXAUj00SNojMJgEc+8bCzpWUz1SMMaeJKUxegJaRKSTsMDGD
         1dXL8l79JGZivWqLKJiapBgjCIILm1saH34vLs86d0CTrZQtYOHd6/VsvTF4VTF33DxE
         5fAuWLUp0CA31TSfKw1iDCioDpxjx75VLgGB1fA73diiIFdwTIXaIcn330n7y7owgAXi
         ljqZsxObVnsQT+OOpjXyaIV8X0gLvZ20AV6HnZZxfVZiGZmBbfD3tTQto+WJYNzcO6r1
         Dkvo1fjPrA0HVKT0OyHi1NhWbKG11qmOtQBEYhkXv3pC+TbRtof1/eAeSVruo5LY+hhv
         1dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uP+0RK/olOLeLANX1udo5x/E16Z31PJSvZb1HggqSws=;
        b=BbCOnuV+daX0cTtSoHgjPNevhE+MDjh1oqHXkWTqyq2ki1jSCyApWtT49RP1Wz0W9s
         3hXrcc4i93M9sOFcDLhVugHQnt87IZgQAAgLtEvth3HjqLy643KpTeU3kjNQiedjRb1m
         OoIYiH/koF8bg0IsYjgi7KH6fAld7x8Efrj/ociNy3czDHW9bQoJ2aBUHBk7Fppk/TjO
         xw5aYEgld9JnslmsprvEJeiVnmlsw8/IDXnBRPoCNwTLWaNQHSH1lRwDrffNV0zsjQcW
         03UkTAhjcp5vj2dNEkAxeTlQeAIMxAsLqGwfDTqsuR7gGKFUeEaRDB+R7pubGs65vKCM
         dcoQ==
X-Gm-Message-State: APjAAAXtjgpceSAe67A+9UWP5fOef4xvgqi/AbrD3OpYk3m3aDEaQ1rw
        AgXV174HeqjhEU5oczQqSWeXvQ==
X-Google-Smtp-Source: APXvYqz6c0pC8u38g28qlOAS2XbmDD8MZ971NxMGdinizUMqohDxRr61H7/m/o7Wl3Ba2JWsSM4ODg==
X-Received: by 2002:a62:2643:: with SMTP id m64mr52532743pfm.46.1559840046284;
        Thu, 06 Jun 2019 09:54:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 132sm4535503pfz.83.2019.06.06.09.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:54:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/meson: Add zpos immutable property to planes
In-Reply-To: <20190429075247.7946-1-narmstrong@baylibre.com>
References: <20190429075247.7946-1-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 09:54:04 -0700
Message-ID: <7h8suefydv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add immutable zpos property to primary and overlay planes to specify
> the current fixed zpos position.
>
> Fixes: f9a2348196d1 ("drm/meson: Support Overlay plane for video rendering")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
