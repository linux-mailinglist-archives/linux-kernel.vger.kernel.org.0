Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991A41535D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 18:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBERCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 12:02:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38803 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgBERCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:02:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so3695647wmj.3;
        Wed, 05 Feb 2020 09:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPYp7X/qdf3150Np7qyZOnDaTe5Jp/9eoEEjYwrntFI=;
        b=UIw0Bh1xUCwwR8oryBelrUhwvxfW3asMsfjExl+vO3hJ4cXvZkEgjeg44vXg+Tslch
         1p+PPDFg565kyhK3DkMtkIx6f4K0WJ8aYB6vaiAOzX7ga62JGjSbRG9Fh2z6zV19p3i2
         sox56jbg/D/zfCrtD/BLOUWxHO5P9fipQgRXTqbyg/MA/M0RWuBWYaZ5H++vIjWRXihF
         KMhXYZJdDcMc9EUBgM5/kC7lotvTcKOTsi6nimnlA57pQB4Asqkyiyyd9o++mpWM3/78
         9x4sgr2xni6R/xhHceOGxA9eQhlGQTaD6B3io+9Fpvtz0Kj+5OtC4BgGje696R1NZcQD
         Zmdw==
X-Gm-Message-State: APjAAAUvguPmX9PSsIE+h6t+bHhHtJhi7Wc++Yf+ylGW1s1VQjFPCAP8
        OFuazDAVD6Flwh8bWdPFIQ==
X-Google-Smtp-Source: APXvYqxcBy7ooymbHh3JSNy/dTWF/afA0bOEcPUdyjmy/ucsr02aELJUYEAmKLhx5lWVAfHn/SSgYw==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr6693030wmm.98.1580922135164;
        Wed, 05 Feb 2020 09:02:15 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id w15sm502420wrs.80.2020.02.05.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:02:14 -0800 (PST)
Received: (nullmailer pid 15554 invoked by uid 1000);
        Wed, 05 Feb 2020 17:02:13 -0000
Date:   Wed, 5 Feb 2020 17:02:13 +0000
From:   Rob Herring <robh@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     alsa-devel@alsa-project.org, cychiang@chromium.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com, devicetree@vger.kernel.org,
        groeck@chromium.org, enric.balletbo@collabora.com,
        broonie@kernel.org, lgirdwood@gmail.com, bleung@chromium.org
Subject: Re: [PATCH] dt-bindings: Convert the binding file
 google,cros-ec-codec.txt to yaml format.
Message-ID: <20200205170213.GA15498@bogus>
References: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127091806.11403-1-dafna.hirschfeld@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 10:18:06 +0100, Dafna Hirschfeld wrote:
> This was tested and verified with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  .../bindings/sound/google,cros-ec-codec.txt   | 44 -------------
>  .../bindings/sound/google,cros-ec-codec.yaml  | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
