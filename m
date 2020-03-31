Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD96199FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgCaUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:01:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33550 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgCaUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:01:32 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so23123317iof.0;
        Tue, 31 Mar 2020 13:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkxxip8s1ZW0GnbenbnFeoJyggUhdVdybES6+NRkTls=;
        b=VMWUWHT2WLebfuFIJxAG0k6OCkisqUYZSv2x5+Vck+QDmHn4EdnYKpbieNPbls/vh8
         kA23iobISUi2hZMj+P1nbo20UT99dWIa1KlRaN/DJB0J7icg0TBcBnfm2T/froCxUhcY
         i6LmSxQuxdrrH18eOpuTMP7XOpxpU+kYRUhcwKQ4oHiGE0PslrfYeUZPw+QowtNEsStf
         B5Lq1L2/9LT5EqqOUboxeOfDDUqxF7/2wOctrrDwvkN1RXHY4mPJoXyKBKcU1NS/IP9E
         ECDxQSAke3CSYlPRAHQlS6EzctBZhWCh0UFjdfKBlPtYx1RqWvJ+FeB8Pa+4iVcR+Ob+
         Lz/g==
X-Gm-Message-State: ANhLgQ3Me4s42Qz3tvzAEfJKVDHvt1nezj7ZxgfDFyJ8GWJTANfuqOou
        /5APX5xIN6hidX+MGA3WAg==
X-Google-Smtp-Source: ADFU+vvBejlhKFx9aVEK9Es2UC6IoLSf1k2SdAYxRxDFr5MBW3pEn/d1O633AZt6lRcbhYJICsvimw==
X-Received: by 2002:a02:2505:: with SMTP id g5mr15167286jag.114.1585684891883;
        Tue, 31 Mar 2020 13:01:31 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h29sm6197193ili.19.2020.03.31.13.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:01:30 -0700 (PDT)
Received: (nullmailer pid 6517 invoked by uid 1000);
        Tue, 31 Mar 2020 20:01:29 -0000
Date:   Tue, 31 Mar 2020 14:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: sound: rockchip-spdif: add
 #sound-dai-cells property
Message-ID: <20200331200129.GA6458@bogus>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324123155.11858-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324123155.11858-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 13:31:54 +0100, Johan Jonker wrote:
> '#sound-dai-cells' is required to properly interpret
> the list of DAI specified in the 'sound-dai' property,
> so add them to 'rockchip-spdif.yaml'
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
