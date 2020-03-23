Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A2018FDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 20:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCWTgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 15:36:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41672 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgCWTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:36:04 -0400
Received: by mail-io1-f68.google.com with SMTP id y24so15595270ioa.8;
        Mon, 23 Mar 2020 12:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mkiUpmYaWqeC/9fVOMmUolcEDs7SdX572qqK/WHG1k=;
        b=oAkdi37ji03RJPr2uhtM8MYLkprSdAmN0b2QZnZCQIQOmAJjt0MCES3/Dk/hCMRrcU
         47gRWDtdIXnpdUvsD8OqwSXRLyIL7ZyO9C5q40oUKNotZHJXrc5OOjpW2l1WvkO97QiP
         8b5ZpW5KFcShKWjOTVT5HhEjRt+iQNXnq1icJvpBMc5ywbC18/peP75D1x755ViIaBh9
         xMHH4OgsK4BVYPGeXPilDw9eW5PYdQoLySxP270n3tOSgtTSD3IzuIPIUlsxLFNK+xSX
         kE9UY2QgRazbA1jVFxv0+YEz9ksn9SEbfgQt0oAAATCXrmoqZWNReA7T8l90BqLjWond
         k/sw==
X-Gm-Message-State: ANhLgQ3tdWehCRM+HTm2uPdtVeQAMGXELrAXUTlyRWrtBF2DvYucRbS4
        tcjP9rHBQkhmm9ydiIHZAiMgd+o=
X-Google-Smtp-Source: ADFU+vtIcAv5y12f47+MkcXTNTAvWLJ98g9D7CVFcGDkK6sgqnjzg0FRX1r8Nvkvjh9Ami3EEIH0qg==
X-Received: by 2002:a5d:8d90:: with SMTP id b16mr21124412ioj.9.1584992163562;
        Mon, 23 Mar 2020 12:36:03 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y1sm4614140ioq.47.2020.03.23.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:36:02 -0700 (PDT)
Received: (nullmailer pid 6841 invoked by uid 1000);
        Mon, 23 Mar 2020 19:36:01 -0000
Date:   Mon, 23 Mar 2020 13:36:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, heiko@sntech.de,
        hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1] dt-bindings: display: rockchip: convert rockchip vop
 bindings to yaml
Message-ID: <20200323193601.GC8470@bogus>
References: <20200306170353.11393-1-jbx6244@gmail.com>
 <590762ab-db79-c8b1-7f0e-b653ed4b1721@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590762ab-db79-c8b1-7f0e-b653ed4b1721@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 07:55:22AM +0100, Johan Jonker wrote:
> Hi,
> 
> Question for robh:
> 
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like:
> 
> assigned-clocks:
> assigned-clock-rates:
> power-domains:
> 
> Should we add or not?

Yes, only pinctrl properties are automatically added.

We could change 'assigned-clocks', but for now I think they should be 
added.

Rob
