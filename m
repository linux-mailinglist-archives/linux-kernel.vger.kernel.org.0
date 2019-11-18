Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE76C100AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKRRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 12:50:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32829 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfKRRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:50:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so16143009oig.0;
        Mon, 18 Nov 2019 09:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=m+zIH/IG0yJ34gz7FceaYqYbcVm1Lpw2gLZ8+CneIHw=;
        b=VhmdTRbmbkPVFLlaQyLrrx5MF6EfeQnCiNcrru3EtBa4Kwh1YwN642h9y+MAw/t1pb
         2jdTKG9p7rf2QuFmYITIcgKmG05wmLXQG43+gZXrwf01+fWArDT0g+moq23twnEC/Clb
         SzNzXRXwBXxyeRc6lzEuxpIUJS6EsFhOb8aslRypSchEjjXmZk6u6xhM+PiOBgGMWVYB
         q+CVQimVaOqwrbbZG5XEGfDuM+9Dc+isNZAzofWgMP0q8orKwBr9HSY5UDE1O85pyNkh
         SV6gzJk5vkAynO1KiKHNsdFx4mu6RRBRP8r0rhE0Gi7VeQtSIf5Y8Wmjbp+QG7tbgNeB
         f0og==
X-Gm-Message-State: APjAAAWIzVx09YNKhytUv7uJFM18RrBJI0nAxP2cfVWYqe+dG1oOKHE7
        GzXUi/rhrSwjaN3cUAKA+g==
X-Google-Smtp-Source: APXvYqzHuGb7P4/K03GqT8yB/gdOLMP/NT8AbyGQ03WOPjb7hkV8hu1QetA9biLuOoEE4nOVEwD4pw==
X-Received: by 2002:aca:af95:: with SMTP id y143mr162897oie.38.1574099426995;
        Mon, 18 Nov 2019 09:50:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z66sm6593259ota.54.2019.11.18.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:50:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:50:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1619 and
 Realtek Mjolnir EVB
Message-ID: <20191118175025.GA24796@bogus>
References: <d655415326064b079b9d1d791024c725@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d655415326064b079b9d1d791024c725@realtek.com>
Content-Language: zh-TW
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 15:45:13 +0000, James Tai wrote:
> 
> Define compatible strings for Realtek RTD1619 SoC and Realtek Mjolnir EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
