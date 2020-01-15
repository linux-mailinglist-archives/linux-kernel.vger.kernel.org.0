Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455F313C652
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 09:39:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47062 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAOOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:39:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id 13so15523155oij.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zVuLMr/lvKJoF5UPfuI+lUQAIQkXCUMqhXcAHAs8ml4=;
        b=mJmzhH5qXScsxKZyN14PgVWUH2WoFdfpZDH3ezbkFdq3/21KNT0BtsufrTL/UQgCz7
         x4ZH3pC2p+fM+wWjpuF8skg9egpQARPILyGLzIzuJDgnQAO/Dkl5ErFZtV72O062rd5I
         BItqoTgaj/W/hm8d0ijbrq+Zzlp0CBamnmLLTLBAUZMUkI7VU02ZuqozYarkH09aoQe2
         B8sYP/UYhDptE+cTBYPFvJtRMSRsRmy/nZSPnjDOh9nshxGnFkM6hzgO+OdFfxRWRGgR
         sbbq/spNRRGIOnsaBB/W46eduX4PU7KWRdhYGoB8jwdMpNrwNMnV85gT8rRuvUcN/pLU
         pPIw==
X-Gm-Message-State: APjAAAXCqhq/ft8NdZI5v5mfwj/uyq13OS0ECPkzVoS/eqhrOnp3QnAE
        EjIySbHOBS5nSnomOnLPmHhZKlo=
X-Google-Smtp-Source: APXvYqztBTLsV/mSiL8MoCX5mAkmXSz/DAl0qHmySbP6OLfg9ekYdxhu6fdLYutgqPDPJNwCLjbZWw==
X-Received: by 2002:a54:4106:: with SMTP id l6mr60669oic.76.1579099143248;
        Wed, 15 Jan 2020 06:39:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o20sm5683288oie.23.2020.01.15.06.39.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:39:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 08:39:01 -0600
Date:   Wed, 15 Jan 2020 08:39:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, David Dai <daidavid1@codeaurora.org>,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: interconnect: Convert qcom,sdm845 to
 DT schema
Message-ID: <20200115143901.GA4664@bogus>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-2-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578630784-962-2-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jan 2020 20:32:59 -0800, David Dai wrote:
> Convert the qcom,sdm845 interconnect provider binding to DT schema.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt          | 24 ------------
>  .../bindings/interconnect/qcom,sdm845.yaml         | 43 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
