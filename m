Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883C3E5A05
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJZLq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 07:46:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfJZLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:46:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id p21so4814609wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=WvV3v05v3ZEEVXEmLYdFb7lylJednPWrhNA9CKc5BuQ=;
        b=W4ZHEiZIpNqE3hsCeGHeX4lyrYRkFJ8+N2pzP5EIW+H2uFC30kwXAhqq34aA7o+DDB
         BmU1dchLy+sQVZesfH/mgQBQDsdBbSDqrjHp4rrvN/hygQxIKYOORGF6JIgpFkpPKVlt
         UX1ZC79a1kG1Tb5S12311GoebWaT7Ub492bZ3+7A2UGgJVGEzG5ccbJhAnhhApB30gp6
         2Yqv04+sNcM7GWXQPNdhpABEuHMIeuWBCyxbJaIKRZFaUFVHsK2SJ0wyxH1aC4ARqZoq
         AL38hGrSHCxmYez764UcYWBgdjsfFclVsenwWzYKCLW3HlF04rxnTaEz+TXd8tgEc2TJ
         nAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WvV3v05v3ZEEVXEmLYdFb7lylJednPWrhNA9CKc5BuQ=;
        b=p2DkaTBqTJ9Ulz+BruQCHBUe4Xtp/v74qqPW1nzF+V7oPDqh66wqrUe9CCGuEyvbgk
         kSLli93Y97npd0vQ9aeJL9oPLpmmoHwAW3vnm5W1iS/rWZjwQ5lCOIZYaFGmx/lPSWaa
         QKnAwWfG96rAmw8A1adyVDX1te94WPqySltGJCI+v9j9/piTbqBSPxQjsrHTEouxT9NS
         ZfmrWso3hLc7i8WN/XH6Xgd3pu6goCPSZnWI7XYiwilgEKy/O1aD2/b/8qq3g6AWbeta
         m+1JJiCWe4j/xCB+vSRfyGt2lTB+HZWztAt9HGJLxcpxnIDp+EILYHO97Y5Jvu1KKrz2
         L7lg==
X-Gm-Message-State: APjAAAVBupRV3WYQg/xfTXoect3WGrTTkXHCI/vstzLWevtxJIg0Qx9Q
        8UiaZLSTtUQHrUQTjQ+u9Ildfw==
X-Google-Smtp-Source: APXvYqzIGA1fzbnD59EkfsIe3VNpri1WAOprW76nJRcZAdCg/+VTJ8MZ+ItfjZ0R+iC4V6eP5dKUrg==
X-Received: by 2002:a05:600c:2387:: with SMTP id m7mr7366917wma.137.1572090385092;
        Sat, 26 Oct 2019 04:46:25 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o73sm5340728wme.34.2019.10.26.04.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Oct 2019 04:46:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, mark.rutland@arm.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v3 4/4] ARM64: dts: amlogic: adds crypto hardware node
In-Reply-To: <1571288786-34601-5-git-send-email-clabbe@baylibre.com>
References: <1571288786-34601-1-git-send-email-clabbe@baylibre.com> <1571288786-34601-5-git-send-email-clabbe@baylibre.com>
Date:   Sat, 26 Oct 2019 13:46:22 +0200
Message-ID: <7ho8y3g25t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corentin Labbe <clabbe@baylibre.com> writes:

> This patch adds the GXL crypto hardware node for all GXL SoCs.
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Queued for v5.5,

Thanks,

Kevin
