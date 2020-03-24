Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF2191C87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgCXWHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:07:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41823 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:07:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so516797wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YusM14BzJIMDSHzMH5zdQjw9hhEPT3JITrKIkp7xEiM=;
        b=U5oJgwJXEzInJbCIIllHCyQtoy/blNO5KYVVGHN+8SR+VKjULgmNBy/lH8MVbbmlkL
         GPBooUKVyWq7vjqhlzRUKcA01z8NTBrvLB+e98zv7ais1jXQoW3t4CQ7mxYkL+gTucey
         2OB3m6uVI+l05dzTf7V0rJFPEpe9siDmry3VRO/wNAo4QVPTOvgDhTpNnhIWUAcDQoGB
         QgqQ5eLI88p3/+p2/3h/WuZ+UPfBhCOmbPHIGFirtt1E9h4DRCjG1StIjOr5JdLZAwfA
         +dIjEKOIgvfNhulzvawbwxR40c1oj51Y+fWYB4rHjY9Ui2T25TTQzDUWifCnWaF8VbJ3
         Slhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YusM14BzJIMDSHzMH5zdQjw9hhEPT3JITrKIkp7xEiM=;
        b=QIh+SjG9QG2HSn9DoLWiKm287mMXcoRduDnEaU8h3fzlJL4X7qV5BNC/Cp493FjmHh
         Pj5Qj8J6B2wwhKptrco05QwhhIy9so/UUZOpnxHXDCwNmKcKPvacP6x7EMF4+dXegeBO
         npx5Md8+uQRvVW7CM69FPxcB8a+Hqe2iBgsM1iYnL8kuPGbK/0IeJw6asI78qG5SDScS
         hwve15eV1uCub3r2EthfTOA9FA79uWHfLZiXPbiS0cTGkuXJ0T5nxMRJhItI05nkqOFd
         pNlvGav5Is24kmqj/6GUeq2w30AlqUHl50+jfbm2PId5HgokljDWv9R6XhAZAi2oaP60
         OI7w==
X-Gm-Message-State: ANhLgQ1U2QaKvMruZQf7lTEAeFmW3JD6UUBrypsKhppTwbKpEv/WuszM
        UClus7M2J0eCx73N47kTYLNraw==
X-Google-Smtp-Source: ADFU+vuSxXw25QUR0nIAb5OLmIU6jTi7EWOtLxakEApqVuvh84HPZknVnAkiaJ2bxtodhoIEBc76bQ==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr32380863wrv.92.1585087641149;
        Tue, 24 Mar 2020 15:07:21 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v11sm11963482wrm.43.2020.03.24.15.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 15:07:20 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] drm/meson: add support for Amlogic Video FBC
In-Reply-To: <20200324142016.31824-1-narmstrong@baylibre.com>
References: <20200324142016.31824-1-narmstrong@baylibre.com>
Date:   Tue, 24 Mar 2020 15:07:17 -0700
Message-ID: <7hsghx2yqy.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Amlogic uses a proprietary lossless image compression protocol and format
> for their hardware video codec accelerators, either video decoders or
> video input encoders.
>
> It considerably reduces memory bandwidth while writing and reading
> frames in memory.
>
> The underlying storage is considered to be 3 components, 8bit or 10-bit
> per component, YCbCr 420, single plane :
> - DRM_FORMAT_YUV420_8BIT
> - DRM_FORMAT_YUV420_10BIT
>
> This modifier will be notably added to DMA-BUF frames imported from the V4L2
> Amlogic VDEC decoder.
>
> At least two layout are supported :
> - Basic: composed of a body and a header
> - Scatter: the buffer is filled with a IOMMU scatter table referring
>   to the encoder current memory layout. This mode if more efficient in terms
>   of memory allocation but frames are not dumpable and only valid during until
>   the buffer is freed and back in control of the encoder
>
> At least two options are supported :
> - Memory saving: when the pixel bpp is 8b, the size of the superblock can
>   be reduced, thus saving memory.
>
> This serie adds the missing register, updated the FBC decoder registers
> content to be committed by the crtc code.
>
> The Amlogic FBC has been tested with compressed content from the Amlogic
> HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
> (Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
> (Scatter on G12A/SM1, default on GXL).

Tested on meson-sm1-sei610 (VP9 60fps content).

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
