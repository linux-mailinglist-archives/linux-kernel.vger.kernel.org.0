Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9111BDC4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLKUS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 15:18:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36315 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:18:58 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so1092538otr.3;
        Wed, 11 Dec 2019 12:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+AjbYVe81id445IRCHw4sc3QhnupHYcQC0DKfgOWyl4=;
        b=gj1Fz1m5PWn/uHUpZWnH2kjE/xDUeywcFHVKWiLFShjxPTRh3EFmzF8FMWHFuBa5lG
         QoZoZ/LoVhI+dncESvoVIjqJIDRDWmqJEseyklmihhIrbiXniSVjdGURD5S4P4oF95Pk
         AUbMQk4Ic06Q5eVKGR+5Tl3VHUS/SzFNTMXK+Wem5h9VjyUmuWmD0bBZ0H9QjHsj1yFO
         1roDPTUQiuAquy/INYaEyvFO/fFo3PUF8nej7b3pcLo25oZ6khO2g1LC/pkCt5W7cTbE
         vWA2Hk50/eYqldZAI7ljJ18GCZgd06nBoeII+lQyoPqfkDsOUat2OtEa9H2LRcmY5PRR
         GQ+w==
X-Gm-Message-State: APjAAAVDydhcEaSWtp7e6O4TWzfTjCJU+XYH4Wb4fpwX4AfURlY1wlap
        VbcihbeD0mzQGVdTiFBuuw==
X-Google-Smtp-Source: APXvYqznunUbR7oF2r1dbhFboADVIVzm7KH/u5XZUN+OnUNKs9Vda8T+dTnrvR61AOHDLb7r3NSlFQ==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr3651300otg.2.1576095537130;
        Wed, 11 Dec 2019 12:18:57 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm1145655oia.58.2019.12.11.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:18:56 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:18:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: refcount leak when phandle_cache entry replaced
Message-ID: <20191211201856.GA21857@bogus>
References: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575965693-30395-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 02:14:53 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> of_find_node_by_phandle() does not do an of_node_put() of the existing
> node in a phandle cache entry when that node is replaced by a new node.
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Fixes: b8a9ac1a5b99 ("of: of_node_get()/of_node_put() nodes held in phandle cache")
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Checkpatch will warn about a line over 80 characters.  Let me know
> if that bothers you.
> 
>  drivers/of/base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
