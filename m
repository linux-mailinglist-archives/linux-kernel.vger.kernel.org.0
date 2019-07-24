Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03517405E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfGXUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 16:46:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44194 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGXUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:46:23 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so92377884iob.11;
        Wed, 24 Jul 2019 13:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/sPIhXsS6XIgPtbsRxAmrculmKk8MrSIf4t2TOmssc=;
        b=uRzCyI0eHXSVobS0LTK5gAihSqpebCvjN+GrL80qhI5/0Z+P5/r7PcoLxHyO3XPQ6O
         LFAf0Vc+C0ooSeXk67M+DMA44nPcxKcBmHDYHjNnP2lz9EiuCgpDTx5Bif8Ccoxo1ayJ
         4hi1W7QKmHrUivOcM2pz8wH9fsH+LOHfgLcYmJvBM5aTxwG6XxAQDs/o9UXq0WDbtIhB
         U06lxHcPv9U3uSoo5mm3ffx2rMisFMER+r7WyYahirTsReheYS3FVK8E7TSyWJlKwTSO
         pB2G1vcIevX/Z4gO3dn9nH6nGHjGyacqX6oJ24yU8arSQyDI83oFMfWNkjlUC7BUwDoq
         3f8Q==
X-Gm-Message-State: APjAAAX2V5Fjdbr8J6/+aY5VnhNpI1bn7/RN7itf6PuBXjFMCwyIahYD
        e+cTeWrfEhsX3sug0sTLRw==
X-Google-Smtp-Source: APXvYqw9E2+Xf5qC0L6WngTKBG5qk+vwpnwnE3u6JWu5EifnJzjQKu0ViuEr6sIw7lDkl19v0HzYpQ==
X-Received: by 2002:a02:b90e:: with SMTP id v14mr49286701jan.122.1564001182328;
        Wed, 24 Jul 2019 13:46:22 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id x13sm35133832ioj.18.2019.07.24.13.46.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:46:21 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:46:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v6 4/8] clk: mediatek: add mt6765 clock IDs
Message-ID: <20190724204621.GA13063@bogus>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019 17:43:40 +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> Add MT6765 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, mcucfg and subsystem clocks.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  include/dt-bindings/clock/mt6765-clk.h | 313 +++++++++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6765-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
