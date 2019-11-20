Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6718510377C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfKTK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 05:27:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38992 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfKTK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:27:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id r13so7597937uan.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPPl+dieWmwwl5vclo4eycxw3/3RIJ5/bVbsRxQY9fg=;
        b=cDYB8Bd/9XV0BpnQ5A/BVa8N7CSLhRXNha/+ozOLuZ0ti/xAJMxWBF/n+373T53553
         61ARehzgYwuxH8lCICdiBYJDRiCYlQYtg+hh6DIilDevFzomryjjIm+kXsuIvBGNgrgx
         N6VR3Ui0/jj6DcZzLxG87/9pdgN3Jo+3efXMmqaECPiEW8JY0jHOqosJen1A6JvVkSiS
         9JNQhOsBG9eCu5lFGgY1SxHNpVxqf6zaTc9rwPWEDaGaPUATNpWw74J88QL6aIy6jcNh
         tlGKDgD4Fr06GeoS9kWNvD9uv8PTeaMiRkYePDsuQPPPchtb6ufXZP0A9ZyOHLJfWh/M
         M63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPPl+dieWmwwl5vclo4eycxw3/3RIJ5/bVbsRxQY9fg=;
        b=UPJPDOZmcDXYEQXOHH5C315XK3pZYI75V2B8dzrzTfdFsCgsJSiSLnZEYoS08Y9KCj
         24UYgyWfUXn99WjFCoryR5+DmdT0XTMOMNBVdp8mw7g+TWCnV30tEL5K14lUegqFzXZ6
         UikH71uwxIGYSjqoM0mt5Ls5/FWEAmFyfe+h7dfST6GQjCXUsCSzo9cO3Rj0JVu9rEtP
         9gqjmKUL6QK7YIRMy+OeTLlLcP5BQKMduunZZ85hvpydvIe2pjTFIQ98LtzEf5MinxL8
         jsgBLS1iPA6WGrLdqgLvbEYDjXjY3oDlqXDaMpdFbbkj58ALZuvTR10J7n009glS1ok4
         mfbg==
X-Gm-Message-State: APjAAAXYNg4kEERjHe+wTtW2qKp6CxYcDklF9XBEyi+A5MfLetba5+JZ
        Hki/T/LhrABa0joFg27P0i0G6sWO3Un77LgQflYGqQ==
X-Google-Smtp-Source: APXvYqz54Zeg8KbbWUdNshHqcWaCOGq8jgGO9qGY0g5PgtU6Hs76XawRjWx7E0migoK0Q+phAd/zNlaNrZ7pNwlmXcE=
X-Received: by 2002:ab0:61cc:: with SMTP id m12mr1127845uan.129.1574245652878;
 Wed, 20 Nov 2019 02:27:32 -0800 (PST)
MIME-Version: 1.0
References: <1574236796-25016-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1574236796-25016-1-git-send-email-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 11:26:55 +0100
Message-ID: <CAPDyKFo-Y8zctjLw0F5RibO9gogQTkf1Xbc-ODLySAJ_9r_jAw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: power: Rename back power_domain.txt
 bindings to fix references
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 09:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> With split of power domain controller bindings to power-domain.yaml,
> the consumer part was renamed to power-domain.txt breaking the
> references.  Undo the renaming.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: ea312b90857d ("dt-bindings: power: Convert Generic Power Domain bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> ---
>
> Changes since v2:
> 1. Simplify pattern in Maintainers as Geert suggested,
> 2. Add Reviewed-by.
>
> Changes since v1:
> 1. Undo the renaming.
> ---
>  .../devicetree/bindings/power/{power-domain.txt => power_domain.txt}    | 0
>  MAINTAINERS                                                             | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/power/{power-domain.txt => power_domain.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/power/power-domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/power/power-domain.txt
> rename to Documentation/devicetree/bindings/power/power_domain.txt
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7126d3e079a4..0aff4bebed78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6953,7 +6953,7 @@ L:        linux-pm@vger.kernel.org
>  S:     Supported
>  F:     drivers/base/power/domain*.c
>  F:     include/linux/pm_domain.h
> -F:     Documentation/devicetree/bindings/power/power-domain*
> +F:     Documentation/devicetree/bindings/power/power?domain*
>
>  GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
>  M:     Eugen Hristev <eugen.hristev@microchip.com>
> --
> 2.7.4
>
