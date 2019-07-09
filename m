Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF5963E02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 00:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGIWuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 18:50:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43711 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:50:14 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so483659ios.10;
        Tue, 09 Jul 2019 15:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nvvoh+fbNkBLPpXy4Y6lZA9c7jtYP7QeOvjrEV4cBIw=;
        b=E152u+zQeaNBnPpxaN3G5IWMXpMaQpMLd010lSDCikFET9slcst5Zoxa/lUtl6ccxh
         pCEkqrRhpo6lxIQ2t7QS9oYJOilukZoKbVGiY1XoxEii4ojKe3XXo4+cE/1YM/vONEXk
         WcZmw46W/E5aNdxj7INMJD44+keaTIvS/N9HN76TzIe/2kTzT130wKpj8cBHgQGEWbkn
         lgR3oyfB+BpgqQl48gqzoVvM+xhqrYrffFRGJ9ttkaQCKu17Ye18ElrvQ4uBpNJRZLT3
         x53tLU9jkKia5vBRM4blxKfuA7Z3EH2xG/YamXI5vndFkX681kAbKCY0hn8nKlOPyaqO
         7dAA==
X-Gm-Message-State: APjAAAVPphKBeq8WKNo9RwBx3rPAy3EWUqVGQb7fVk47V/nPEC/PgX0X
        AJdunqHYy0GG84RO6ObSNQ==
X-Google-Smtp-Source: APXvYqyIRybL0nbRMpxsdXhfMWV2kUc5p622WEvGhc+cnLHFcA7qWZGwS/KW4h4GpNKPh1jLWlazuQ==
X-Received: by 2002:a05:6602:144:: with SMTP id v4mr27703160iot.202.1562712612914;
        Tue, 09 Jul 2019 15:50:12 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i4sm292005iog.31.2019.07.09.15.50.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:50:12 -0700 (PDT)
Date:   Tue, 9 Jul 2019 16:50:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: rockchip: document VOP
 gamma LUT address
Message-ID: <20190709225011.GA11245@bogus>
References: <20190621211346.1324-1-ezequiel@collabora.com>
 <20190621211346.1324-2-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621211346.1324-2-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 18:13:44 -0300, Ezequiel Garcia wrote:
> Add the register specifier description for an
> optional gamma LUT address.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
> * Drop reg-names, suggested by Doug.
> ---
>  .../devicetree/bindings/display/rockchip/rockchip-vop.txt   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
