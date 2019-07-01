Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589C92A026
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbfEXUxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 16:53:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40558 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfEXUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:53:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so9885906otq.7;
        Fri, 24 May 2019 13:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06rJ2oOKojiLBVVks+8FBspxtuNBQL8fyHUzc3BCuBc=;
        b=bL3pATx4po7/noOwGUGuGmNP4ctU40K9SnxfpNv2Iy8ucfjFxG+19xwFw49JeXWL46
         tJBvJdr8cHcIU0MkeujORGnlaxJgfyo9pwSTa+njiz4U3T3iXg90NVmfcL0jjyUH7/aM
         4hwRK7X7aH/4lpIx+qXNdtBgSLnXaxSDkbmnJMxfO0k/jQhHBkrADZ0QaAIEUFiCVWkh
         0VyAUjn7KKuwA3XT15Li6DTacixokUoxblg0tBCMezYNHK8FGF34+8C6RT0m6S/Skb8c
         tjrw3zb9ra3TKW/CbNYSjD2we9JsLRH/YWHL8Kb2Mjg8tsoWq7vJXWrEUe8EYxKPeyXS
         pRIg==
X-Gm-Message-State: APjAAAXsYAWznAjo49smzvBov5H2K4XKbFbWAhUTMIzMRG5eARWyS1A9
        vrQIVjaZloKT2YZd8P2rJw==
X-Google-Smtp-Source: APXvYqzGG5lUSWgq/o6kjQnGmXFXXA5GlptnL5Pce4GN5KDh99a83PbpqEWkdGObCFeN8Kbml7X3AQ==
X-Received: by 2002:a9d:1b67:: with SMTP id l94mr64169216otl.239.1558731216665;
        Fri, 24 May 2019 13:53:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm1457839oih.45.2019.05.24.13.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 13:53:35 -0700 (PDT)
Date:   Fri, 24 May 2019 15:53:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Puneet Saxena <puneets@nvidia.com>
Cc:     robh+dt@kernel.org, pantelis.antoniou@konsulko.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        vdumpa@nvidia.com, snikam@nvidia.com, jonathanh@nvidia.com,
        Puneet Saxena <puneets@nvidia.com>
Subject: Re: [PATCH V2] of: reserved-memory: ignore disabled memory-region
 nodes
Message-ID: <20190524205330.GA23430@bogus>
References: <1558522031-549-1-git-send-email-puneets@nvidia.com>
 <1558522031-549-2-git-send-email-puneets@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558522031-549-2-git-send-email-puneets@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 16:17:11 +0530, Puneet Saxena wrote:
> From: Krishna Reddy <vdumpa@nvidia.com>
> 
> Ignore disabled nodes in the memory-region 
> nodes list and continue to initialize the rest 
> of enabled nodes.
> 
> Check if the "reserved-memory" node is available
> and if it's not available, return 0 to ignore the 
> "reserved-memory" node and continue parsing with 
> next node in memory-region nodes list.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> Signed-off-by: Puneet Saxena <puneets@nvidia.com>
> ---
> v2:
> * Fixed typo in commit message.
> * Used "of_device_is_available" to check "reserved-memory"
>   nodes are disabled/enabled.
> 
>  drivers/of/of_reserved_mem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

Rob
