Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5614FE7DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 02:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfJ2B0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 21:26:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46760 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfJ2B0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:26:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so8341542oth.13;
        Mon, 28 Oct 2019 18:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eCcfvuoPjyHMd42pi6nHfOR0UQumVD6OC7pdJhU7kf0=;
        b=gw3AkOQ2K1vuVOCA2TBWGqqs2iFtSrlysdJw+TgB/JVY628Oq2N1Gqw0nvXiwGkKY6
         hAAJdSq/yr0ngNoW6CoVg1MkXWolF75JKwDvZ6VCPb8MZQL0W8mEbrcJE4vxR5fLLSqu
         4CLs5Q6qO+1FWZB2GJyeP/SjIUGVXJrRJEZ7sIMYdQNi5pVJzKf/ywv0RsT3N9HrD5QJ
         Tswg7zZxe238Zc8HnoYFo87IjS7CDHas2jF5Xzvr91Fxua6nLhWDd9+pPa0UKz/Fvq7q
         v6ZLyeJsZnbvOvsz5BRgmgPQWaXm17kX/PmE31uNtMklrkNLH2UPut0t7xlhJzivOMnJ
         23Vg==
X-Gm-Message-State: APjAAAVCSOMMkTAUkk6vMmeLsz9rPg44txcEU8ulGpOBUniJbLCNs1lh
        FPibp89fmUb97N9xyraRLA==
X-Google-Smtp-Source: APXvYqzullEppKlo2Vs5I8EFaP7D80fR49srcNV1CcFfdV+cfQk+WtNPkgcRwpUjgM2VuMnhCwAMsg==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr15691588otl.4.1572312410530;
        Mon, 28 Oct 2019 18:26:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm2136223otl.25.2019.10.28.18.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:26:49 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:26:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: stm32-ipcc: Updates for wakeup
 management
Message-ID: <20191029012649.GA21858@bogus>
References: <1571228029-31652-1-git-send-email-fabien.dessenne@st.com>
 <1571228029-31652-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571228029-31652-2-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 02:13:48PM +0200, Fabien Dessenne wrote:
> The wakeup specific IRQ management is no more needed to wake up the stm32
> plaform.

typo

> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

With that fixed,

Acked-by: Rob Herring <robh@kernel.org>
