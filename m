Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3786116F0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 22:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBYVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 16:08:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38254 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgBYVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:08:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so894279oth.5;
        Tue, 25 Feb 2020 13:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YcXK2d/HNObTwr0I3OOYmF2ixmUF+zbcJyMaSLcYMLI=;
        b=K/eLoDPIfmh/Ql/YsDqioYbvcmUyXbe0gXafPjbcgXbyRTVWE+XvjWfW6ZB6FN3IWx
         NWCQSzqwKcev6H4XM1fOB6hVkDyPJ73H8tsz5gzkYZg/t5nXD8hEaWRa7hBayrv/qR+1
         WTZVADyEetn1Y7I8G1tZ2HcgiAo6HKGYHjrdmSEzpTYedmVD4QYygibh06cp+1URJ1+S
         dRidn6mBpFV11Y0WB7lAg23h9MHZdlHhTQELiOick45sZHk7eXnh9g1w+L/jq2LrOOzC
         K0yh06l5OrJbbQclp/gHpxOpzP+GkcttRxSELO3OffIdeHd4JmXRIugzRp4ACYddQuqU
         HoEw==
X-Gm-Message-State: APjAAAVZQ7kPFfUMYd7NKlmi+oXK8ESMGnSW5Hux2iCKc/nrR2ANu/xt
        7oNn1m9of1ZX6zLQ//oZmlLX0pw=
X-Google-Smtp-Source: APXvYqwKnMmf0Icu7p/ThX9TbfyLhc/rH2s+Hnl3NlaO+1ryh7LNYdLP1osM+tNj+tl8U5W0+UOwQQ==
X-Received: by 2002:a9d:7c81:: with SMTP id q1mr408456otn.112.1582664911711;
        Tue, 25 Feb 2020 13:08:31 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h15sm6095843otq.67.2020.02.25.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:08:31 -0800 (PST)
Received: (nullmailer pid 31660 invoked by uid 1000);
        Tue, 25 Feb 2020 21:08:30 -0000
Date:   Tue, 25 Feb 2020 15:08:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        Patrick Daly <pdaly@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lmark@codeaurora.org, pratikp@codeaurora.org,
        kernel-team@android.com,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [PATCH] of: of_reserved_mem: Increase limit on number of
 reserved regions
Message-ID: <20200225210830.GA31602@bogus>
References: <1582567352-4664-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582567352-4664-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:02:32 -0800, "Isaac J. Manjarres" wrote:
> From: Patrick Daly <pdaly@codeaurora.org>
> 
> Certain SoCs need to support a large amount of reserved memory
> regions. For example, Qualcomm's SM8150 SoC requires that 20
> regions of memory be reserved for a variety of reasons (e.g.
> loading a peripheral subsystem's firmware image into a
> particular space).
> 
> When adding more reserved memory regions to cater to different
> usecases, the remaining number of reserved memory regions--12
> to be exact--becomes too small. Thus, double the existing
> limit of reserved memory regions.
> 
> Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
