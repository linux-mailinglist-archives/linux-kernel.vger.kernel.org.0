Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9DF180787
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgCJS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:59:57 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36562 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:59:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id k18so1960586oib.3;
        Tue, 10 Mar 2020 11:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptx5WrEqMj8ChwfbIT/3T1+w1q+nwH6s5pImyQy4SnA=;
        b=pLNM2mABsu3XYe4nkE8vr6k0B5khKXyJThGBanJ5vyVimUUmg+QnK3WwB0w9aZs1bv
         rzKxEj7g4j8I8N5egyDriTz1YMAFiwILuoSJf1qe/LqkUqYjfYbq1LjZkxy/WzSbuBUg
         NMDXtlkpKWUdnnfvj5A0cBMWsp3J7KkF08gli3WxIV+7fLSw9pmXIAIA3BYwZu56ijaj
         lv7RKbfeKJC5ScEF1ug3QFih26+XQlDY565ygMnm65hIxnBX92N0z1c72+WCpXIpLdzx
         oCBRgxZBnW0IOq+oM4F+xzPFZBbYdMPgRnw8FRB9ezdVLLhUduT7g7WMmWSvEGNfDGXx
         xtTg==
X-Gm-Message-State: ANhLgQ076ZmIM4EOlCD+hdu+Xb0anZfMPPCTFJ/0EdBlpa4v4QA62Sn5
        FGjHaE52Ie72iA9bLLPdUA==
X-Google-Smtp-Source: ADFU+vvN6GDhTro5nK0+rHJsZkUlb/MbNtLqDxIxxZhQuJR6uGPF1cnMz4xazTrFsG+NiHskw3fT3g==
X-Received: by 2002:aca:5408:: with SMTP id i8mr2233293oib.157.1583866796263;
        Tue, 10 Mar 2020 11:59:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm2707305otg.43.2020.03.10.11.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:59:55 -0700 (PDT)
Received: (nullmailer pid 904 invoked by uid 1000);
        Tue, 10 Mar 2020 18:59:54 -0000
Date:   Tue, 10 Mar 2020 13:59:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Tanix
 TX5 Max
Message-ID: <20200310185954.GA811@bogus>
References: <1582991214-85209-1-git-send-email-christianshewitt@gmail.com>
 <1582991214-85209-2-git-send-email-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582991214-85209-2-git-send-email-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 19:46:53 +0400, Christian Hewitt wrote:
> The Oranth (Tanix) TX5 Max is based on the Amlogic U200 reference
> board with an S905X2 chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
