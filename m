Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9B199F91
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgCaT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:58:53 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43238 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgCaT6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:58:53 -0400
Received: by mail-il1-f196.google.com with SMTP id g15so20700188ilj.10;
        Tue, 31 Mar 2020 12:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pkZ0aQadXW+UarG3V6yDDnoy3MjYoP4UMbK1exK/Agk=;
        b=md6mTqVDtTFOQI+0VVn0j3O31NrxmgqvIox8zZdsO0PBeM5FtMZvoLbAgkJwsKmeDn
         dGUCPUCu7ZvTeE7DUYKQ3vHXoDk2x218fDO9+qiRFlxxl+v0wADf2OXzxfasId+9Kuxb
         SS1kpxARX9tpbkBSR/jNHziVYvVPp6pvCmBYvOz5axQPCJaGDS+Fxruhow3HXqej6CJy
         hDDiraa4u8MzzdrwpBVxbh2ZbDL6CbwAMFerxmXs/ogsu4jIQJKWD0aXA5/oYkTgFYvS
         9C7DrI/KaiMDA1fz4q/DH2lU/gtJL+yjBwrpPtgKKSRoZm2tbzf0bsM1W1EjyxbHxHgz
         KJfQ==
X-Gm-Message-State: ANhLgQ102DAF3BZYW1R5pzA3RPn85nTOGZBkB3BneblKCcUpNaZhee/o
        XJGqk8WNDFqKby1C2CdCbb7KnJKxdA==
X-Google-Smtp-Source: ADFU+vsmNeRowX49DLQnGgdAShsW+1YjICc0B8+q1P0/NHtVfbMIgSjjmQj+1JoZ0y7gtYkwNtlb2w==
X-Received: by 2002:a05:6e02:54e:: with SMTP id i14mr19034209ils.166.1585684732061;
        Tue, 31 Mar 2020 12:58:52 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i3sm5108021iow.11.2020.03.31.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:58:51 -0700 (PDT)
Received: (nullmailer pid 2448 invoked by uid 1000);
        Tue, 31 Mar 2020 19:58:50 -0000
Date:   Tue, 31 Mar 2020 13:58:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 13/13] dt-bindings: usb: amlogic,dwc3: remove old DWC3
 wrapper
Message-ID: <20200331195850.GA2337@bogus>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <20200324102030.31000-14-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324102030.31000-14-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 11:20:30 +0100, Neil Armstrong wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> There is now an updated bindings for these SoCs making the old
> compatible obsolete.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  | 42 -------------------
>  1 file changed, 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
> 

Acked-by: Rob Herring <robh@kernel.org>
