Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06D710D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 21:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEATuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 15:50:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35760 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:50:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id g24so54692otq.2;
        Wed, 01 May 2019 12:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4aS2uE1D91mkrl/gYeWQtzT+PKkraqjyORTXhMdPTWc=;
        b=CLsCrl92AN4eW8Drf5Lp07Aqira5qR87/PwV8rJqrq4Mv+X+4/2yAXjnWrlxhSZOXu
         3pbpbQyQpNSYLpbaoJDHTCUcwv1WH3drYUEH+UnNCxSFx4ZPbJxVQ2WaRB24k8yAwz93
         xHKRmMTivetJuU1wYMy1gZblOH6q7DjeLBdUmIxnVohfLhWUmbtUyE/65TKnj4bI0tV8
         n0unMCLHZx3UiDMiJ2BXqm/EVCP+ICtknU+mdN9ARxThuhIRLOsKdJRjDMW8N4v0AUpn
         FlPux9OMpqqj6Oj8GwjAIUaRLnA5bo23GAMGKMNJPMqz8ZxOvRRQtjxgGY8zZy0OPTa1
         ENcQ==
X-Gm-Message-State: APjAAAXBYxx7BOaNCg0ElxTg+ERo4fAFBhxoKfdkwHZNc9PY5m/Xav/E
        6XYzGlfy5Qw3LIDzZGyApg==
X-Google-Smtp-Source: APXvYqwGNT8oOeMnhcZ+vSGs9Gi6hU6lT2YIKllylFBKjcxVlXfqb2L6uc1z343lFHswKPCjvxaXXA==
X-Received: by 2002:a9d:6344:: with SMTP id y4mr20118098otk.11.1556740221087;
        Wed, 01 May 2019 12:50:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m124sm16994766oia.3.2019.05.01.12.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 12:50:20 -0700 (PDT)
Date:   Wed, 1 May 2019 14:50:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190501195019.GA13211@bogus>
References: <20190419191730.9437-1-peron.clem@gmail.com>
 <20190419191730.9437-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190419191730.9437-2-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 21:17:26 +0200, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> Allwinner H6 has a SPDIF controller with an increase of the fifo
> size and a sligher difference in memory mapping compare which
> make it not compatible with the previous generation H3/A64.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
