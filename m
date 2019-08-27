Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC249F181
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfH0RZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:25:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36841 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:25:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1so15588238oic.3;
        Tue, 27 Aug 2019 10:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EjM7jzuwyaCH9suwOcoqt23F6ratx04VI7mr/XZ4IN4=;
        b=eQ64X54L6X9u72DkZFO5x5XEvA0+Xa6BXpL9C3bbRgWDzVlbFX+XeEgmzx6LkCsa5I
         28C1hq/VhieTjFN4GdElfSEmSsb20CkN489PDQXmjwmeqz6HurQ3OfrWRO8oYmm4XS+D
         xB6INDegiYFIZmoaPdRycehJPGfAAcTVhd1jC9Houc01xAIlykjzLAUXxlbYFUv5xQQG
         z/FoohA4pnpAv/GTDYkXYIlWMKaVweyL6usifuLY7c15CctDqX9s4qhHAmSsnIQ8aWWe
         HbmSElMSsBy8O4ijO8MEb96Inu6RmItt+cJZfbnplHozyyJNvp6vfL/BI4r0BHRJvGIV
         Mi0A==
X-Gm-Message-State: APjAAAXqBGTUwGzLgoueKQ6t++9Lkko/oZPM3xRXPpPjlbehsFbV+L6A
        pt/Wn+vJWix/Z2ExWtA/yA==
X-Google-Smtp-Source: APXvYqwNobMD75awqFzunTVadMpb1x0jg67Rt2MOGSA5oaDz3ZLFqDi5igEHZfZ6DhAfesboGrIJdQ==
X-Received: by 2002:aca:3388:: with SMTP id z130mr17051307oiz.81.1566926705408;
        Tue, 27 Aug 2019 10:25:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm6241844ote.27.2019.08.27.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:25:04 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:25:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/15] dt-bindings: display: Add max-memory-bandwidth
 property for mxsfb
Message-ID: <20190827172504.GA15786@bogus>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
 <1566382555-12102-11-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566382555-12102-11-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 13:15:50 +0300, Robert Chiras wrote:
> Add new optional property 'max-memory-bandwidth', to limit the maximum
> bandwidth used by the MXSFB_DRM driver.
> 
> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
