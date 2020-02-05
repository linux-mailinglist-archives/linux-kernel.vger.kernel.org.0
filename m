Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74D315358F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 17:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBEQsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 11:48:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55634 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBEQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:48:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3224405wmj.5;
        Wed, 05 Feb 2020 08:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sg+9y4ZuDI4laj7uyhA1zY5m32IMeo2ETRsWzCEEVrk=;
        b=ByfUCqp8NWXvLJvN/PucWoNvvRNNAu1veqKLyPrUoJ4kYwvb3uwpUk53ECIsoC19J0
         BUUk36nKl00iq5cfrtXlCoMYniEUqigN76jtgpBwaywkGkp+6mzFUspQP3V0C45gZIK6
         Obc6b53L6xF51ONl38zjfiyRaCcupqT8Mw+1DhJDgnRfZAW9o1aAJNdkgqZmAuM5NeX2
         xBaujovvRn1/FMvWHMk/sBZ6YEA4uXSks60orCDAv+KhkTdYwo7Fj6pDBySopVjt9X07
         53V1w7kvq+zFyBtTgjNKrE3WEHmnsjpLi93q6ddtDwAY3/yXgRDTQXgSjp1qsdpxLzj5
         paDQ==
X-Gm-Message-State: APjAAAVVhCYi6Hptw75TMdObozbpdfjlHNJOx9wUrZJXdowrY466EB7t
        8nrNrCvUQewl1U7wDovTFw==
X-Google-Smtp-Source: APXvYqwMtUlQEaUDNrfzAKaMRiKiWvrZGJX2RF0Ip2aB9NqMpVgSSfmUtf5bgXleEXGsJ6mGhtAd2w==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr7218951wmi.91.1580921280285;
        Wed, 05 Feb 2020 08:48:00 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id a26sm203951wmm.18.2020.02.05.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:47:59 -0800 (PST)
Received: (nullmailer pid 23017 invoked by uid 1000);
        Wed, 05 Feb 2020 16:47:58 -0000
Date:   Wed, 5 Feb 2020 16:47:58 +0000
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Message-ID: <20200205164758.GA22823@bogus>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-2-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204145207.28622-2-james.tai@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 22:52:06 +0800, James Tai wrote:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  v2 -> v3: Unchanged
> 
>  v1 -> v2:
>  * Put string in alphabetical order
> 
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
