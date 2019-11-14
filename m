Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7CAFA724
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 04:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKMDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 22:21:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43834 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKMDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:21:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so364395oti.10;
        Tue, 12 Nov 2019 19:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QpBUJUS8nB4IDY7y0R8hl+FBwjsKsbh1meROaFZGKCA=;
        b=chyhUbXKjcRxglvGQna+GzDte6+bmo+AF2kIsbN8kiiT3zUxiD57qSYUMgEFoLqti/
         sjoKZOvh/UsToA4TImJ/rRcdvk3Zu7+lJfq3pD/V+yi7diauwB0ARrI4lDeps3Ocd9Zw
         07yNpgIFtObclfpJDWEH01p1+3Z6dKafsMLYYo7Q9GncFV+/iKRZ6P9YeR9SG56+h96x
         5LM7CqviYRHYlPRfy3snFcXRxj8V83jl0/iWo7NGbapYAeYETo65UNQo/tGzVcnxGYNO
         9hyVJ/yylkH8wgQLJmM/C+jdfLzA+cEvWRWphz0gjN5YePdjULP5TU4ybdDsXPzUIUVh
         2NVQ==
X-Gm-Message-State: APjAAAXhT9nub3S2RTQ+TPhaJwQAgylVZNjwxBPXWQV85FqCfB0aFXR6
        4RKUTbH8OjJlTSEWQRn4yg==
X-Google-Smtp-Source: APXvYqyIhAzYFJf8OJsXhu0w7bmN1x1bCUxobjWzSrdsBkKU/1LNHR6qZiA9P7CKjaVhd6fX8bGcXA==
X-Received: by 2002:a05:6830:4a1:: with SMTP id l1mr715933otd.291.1573615280360;
        Tue, 12 Nov 2019 19:21:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f83sm257863oia.43.2019.11.12.19.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 19:21:19 -0800 (PST)
Date:   Tue, 12 Nov 2019 21:21:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: gpu: mali-midgard: Add Realtek RTD1295
Message-ID: <20191113032118.GA22026@bogus>
References: <20191104013932.22505-1-afaerber@suse.de>
 <20191104013932.22505-3-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104013932.22505-3-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 02:39:27 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define a compatible string for Realtek RTD1295 SoC family.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
