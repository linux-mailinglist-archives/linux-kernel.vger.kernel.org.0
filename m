Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED22BD4608
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJKRBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 13:01:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40000 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:01:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so8551661ota.7;
        Fri, 11 Oct 2019 10:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39fE6RD4L7ek9/ZP7eb4uAgC4lVSQDHBffdSIup/Xc0=;
        b=uWrvKw8ik0tMq2wuXoBiCXwaRTFuvKz7eyfZRSQU52Rn/PDHoB3SjXjDs1LtJgtgFt
         YZeKmf4Of+0f7k3mbIquBX1iHujiLQ7D4cVj0R8ItLreSUUZY6iCfMVctHckp9+NGUss
         diNzwv3CEuQ+W0/o8XOPWuvPBPFz/3xjnAd69YYjL2XFF02HuOyb9sZssKgQEhwyU4nI
         vZ+xlcvwCMv5UpSJLFNqGIuARobg5mjysvNVPNkYP5LOv6My7cRrYi0/7HlkYtJTrFPc
         wK4Yn9dJ29YgsTN2lL7xUZLs+mfn8HvasWjSXtmAH6RxEQVJXmkcqqjJLRn1qq44NyAS
         oYKA==
X-Gm-Message-State: APjAAAVeMWPvMBXPZNWRxEaRwlo8WoG6D4k8k5V/NvKT09sJjlHlAaZ9
        fTX7uEda4/1HROuVIGqylQ==
X-Google-Smtp-Source: APXvYqwqGqT7uiHwhdBc7sqpGqwD6vjshKpmaDTSjaMTHJz7K2u/gcWBWDVEgXQTXZ2+vioVbwWrOg==
X-Received: by 2002:a05:6830:119a:: with SMTP id u26mr13662087otq.166.1570813265021;
        Fri, 11 Oct 2019 10:01:05 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 91sm2915769otn.36.2019.10.11.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:01:04 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:01:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add AST2500 RMII RCLK
 definitions
Message-ID: <20191011170103.GA14903@bogus>
References: <20191010020655.3776-1-andrew@aj.id.au>
 <20191010020655.3776-2-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010020655.3776-2-andrew@aj.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 12:36:54 +1030, Andrew Jeffery wrote:
> The AST2500 has an explicit gate for the RMII RCLK for each of the two
> MACs.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> v2: Drop "_GATE" from symbol names
> 
>  include/dt-bindings/clock/aspeed-clock.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
