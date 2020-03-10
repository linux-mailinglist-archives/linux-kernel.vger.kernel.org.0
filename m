Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 014C718075B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCJStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:49:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41055 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:20 -0400
Received: by mail-ot1-f65.google.com with SMTP id s15so5997833otq.8;
        Tue, 10 Mar 2020 11:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oJMNno1lQZX5Yt1T2cwhhyz5mFeIoqqe8lauC7RtIRA=;
        b=Njgpew2CHuC5qYOF1TcSe5stBQWQ0tuPSRt8BveiDzvFIUvhwtv1JB7zb7cbjG9aQR
         KgfwlqmOfE7GUlAlcs+XlRGPA8lvA3NtefHYulJpan0eku9PaVgAwjFk4aPWolFlKHJv
         EV2jbbYE154QnktIsIYo4Ek7Qq78KnJgc0zTryYftPQlgJ2R6u2qvcliM1pBIrsRzefZ
         Val0m+MlW7A1zePqj2Lvx/6uwISHtWzAmj9upZeoG4nCyYJI13Q1eaYqNiBcoI0PrIkV
         JuHnJRLsJyRGpHd9P/CdcLtvj9MsjV2ZW018uRtnkUENf2v6MYkS6aCXToGYAu3GcOZQ
         kJ1A==
X-Gm-Message-State: ANhLgQ3/ggn98ohQDdOyEW7yP5sd8XSdMh1bNKr9tHzB4neGDAsPfVrZ
        RjOinfS4RcL2CJz07YBBAw==
X-Google-Smtp-Source: ADFU+vuY1E3rPvi2pXUsd32GlxgjEnTZz42NF9oeHquVvRsTdPF4ziEbeCb7z0ZUE5vT7X7YGYn5yA==
X-Received: by 2002:a9d:4b0c:: with SMTP id q12mr18866881otf.77.1583866159629;
        Tue, 10 Mar 2020 11:49:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v2sm3534546oiv.41.2020.03.10.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:49:19 -0700 (PDT)
Received: (nullmailer pid 16240 invoked by uid 1000);
        Tue, 10 Mar 2020 18:49:18 -0000
Date:   Tue, 10 Mar 2020 13:49:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the
 Beelink GT-King
Message-ID: <20200310184918.GA16177@bogus>
References: <1582985353-83371-1-git-send-email-christianshewitt@gmail.com>
 <1582985353-83371-2-git-send-email-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582985353-83371-2-git-send-email-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 18:09:12 +0400, Christian Hewitt wrote:
> The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
> board with an S922X chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
