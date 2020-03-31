Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE92C199FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgCaUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:02:00 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39936 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgCaUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:02:00 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so20777268ilr.7;
        Tue, 31 Mar 2020 13:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=inn69R6pXVv7tn5IiOj3WCmHSXEzB0bu6RYjdj4+w9I=;
        b=S1qySzMqNWRdHOSgAUeob7svajg6gGZ6j+OoPoi4XpIMqGThswddLgpztcRnEmhDaf
         OjnDmwc9TUq4jFvxpfJdfCg1icJ0dUS1jw7LqqbmbdA1E+xCCONJGDDrzXr6nexTcmdv
         eNQiY+sdh3rkc7sVch2GsN/dSOcV3dJp8dtemVVTtECK9kfeL6e+p+LAJVtd+dMS00+B
         VkTYhwmg+AJmXzPz7T01SoK4izTQfjDZPgisOd2ALop013toRXycHVcpDSJobdQG6seZ
         QLS6snJ9VLpAo+5Q9WDfjE7ZU5xNt9Hu+UohrFw9hLsBuKhyagrx/zUQ5wq78WCKZlCB
         cH+A==
X-Gm-Message-State: ANhLgQ2TqTKR0QjuMox3FCCtdPpwUwVNS7Zpenj6bizhfglq5DUi2bAC
        sGsTOUUSO54GfoJQXHdk6w==
X-Google-Smtp-Source: ADFU+vsICc4DhBvaBEO5MjNBpVjmJPABPfazkSQ87pqZhrYedeNGTExxSKz2gZT+RvOxqRGZ9E7szA==
X-Received: by 2002:a92:9c54:: with SMTP id h81mr18455056ili.109.1585684919454;
        Tue, 31 Mar 2020 13:01:59 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r29sm6263789ilk.76.2020.03.31.13.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:01:58 -0700 (PDT)
Received: (nullmailer pid 7245 invoked by uid 1000);
        Tue, 31 Mar 2020 20:01:56 -0000
Date:   Tue, 31 Mar 2020 14:01:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: sound: rockchip-spdif: add
 power-domains property
Message-ID: <20200331200156.GA7186@bogus>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324123155.11858-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324123155.11858-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 13:31:55 +0100, Johan Jonker wrote:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'power-domains' for rk3399,
> so add it to 'rockchip-spdif.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
