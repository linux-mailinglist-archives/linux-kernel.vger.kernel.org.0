Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4D1345E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgAHPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:15:18 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37192 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:15:18 -0500
Received: by mail-oi1-f193.google.com with SMTP id z64so2913246oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MKeoU4FP/L/hIFVTYWRTXWHyDcNCL5GfbSqC8Dc1Ew=;
        b=RFNK40GDMop5yOhyZ/JUUzZ04mogwNJb+JN12gmbxA/961Mlmx2xm4fRV3oALFI7//
         XUob1RbMwIgPyetM6DpO//+TNAcd1AJVIwo6XbgnbAe+KrKEw0YWjMrPvcnERf0j1wGZ
         4j1UL9Wu7NubHseSBIX8TB1RnV3h5/tmwigcSt60JjfGagp48z/VAkHJxagAumQyOqrL
         QvPz6xVq04/R5KyVlLAQ4J0DGw4V7QnJ6911xtB6U3d62B43GNSeUQlyXOvb+2V3e2IK
         vrVH+nD8tfLt48OWo8ajCORo6ltjc+V9F+aSmoqeCMYlaIPytjQ4pkfVmx4U5BkAqUcH
         bOmw==
X-Gm-Message-State: APjAAAWEWXotqLe3/ZSEYoc28r2Cw54OKQcxWAdE39/CRvzQLPHYOLMx
        yXn6+Uz1IxHy2QmmIyYtp7XCVaM=
X-Google-Smtp-Source: APXvYqxkDlBKuD9XOdj0xdarnmgThziZMzKxFDXzt/BUaZjWDcvnNZiG3vPUqackGx2tI1sUR7fHOg==
X-Received: by 2002:aca:4ad1:: with SMTP id x200mr3249328oia.104.1578496517356;
        Wed, 08 Jan 2020 07:15:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm1174605oto.57.2020.01.08.07.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:15:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 09:15:15 -0600
Date:   Wed, 8 Jan 2020 09:15:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ming-Fan Chen <ming-fan.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Joerg Roedel <jroedel@suse.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: mediatek: Add binding for MT6779 SMI
Message-ID: <20200108151515.GA18724@bogus>
References: <1578465691-30692-1-git-send-email-ming-fan.chen@mediatek.com>
 <1578465691-30692-3-git-send-email-ming-fan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578465691-30692-3-git-send-email-ming-fan.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 02:41:29PM +0800, Ming-Fan Chen wrote:
> This patch add description for MT6779 SMI.
> There are GALS in smi-larb but without clock of GALS alone.
> 
> changelog since v2:
> Add GALS for mt6779 in smi-common.txt
> 
> Signed-off-by: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |    5 +++--
>  .../memory-controllers/mediatek,smi-larb.txt       |    3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
