Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230A112AFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 00:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfLZX2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 18:28:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35478 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:28:33 -0500
Received: by mail-io1-f66.google.com with SMTP id v18so24442491iol.2;
        Thu, 26 Dec 2019 15:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9UdJ2EHCBfkgfAjYdg3N8nSpHkPs/odiwnqsSsf3dg=;
        b=IR1xiXm03mGYQP1A57mKeXDq8PpZf6rQ74VhMT6wHpWeKL650gNYkYeeTkG2qEypdP
         6KMVfmmLRow3tARj2tWTMydLrMj0FTq+MOvqeTpd00n2odd53I9/sY42hDhnY35Je1ee
         r5qxTz1sjJP84FPlx/Uo7PGPC8L93ajK47DLV4qt79GbcKMPLnX/KZ0p2flwwDDeBlJ6
         3l9NCOjYBJ2Ku3KS1dhMyJ+QMlg1Oy6biaKS+l7OJMX6aQMyz4+vsWK7ptUr8hAgHMrr
         e5WWLK9oEuf6e3UOpjpjNSLQ8Pzl5nLvBnUtDawAyN9pjfRTuhJhA2GbPoFGaWvfMHRK
         wesw==
X-Gm-Message-State: APjAAAXixT/uFXe8XxFMP2cBuvTrAVZpip6KNJj7gYMVD3zDPyxc4dIS
        WJYNmW+G4zwL3hDOVqkotA==
X-Google-Smtp-Source: APXvYqzCdBBCz4heOHZ1/P78xQ3mabWQ4T11IcgNKpy4cZMKFSpw5EpztaTxRlx7ILKDEPxJChsm6w==
X-Received: by 2002:a6b:7201:: with SMTP id n1mr29057420ioc.37.1577402912865;
        Thu, 26 Dec 2019 15:28:32 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a7sm8946258iod.61.2019.12.26.15.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:28:32 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:28:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, maxime@cerno.tech, sam@ravnborg.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH v4 2/3] dt-bindings: display: panel: Add binding document
 for  Leadtek LTK500HD1829
Message-ID: <20191226232831.GA7084@bogus>
References: <20191224112641.30647-1-heiko@sntech.de>
 <20191224112641.30647-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224112641.30647-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 12:26:40 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The LTK500HD1829 is a 5.0" 720x1280 DSI display.
> 
> changes in v2:
> - fix id (Maxime)
> - drop port (Maxime)
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../display/panel/leadtek,ltk500hd1829.yaml   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
