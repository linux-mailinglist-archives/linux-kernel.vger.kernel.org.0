Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901181D096
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 22:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfENU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 16:27:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45397 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:27:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so95945oie.12;
        Tue, 14 May 2019 13:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kw0/GP3EsXZW6LUJqBkxGevYhmRsqd6LBUlMlUibiPE=;
        b=bt+DTxrsZIVf98CpmBQL1Jdt3ft5PIhyNTH8gTfydYKzxYXqbnKA0+PKkIWoqMNyyn
         Y3WXu7E3grjaOrbB3EO5kOqqWmHsGhCUnm8t42u4rfjOC7nS/1E+7paA6ergXID5WzWO
         2UJOkwrYavlufx/JO1B1HiJnuyd9wvAZjmkyW/wnFM3+wRcZC4R8SLKtYjqm2sglvel9
         WqEvSF2kwipI18EIV3R1AvQ5K+MLyhlHtxY/kp+C7jAZOtklh1QoccHX5+40Np+obesz
         OlWsg/1XqyzSJiI1+D0JJOnjUqttSPyJWqv/XBJfYL9ZDt3FewQXnjH34zH5mDA8NIoT
         tk/g==
X-Gm-Message-State: APjAAAWO9MDmiTvNMFKIKbrKkQuQdL0tmPh7Cajb+BqUEyJCOo3rOlAj
        hS7j0D12wRbXqB+dyvnImw==
X-Google-Smtp-Source: APXvYqw4vGKzCpOYn9dsgcfrTdEK0JiPQpO/Z6fOg7WvWNBNYtbCoCO+0Sl62db46/ol9PDe98J5yw==
X-Received: by 2002:aca:c6c2:: with SMTP id w185mr4183258oif.104.1557865670120;
        Tue, 14 May 2019 13:27:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63sm6521698otc.76.2019.05.14.13.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:27:49 -0700 (PDT)
Date:   Tue, 14 May 2019 15:27:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: regulator: add support for MT6392
Message-ID: <20190514202748.GA20452@bogus>
References: <20190513161026.31308-1-fparent@baylibre.com>
 <20190513161026.31308-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513161026.31308-2-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 18:10:22 +0200, Fabien Parent wrote:
> Add binding documentation of the regulator for MT6392 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> v2:
> 	* Use 'pmic' as node name for the pmic.
> 	* Use 'regulators' as node name for the regulators
> 	* use dash instead of underscore for regulator's node names.
> 
> ---
>  .../bindings/regulator/mt6392-regulator.txt   | 220 ++++++++++++++++++
>  1 file changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
