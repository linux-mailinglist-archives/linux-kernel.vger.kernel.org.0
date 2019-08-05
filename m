Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43F82722
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfHEVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 17:46:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36419 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:46:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so40393638pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0N59rAm+IJdZS4+AP3R02NAzCgd4BoOv2ctu3nbjqJk=;
        b=rwLUWgvf1qQ+YcLoAV6e/qmpmkL/X1qlmcjgtIb/Z0qj1AQllfD9q5ik/WMI+dYgbP
         oJB1Xz+WU6zGzIXXJ+20bqmnijwUbUa97iRn2GNNFa3/bbtkF7qEU1bclXHWgxGuwOvU
         fmyhI7N8oALj6ySt7EzgMYJiWMi5oITwedtoA1v+vD1CX10PJM841SJYNGHQyqSRiw44
         wMlDssxMSfEVH1sV62x26S8i+9MYZxv5FbK/Z2KO+xpxE+6YdUIz1IayC1IHtb9GqI4o
         YzL4VqDMRaqaJuKc9vJMCJUxd9BBSvc/JQ2LkqodkIADM5VOdiTLi9bH/+OtkPY5ZpgG
         NC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0N59rAm+IJdZS4+AP3R02NAzCgd4BoOv2ctu3nbjqJk=;
        b=EaWeyD235ScEwVnERbBvdKD0+mJTkhyXRbyXVPXFXnwBFdHS1dvI8Dl9K78hbjlZT/
         zdLTXd3r9JkHiDFSlWN+rSSpml1n/9c8ytPhOQX1uv1j3/PHpQKLIdj/vnJuQxd8qpDM
         PTqV6jtlFWpPY1eTVZ14x4RHPd+uh8rN9PsAMn7UGM+mL4IyvrApMEqAtHhm0vY8Gy3P
         WJaR21H3xdT80EJHRHhiFfaGgJ5iG1+GFgtDEsSei5qnCmmEctnZdw+MoxIstx/OCsNQ
         vhh+1dMPRYN/n3S97L58xgKAgL11P3Z32FGXZ10Xqpt0H0vor6KgAH2s+3dnNom2NiOd
         EaUQ==
X-Gm-Message-State: APjAAAVX1fM9lvUXTMWkksl4IGWIlvcF2HU99wCXo9DJlpBsqSKelqsv
        dmE0FlTzRDl7EeF4IW1zSi8YvQ==
X-Google-Smtp-Source: APXvYqy5DdisYBXyBq8Lx1/TvhiGE9temZcFVyJDWqAZ4J03brj3zIZsQ1ZSoTA1IfrzD90LOIifoA==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr20537343pjb.115.1565041589679;
        Mon, 05 Aug 2019 14:46:29 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id s24sm85504977pfh.133.2019.08.05.14.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 14:46:29 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: Re: [PATCH 2/6] dt-bindings: arm: amlogic: add bindings for G12B based S922X SoC
In-Reply-To: <20190731124000.22072-3-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-3-narmstrong@baylibre.com>
Date:   Mon, 05 Aug 2019 14:46:28 -0700
Message-ID: <7hblx3gua3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add a specific compatible for the Amlogic G12B family based S922X SoC
> to differentiate with the A311D SoC from the same family.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 325c6fd3566d..3c3bc806cd23 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -139,6 +139,7 @@ properties:
>          items:
>            - enum:
>                - hardkernel,odroid-n2
> +          - const: amlogic,s922x
>            - const: amlogic,g12b

nit: in previous binding docs, we were trying to keep these sorted
alphabetically.  I'll reorder the new "s922x" after "g12b" when
applying.

Thanks,

Kevin
