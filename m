Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAFAD7F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfJOTBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:01:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39224 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbfJOTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:01:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id w144so17789639oia.6;
        Tue, 15 Oct 2019 12:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDHyOUpqrv7nCNXxMncnfKZuhS0DDSRvQf7daN1HJps=;
        b=Rsgi0R16bI0MOssEoC9DGIjYgoI3F5oNWdQSk77wFW8PD2GwQUWmvscyqCI9yx8vVo
         EXRZLON8pnVE5c4CX13XbYBy15hE8ydL77Z3gZK7REwxGdGNhpbnCm4fS4LwXk39YFuP
         Dv1T7wjJ4c6uoytuQQHuVV6rEv209PyHZgmGpklj7okeV2eHZkbKN54M/5/hiwp8FeR4
         gnfqzfls8s4EFCL+3NcdGq3ykmhsOCZt+oFC85p4+grUypOgSdwW0d9nmmFIsadcNKet
         fB/0eSY8prxEc9y4+7Nwsv/lMmr2WVgfhj701k2PIkT3/vrK/lTdrKxTDdrM2HavkUVl
         bKgg==
X-Gm-Message-State: APjAAAWa0v8bmAxAjjK9mWYGJmH4mjGMl4t73DocTeEvhqpMlLkFUnsk
        mckah1qk9dPBQF1G86cvS2D9o9g=
X-Google-Smtp-Source: APXvYqzWSK8f7AUbAV3hUyGym4wGyacoh1czYoWtoJaS6CqSc2Sr8mD/Lh+uTddneZJ19P8nSkiI4Q==
X-Received: by 2002:aca:1c02:: with SMTP id c2mr41124oic.73.1571166063181;
        Tue, 15 Oct 2019 12:01:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 101sm7119645otd.18.2019.10.15.12.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:01:02 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:01:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     jae.hyun.yoo@linux.intel.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, ryan_chen@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, jason.m.bills@linux.intel.com,
        chiawei_wang@aspeedtech.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: peci: aspeed: Add AST2600 compatible
Message-ID: <20191015190101.GA29195@bogus>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <20191002061200.29888-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002061200.29888-3-chiawei_wang@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 14:12:00 +0800, "Chia-Wei, Wang" wrote:
> Document the AST2600 PECI controller compatible string.
> 
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
