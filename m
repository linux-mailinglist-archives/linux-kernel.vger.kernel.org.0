Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA54679D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfG2Xzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 19:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfG2Xzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:55:35 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBCE21773;
        Mon, 29 Jul 2019 23:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564444534;
        bh=QJajQ9rPwQQEztIa7Aie8zZd9zfm/Sqk8yhLa8ZcYl0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V9/tFzo/fOI4CMU7QpMUnouCMw9y4Z4Gis/0Xg3FuV6jfnNqSFAPs1DA1HvL79MXq
         9YMFINPaRZERAbmHosngz5Yz24y7NBdq62iQsjsRWmNd15UbNzTI6OPnC1Fs/6VSJj
         srnKhICD1uhc8IXv2y+8DdWhp8MPYCO76JwBxO/k=
Received: by mail-qt1-f170.google.com with SMTP id d23so61319157qto.2;
        Mon, 29 Jul 2019 16:55:34 -0700 (PDT)
X-Gm-Message-State: APjAAAVp3Vu9ahqHib6Cansw9s/ubQdvReVLg4Ru+eqoipvBWWYu68XM
        VGS3TAN0jbQrv3HQHawVrtIcbOqEU5nokBMBDw==
X-Google-Smtp-Source: APXvYqznXMqQ6aE9gIcWbb/9lh1ClqELBH1Q0acqDOKZC0kqgtdGTVRMzfO1zsWwf0QVCqeFe8EP2ojj+nXv+b3KAlo=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr81436699qve.148.1564444533780;
 Mon, 29 Jul 2019 16:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190729172007.3275-1-krzk@kernel.org>
In-Reply-To: <20190729172007.3275-1-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Jul 2019 17:55:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLo9ftDo-tmeOWGqjKR32PL9bsWkDL+zr6LSYts2ZY7SA@mail.gmail.com>
Message-ID: <CAL_JsqLo9ftDo-tmeOWGqjKR32PL9bsWkDL+zr6LSYts2ZY7SA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: vendor-prefixes: Add Admatec GmbH and Anvo-Systems
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Add vendor prefix for Admatec GmbH (not to be confused with Admatec AG
> in Switzerland) and Anvo-Systems Dresden GmbH.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Use admatecde vendor prefix.
> 2. Add Anvo-Systems Dresden GmbH.
>
> Changes since v1:
> New patch
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
