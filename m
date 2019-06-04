Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 801DF34A91
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfFDOi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 10:38:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37850 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFDOi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:38:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so334646wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8yVp8LW/5tvDYIdw2ZjGi4ruSvPsT4gaU3KQr2PELI4=;
        b=A7Kqt8FA/PZlIOCWpIHikU1GTW15SgXKBI4w+GU2YVXQrsV5zxKoLF/CNIHmi/wveq
         JjUw4ZVMXLxXu0efAKQUqxDpWj6q6qWrZx3Ti20klLgsB/Rv8hNLgRL1R23KwIhPM0Vz
         hQvfg8kFzMZ2Gm6kl74A7T/JIsM55Jy6eBAGX3dVxxuv3o7b4fvenKXHlAzfic5292ip
         LSSA9xjv4P2N+g4wXhCwkoP1NYwvmzrsuKWHDOf3UGYqFuBqHc2pKg787buWRZi+hXsO
         HNkPeJ/Q41f4bF4uDFj4XYlrQuEuuvtI7SePznEdEu5Mnx/cFCyyBa8GskLwLc/FFQtr
         zgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8yVp8LW/5tvDYIdw2ZjGi4ruSvPsT4gaU3KQr2PELI4=;
        b=I8r5XPcE106G7kktZ96QEqAKfwL5Ome4E9oDFMgumY/kWTSTYDDqcUqX8uvnyWoElq
         wBPhNICt3ozz9Iq3F5HzprNBelKKf1ajYcsgOFCEt8pu6KIjiMhX9G9CqAkZTjW2Y1hv
         KiQexDPiEXml7RcF0k2N4mOPPEL4pZtMa2P5dc92hMEm/0WkzGPMr2o9OcYRNxwAigHl
         rnDBq78w0zM2nVY8FaXFSMtFd5+JTOrKBuxErVhcureEodpir883sGERW+M2uncFnAn4
         d3R4JJF0vbQTLzpP0GgQzaJnovka65Wsl1KMEBkfR8k0q43gkkFeGwILQSrdSVZet2tv
         byqA==
X-Gm-Message-State: APjAAAXDtrQ7v5riWvWxaEydNXuohHqcT+2d/wstXZg/mezgqf9Z6krR
        uy6gX8u7WxEEbMEMBksFplZRDQ==
X-Google-Smtp-Source: APXvYqxRW4nwf4GpDLyd87BakAfZ89olYzNbTVRR1tlK/pY6mlbd9mILPL7WAvRnQL8m2ze14qkPFg==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr8827610wmc.1.1559659134003;
        Tue, 04 Jun 2019 07:38:54 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s14sm15595662wrw.10.2019.06.04.07.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:38:53 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        ShihPo Hung <shihpo.hung@sifive.com>
Subject: Re: [PATCH v3 4/5] riscv: dts: add initial support for the SiFive FU540-C000 SoC
In-Reply-To: <20190602080500.31700-5-paul.walmsley@sifive.com>
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-5-paul.walmsley@sifive.com>
Date:   Tue, 04 Jun 2019 16:38:51 +0200
Message-ID: <86sgsph0uc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 02 Jun 2019 at 01:04, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> Add initial support for the SiFive FU540-C000 SoC.  This is a 28nm SoC
> based around the SiFive U54-MC core complex and a TileLink
> interconnect.
>
> This file is expected to grow as more device drivers are added to the
> kernel.
>
> This patch includes a fix to the QSPI memory map due to a
> documentation bug, found by ShihPo Hung <shihpo.hung@sifive.com>, adds
> entries for the I2C controller, and merges all DT changes that
> formerly were made dynamically by the riscv-pk BBL proxy kernel.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Loys Ollivier <lollivier@baylibre.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: ShihPo Hung <shihpo.hung@sifive.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
