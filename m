Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23CAE176112
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgCBRbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 12:31:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33071 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgCBRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:31:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id a20so80661otl.0;
        Mon, 02 Mar 2020 09:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nceDhubgEx2PRo1oS71egJ8r44PsaL0PBb2aHnuBV9I=;
        b=ssTHS2vNiRSr6ckobTQ9XZ6wQrsCnSTANQJ0Qz1/MpYkowb1TIQ8hN+OJy8oXmMCCT
         mMnc8VxCZxCJdCiU+0iPUtrAOCvH1kwBlKTsUkj+pUa8XyXFcuAiut1bjs/JOHQFo3wZ
         GM2Jsuhovd7htVPGlqse2Pc0LRmktNVDrPMwIppYWHGHzYcxsuLbG1MIy27fBX2knxdr
         pJUcDCwuROVKzFmxhjCNsYVHTx0Y/2YDR5Rd2yIkMD3v5+6Dc+Ypw1eRpe4chfoSg3mS
         pRkX1PU4sQqm1BwL97Rp9ZN4xOQSxVXxLbktNo+CBe6JVLmUx0m887/bImjWptAZ5xCc
         A/Tw==
X-Gm-Message-State: ANhLgQ1QAylhsVQMb0sa6Bq3Dn/Le/tpSE9u2rCnRJwgzJwDXGPfXRZ7
        PQDBv41hALnnWOk7VuMByA==
X-Google-Smtp-Source: ADFU+vsYNpUcWht2oZZ77lQyyjdI3vzZC8UuGlF/X5L1TTRZKoMYgTgmHOsRz1GxawFY8cTJ/sMouw==
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr236956otq.198.1583170306360;
        Mon, 02 Mar 2020 09:31:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s23sm1523341oie.0.2020.03.02.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:31:45 -0800 (PST)
Received: (nullmailer pid 13106 invoked by uid 1000);
        Mon, 02 Mar 2020 17:31:45 -0000
Date:   Mon, 2 Mar 2020 11:31:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH v3] of: overlay: log the error cause on resolver failure
Message-ID: <20200302173145.GA13073@bogus>
References: <20200228084027.10797-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228084027.10797-1-luca@lucaceresoli.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 09:40:27 +0100, Luca Ceresoli wrote:
> When a DT overlay has a node label that is not present in the live
> devicetree symbols table, this error is printed:
> 
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
> 
> which does not help much in finding the node label that caused the problem
> and fix the overlay source.
> 
> Add an error message with the name of the node label that caused the
> error. The new output is:
> 
>   OF: resolver: node label 'gpio9' not found in live devicetree symbols table
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changed in v3:
>  - add only the message from v1, but as reworded by Frank
> 
> Changed in v2:
>  - add a message for each error path that does not have one yet
> ---
>  drivers/of/resolver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
