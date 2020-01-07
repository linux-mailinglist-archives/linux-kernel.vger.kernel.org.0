Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE56133073
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 21:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgAGUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 15:15:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41952 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgAGUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:15:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so654290eds.8;
        Tue, 07 Jan 2020 12:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RezWGX4/KzRhjUL8C/w2qwO9LCJwafyvIRxk+EkpPaQ=;
        b=CyltCQWqa1OUJL8K7buMEnwbjFAddhp7ULqWv8qeeLNnXskJ1oDVj5Qv8CKN3T/1oy
         rlWuFQITSi6jHpiqYPCIavTVfhSG1DC4DXjrBuWI4pjCnmTBy6OQ9SamBJBZkCtxgzR7
         XpD28XgA3Vy/jq76PRpvKLDY42nRbTnhv2YglxZ/ISdUU0jLaJDbswNViIROorjoivvY
         jb+D2mL/LLbG/DEJ7w4RsxYypBkXa57w4v8sjf9oypwRhtjkbq9XAZksi+9OUH517EBi
         70fUG2eSmqKFBhOhuWcnvkAtVibNZ3rlIjAu8SP5s0dgJmO4x2fRg4mwQFr7OAla1x8v
         rckA==
X-Gm-Message-State: APjAAAXJrioRsXaWmz2OFDvruibz6/y2NVrsguc7bxg7VT1V2QqGPFJx
        1eo65Bznde2HaAGAoxtF4WBYN41F
X-Google-Smtp-Source: APXvYqw6e4hhOXHOzwm4STWo1T2YNVmlHVOtMiLI34CH3pgDXDvwEbqN3AaLJCk+BtY7g6rkS+l7hQ==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr1163948ejr.313.1578428099440;
        Tue, 07 Jan 2020 12:14:59 -0800 (PST)
Received: from kozik-book ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id cw10sm10946ejb.56.2020.01.07.12.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 12:14:58 -0800 (PST)
Date:   Tue, 7 Jan 2020 21:14:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 05/20] soc: samsung: Rename Samsung and Exynos to
 lowercase
Message-ID: <20200107201456.GD8636@kozik-book>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104152107.11407-6-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 04:20:52PM +0100, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Samsung"
> and "Exynos" names.
> 
> "SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
> names.  Therefore they should be written with lowercase letters starting
> with capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Although advertisement materials usually use uppercase "SAMSUNG", the
> lowercase version is used in all legal aspects (e.g. on Wikipedia and in
> privacy/legal statements on
> https://www.samsung.com/semiconductor/privacy-global/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/soc/samsung/Kconfig                 |  2 +-
>  drivers/soc/samsung/exynos-chipid.c         |  2 +-
>  drivers/soc/samsung/exynos-pmu.c            |  2 +-
>  drivers/soc/samsung/exynos-pmu.h            |  2 +-
>  drivers/soc/samsung/exynos3250-pmu.c        |  2 +-
>  drivers/soc/samsung/exynos4-pmu.c           |  2 +-
>  drivers/soc/samsung/exynos5250-pmu.c        |  2 +-
>  drivers/soc/samsung/exynos5420-pmu.c        |  2 +-
>  include/linux/soc/samsung/exynos-pmu.h      |  2 +-
>  include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++--------

Applied.

Best regards,
Krzysztof

