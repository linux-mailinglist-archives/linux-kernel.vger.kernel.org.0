Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6517025C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBZP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:28:41 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39530 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgBZP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:28:41 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so3395644oij.6;
        Wed, 26 Feb 2020 07:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlkjZTSr9fdFqEh+9gk6N9q+6soYx8xTnJAJEU7FsTI=;
        b=OwQbPsHMtZfDq+8eqG2+c8fbEAWPWE6MSIFp6GWaHvFrdPJz9fgBK9nd3I932/uKsT
         xKK3QO8cFQDrubTW5wJFBn0YLxZFAdvLR74znmIP/UDvgnAsauTMWdNLWgynFLerKDOm
         bxUSLCXfw9qdyLlc02Zvfcoqf5EdyLXPXsDC1SUprK2J2EMEYOJGJMbeAc+kBwkhwsPT
         oNTPzuCEkTmLCgldk397ibm2GDrkJqRb+mrmBi+NFooghUQibcRA5n5E1i4F8trNjuzT
         yn6lH7KLqcMq7l/DB9ZyEQt1lpSAywr5KVTtP+5fKoOUUKBQydQQMgQlP7gizZzOIiiT
         SD9w==
X-Gm-Message-State: APjAAAWJ4shYQ6+rmjbuKQ6iqVBr8SeAAQM3LsNidyENk48Ki37er3hq
        Kb1GN9L8tUlGfZDWqRpRYA==
X-Google-Smtp-Source: APXvYqyeVeFdUuQsfcVGuraxTUJZVUbXtdycuNGtDLE13wPX0iiriPR0yM5gO+qQysu9jWjAdh5Y7Q==
X-Received: by 2002:aca:cf12:: with SMTP id f18mr3661259oig.81.1582730919986;
        Wed, 26 Feb 2020 07:28:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j13sm907194oii.14.2020.02.26.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:28:39 -0800 (PST)
Received: (nullmailer pid 3981 invoked by uid 1000);
        Wed, 26 Feb 2020 15:28:38 -0000
Date:   Wed, 26 Feb 2020 09:28:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 06/10] dt-bindings: clock: Add MMP3 compatible string
Message-ID: <20200226152838.GA3910@bogus>
References: <20200219073353.184336-1-lkundrak@v3.sk>
 <20200219073353.184336-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219073353.184336-7-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 08:33:49 +0100, Lubomir Rintel wrote:
> 
> This binding describes the PMUs that are found on MMP3 as well. Add the
> compatible strings and adjust the description.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/clock/marvell,mmp2-clock.yaml  | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
