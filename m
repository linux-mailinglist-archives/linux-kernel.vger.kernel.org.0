Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE41254CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 22:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 16:36:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46528 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfLRVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:36:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id c22so4199607otj.13;
        Wed, 18 Dec 2019 13:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72VAfYuwXoJ1WVkCcjRKB4hbu6IUlbWCsYCwfnomH8c=;
        b=iG07TqtD0Zy6mDTqDwf9/d1v5E3gw/MEbruqrIxib1ijDvNRDX6JULocExJEQyKKvH
         VHZIUNin/jlX5L4EQFeSQKIN2Cx3fqdX1nPUaL149f01jHO3o29jZHJeW74yqLiU1ZkT
         uhcyX6erP0ZtK9gqxip0IgphDc2ytHhwtm7zDK4tGaM0UfInGW+ekQYoq5pETqTnK3e8
         aJZyEOs9avxr+O1PbT/FoNkNvYpiuD15N9KUa9Hp560d7+g/ph+Hl1ODg5XF2SW0ASxV
         mGEfNSLh/mDGhNNQDG7FbtckslhL5W3qYOm8dyy5MRKr2lMEfODHMcdaq5NgqXT9HmVK
         yPaQ==
X-Gm-Message-State: APjAAAVZdz/LW5kh5ldV0wthlZlNimkVOqbuBplOVsetfv2UuOi8dZBr
        h58SwmigTd7GNxpI7Fhpkg==
X-Google-Smtp-Source: APXvYqy7BIKZhbjHQz6b0xkP7HzpJe1AqV+DOsqDmUcyxYqd8NSDMqiKqNPha8X3aU1Lz45KQRfqzA==
X-Received: by 2002:a05:6830:1f95:: with SMTP id v21mr4939761otr.325.1576704974635;
        Wed, 18 Dec 2019 13:36:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p83sm1235400oia.51.2019.12.18.13.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:36:14 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:36:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        sam@ravnborg.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: display: panel: Add binding document
 for Xinpeng XPP055C272
Message-ID: <20191218213613.GA29058@bogus>
References: <20191217222906.19943-1-heiko@sntech.de>
 <20191217222906.19943-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217222906.19943-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 23:29:05 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The XPP055C272 is a 5.5" 720x1280 DSI display.
> 
> changes in v4:
> - fix id (Maxime)
> - drop port (Maxime)
> changes in v2:
> - add size info into binding title (Sam)
> - add more required properties (Sam)
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/xinpeng,xpp055c272.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
