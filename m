Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67974139D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 00:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAMXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 18:37:04 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38575 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgAMXhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:37:04 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so4975832pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=URU0nYVVIvG9fQe+g2UcCIBs+6Op8N6XSVfeKx2sX+I=;
        b=b/ab/jdXLWIU3ED09YHc4yD7PEZYMen7BL6s7F1/kjYZZ83fH7thRSgRFb4nvmHi9+
         I8uOh4axY1udmFUQ9CRB6Ak22NsM0Q5kOUrMSui9gEu5AZwkkiQGPJxHY4Ek0jT/BU7x
         dN3GGRtSBhufBlwxACNUPr6YqSRNplN/UB1VyIzSrV23VJ/BxtF8x8jOUP/NEUxtfkff
         VucOsF7idPxxRbVhU5/fTAEEDTXLWM6GxHyPAO3/NDMx+eTcgWfIn5rfkPyTksPsZSjP
         e4eZNbaY5gv76V7loiTc0SQ3nvjtNOKckOayZ/Icwb44Nfq+t/qB4ZXVB/jumkX3KfWa
         mBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=URU0nYVVIvG9fQe+g2UcCIBs+6Op8N6XSVfeKx2sX+I=;
        b=IMyl5cTkmtBPJnGxuu6VpAmVH/xyqqhcFVetW4+WS0BwdGmtsfnrQcGwUp1/biVlOa
         4v+DHD2NGybLsL5Wzjgylqnbk4vShP5argr4J8ybizJBMwMMoNYh8dpe3srWYv6lXWeT
         2qneyCoFcAdRoNImTpCaginGeRSyDwuW3ona//wR4J9T74TzPQAcSZETUnE78YVHWgJa
         j42Vaq9ZzJLc/F6/xhYPMhYaAMakqwUs+Q1OyEiCQGBgWlk1qzjMaCeJ8BZf18VLF/BZ
         jzid0uQMYFiJyKoHnGqbELH5e86BRvCPO0mC3KKjT9AQqYTepXOwCd8ifjATaPBZo+Se
         RRzQ==
X-Gm-Message-State: APjAAAWP2T+kR0zjNNry6NBJn2NDxYDkYEcaOIJcKULsSh460PjHO3L6
        OdTXrYuw5cLlvwQ5xSg44L264A==
X-Google-Smtp-Source: APXvYqzCuoCV4QA2/uQQXAdoLv7iqVZ5/gY2tfSqNNG6zeLXktzaA9OsR+piF0ld/u9H+WkLG6qR5Q==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr17117837plb.324.1578958623194;
        Mon, 13 Jan 2020 15:37:03 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id q15sm14613132pgi.55.2020.01.13.15.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 15:37:02 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: power: add Amlogic secure power domains bindings
In-Reply-To: <1573532930-39505-2-git-send-email-jianxin.pan@amlogic.com>
References: <1573532930-39505-1-git-send-email-jianxin.pan@amlogic.com> <1573532930-39505-2-git-send-email-jianxin.pan@amlogic.com>
Date:   Mon, 13 Jan 2020 15:37:02 -0800
Message-ID: <7ha76rdj35.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Add the bindings for the Amlogic Secure power domains, controlling the
> secure power domains.
>
> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which the
> power domain registers are in secure world.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 37 ++++++++++++++++++++++
>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>  create mode 100644 include/dt-bindings/power/meson-a1-power.h
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> new file mode 100644
> index 00000000..2ed269f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +# Copyright (c) 2019 Amlogic, Inc
> +# Author: Jianxin Pan <jianxin.pan@amlogic.com>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-pwrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson Secure Power Domains
> +
> +maintainers:
> +  - Jianxin Pan <jianxin.pan@amlogic.com>
> +
> +description: |+
> +  Meson Secure Power Domains used in A1/C1 SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-pwrc
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - "#power-domain-cells"
> +
> +examples:
> +  - |
> +    pwrc: power-controller {
> +          compatible = "amlogic,meson-a1-pwrc";
> +          #power-domain-cells = <1>;
> +          secure-monitor = <&sm>;

As requested by Rob, please put this under the secure-monitor node.

Kevin
