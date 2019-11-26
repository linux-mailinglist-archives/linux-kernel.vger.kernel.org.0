Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DA10A46E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfKZTX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:23:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37980 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:23:56 -0500
Received: by mail-io1-f67.google.com with SMTP id u24so20186001iob.5;
        Tue, 26 Nov 2019 11:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skI18OSOG3tOe5e/rBZFvgJAQyhohoWZHb1LSNFGx0c=;
        b=EQ7jsinbhgu5Ez/VvPhjUFqgTEfB+1ChGhT/yQqvWm6hdIrp/YBORANj0yjMqqf2Dt
         MmOBPFFuoV4dLxAFZc1je2pp5KtQwI4Sv2+/BKJDQ4rIHoolZjM/9QdmjOuUb9VES5Gl
         S2FvKDJGEsVTNL36jFA1817cM/IbW7jQJbi/jphI2TF+Wg5mo0F+/LzjYP/K1856PNki
         Z4tyK8S8n2yN3nEfrFANaQ/Gkvu08yTHLDmlWGKZKUZCdiUp2XWea6roffvbkjC7MRC9
         O/T8kHxl9pXGoWM66YBh6yChymTUvKW4edM4kk0S/dS5F/bnMfxNXQDQslZwiaA/V5nw
         OsIg==
X-Gm-Message-State: APjAAAVTlatxXJX/3ka6gBNOa83ohGXt9zHjgg08DlPaVexr95C5d1bu
        HwfWGjiZQpNcGVz0Y2lXlQ==
X-Google-Smtp-Source: APXvYqylTll1KfCN6l2cxTEgHWx+zBAOAZp9HsL2RRYUHIbLh4kw2KqbUEKj9PEGsGmxRXnYVYdGig==
X-Received: by 2002:a5d:958d:: with SMTP id a13mr32050199ioo.144.1574796235815;
        Tue, 26 Nov 2019 11:23:55 -0800 (PST)
Received: from localhost ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p143sm154750iod.21.2019.11.26.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:23:55 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:23:54 -0700
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>, geert@linux-m68k.org,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH] of: overlay: add_changeset_property() memory leak
Message-ID: <20191126192354.GA15179@bogus>
References: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574363816-13981-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 13:16:56 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> No changeset entries are created for #address-cells and #size-cells
> properties, but the duplicated properties are never freed.  This
> results in a memory leak which is detected by kmemleak:
> 
>  unreferenced object 0x85887180 (size 64):
>    backtrace:
>      kmem_cache_alloc_trace+0x1fb/0x1fc
>      __of_prop_dup+0x25/0x7c
>      add_changeset_property+0x17f/0x370
>      build_changeset_next_level+0x29/0x20c
>      of_overlay_fdt_apply+0x32b/0x6b4
>      ...
> 
> Fixes: 6f75118800acf77f8 ("of: overlay: validate overlay properties #address-cells and #size-cells")
> Reported-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/overlay.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 

Applied, thanks.

Rob
