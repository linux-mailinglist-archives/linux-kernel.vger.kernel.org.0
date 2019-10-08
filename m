Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46237CFFA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfJHRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:18:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:18:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so20350321wrd.3;
        Tue, 08 Oct 2019 10:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KCXyzpU3dgR07Gdbce6LfLYUIptdiLzSDu/Iqt21TQ=;
        b=bmgrElu2VlCS5UslRJXA+iibBbwS2jsxFsYeN7y+Ue9vmI21omWyNFYFzme7i68uFe
         i+wJAyyk5wJgyKl80DMofzp4jizT6WGtdancUzaVemuadEl6l9br3nMRDeD6nYvO+SWI
         GjuooVG3pD+nMmIC+yjTK0ZkoXBHc08MrZbNIh4NT5NLVpHiw1852DrTAsfsKXd+/qTW
         kp1wiCr7v+nOqRzvoD4ZcYLz/euKXzOw4oSyahDTRkiERYBqZWfWlbL14WBnEWxlBOXW
         21NC0fS66ejUa05WIwEdTEc8jYAiOVQ3BmV98rghqGzEWA0VTEHYjfQMwwYAGM0p64in
         Bavw==
X-Gm-Message-State: APjAAAWhkagxhWzrvuqDpHaEiz5NrDVdx6QeiMApFYjqpb1FfjSk4TGh
        p5A5oRrnUN7Ce4OxT07neF3AoRUq
X-Google-Smtp-Source: APXvYqySEnlrvHQ0j8san+qAcBH4oeN9WXugf40WlyqhbiYA+KvafyW9c7JtN+PLERblpK393GQ4/A==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr28038407wrq.78.1570555092266;
        Tue, 08 Oct 2019 10:18:12 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id z9sm19137134wrl.35.2019.10.08.10.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 10:18:11 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:18:09 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lihua Yao <ylhuajnu@outlook.com>
Subject: Re: [PATCH] ARM: dts: s3c64xx: Fix init order of clock providers
Message-ID: <20191008171809.GA25661@kozik-lap>
References: <20191008165917.23908-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008165917.23908-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:59:17PM +0200, Krzysztof Kozlowski wrote:
> From: Lihua Yao <ylhuajnu@outlook.com>
> 
> fin_pll is the parent of clock-controller@7e00f000, specify
> the dependency to ensure proper initialization order of clock
> providers.
> 
> without this patch:
> [    0.000000] S3C6410 clocks: apll = 0, mpll = 0
> [    0.000000]  epll = 0, arm_clk = 0
> 
> with this patch:
> [    0.000000] S3C6410 clocks: apll = 532000000, mpll = 532000000
> [    0.000000]  epll = 24000000, arm_clk = 532000000
> 
> Fixes: 3f6d439f2022 ("clk: reverse default clk provider initialization order in of_clk_init()")
> Signed-off-by: Lihua Yao <ylhuajnu@outlook.com>

Thanks, applied.

Best regards,
Krzysztof

