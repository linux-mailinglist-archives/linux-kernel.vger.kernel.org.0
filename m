Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4DAC0DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfI0WUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:20:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46918 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfI0WUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:20:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so6476464oiw.13;
        Fri, 27 Sep 2019 15:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zSlrRQAyUzLzDePKx5F/JeUlPrFE0AHowrB2Uv3bJB8=;
        b=FI3Sq90/tYA2ms/iIS3C7ZxkBZgfBVYfSShElC9GmvQ8uX1uzbW7m7h4kxnp1L/zGE
         CTr4PFLuK63ZUwg3H/62mrmmIfFE2uLwJAYbHoXvpdAifFiSiHLH/vDOzQ4GxWP3x0ea
         uqZx7frLVr6RQZmPrzgDQ55ccRZxT4+j0+Fg0uAdS4JIky25dm910uRR2XS5+Z5eFpoh
         gqFgDvHc5CpZy39W6sMkndxoRkREFEx7Z/KBXzv8o9FuWFeMrR6Q7h4illLbOFzadwXy
         D/3R+c01bqGq92v0o5HC5T+AudBihw82r8SUQxmWTqX744+GFIjstfbqZqrW9nK2UWb7
         /Dwg==
X-Gm-Message-State: APjAAAXWsMkfZ9pXqDtnzTzZuyvyYBiIRgpt/BWXyEm+gT0q1/hkA8mh
        NXaSBNk8x2BJS84GnmKLaQ==
X-Google-Smtp-Source: APXvYqzLqhBEtloMUt2UFKRqZAEv8FDUTvUeMoLWCYalfih52zLOnd74yMfYEgyPVlzzI7KvIsbC/Q==
X-Received: by 2002:aca:c3d0:: with SMTP id t199mr8571497oif.22.1569622839198;
        Fri, 27 Sep 2019 15:20:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 5sm1388319otp.20.2019.09.27.15.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 15:20:38 -0700 (PDT)
Date:   Fri, 27 Sep 2019 17:20:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <20190927222038.GA22180@bogus>
References: <20190927100738.1863563-1-paul.kocialkowski@bootlin.com>
 <20190927100738.1863563-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927100738.1863563-2-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:07:37PM +0200, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../display/xylon,logicvc-display.yaml        | 313 ++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml

Any response to my last mail on v1?

Rob
