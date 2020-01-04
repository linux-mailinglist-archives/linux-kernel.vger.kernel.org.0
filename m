Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253D013047E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgADVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 16:07:48 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46638 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgADVHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:07:48 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so39314405ilm.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPOl0x7Aub5aLxVDzb4tsAOVCc/ocGDdfg2ZVh/x324=;
        b=VilaL6TqBOpTtf9YN62SYmP90D5HYUCjRKfHqEaoLVvJZlmL1cYu+Wc5y1IFJBHscL
         nLgdcKa6D2bwtLkXrRANNy9RQTaxG+9tyj3kqA/MAkqVKPfZJBdukiC5pYz2RK4IUfQ8
         j2I99tvRpT4x/0e314GAsttBKuklBZ/G/nKJrmT6/eKNI/Y0jApgPjSNeiGZR1PgzTb+
         6ckKHchJkSwgJTr6v4vwACDVDJVn2f+PVuvwaf/mQAmfZCH7bXfaWkeHznwKVteLY1RT
         ZkT4G1OfpTSa/aWouN5DPoJjurAk/IoYvkjhPfydHkCHnNH4Rv05KsHxfbqMjrE9IZ1G
         SD4A==
X-Gm-Message-State: APjAAAVvpFy4Hof6PZpBgRRAI+4BMdWkYMdlw1u59a1C8E4QajgpmvJe
        Z2jrLJbEqfz/gZsVV6roCCccLuM=
X-Google-Smtp-Source: APXvYqw8iE9Yu1MI8KuJFa7jTXFkSxOlCQnHn2X7/DjC2eq/wDU016F54zz8vI8GkJyf+shVe6tECg==
X-Received: by 2002:a92:a103:: with SMTP id v3mr81737491ili.265.1578172066645;
        Sat, 04 Jan 2020 13:07:46 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y62sm22397513ilk.32.2020.01.04.13.07.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:07:45 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:07:43 -0700
Date:   Sat, 4 Jan 2020 14:07:43 -0700
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Message-ID: <20200104210743.GA12979@bogus>
References: <20191228150553.6210-1-james.tai@realtek.com>
 <20191228150553.6210-2-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228150553.6210-2-james.tai@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 11:05:52PM +0800, James Tai wrote:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
