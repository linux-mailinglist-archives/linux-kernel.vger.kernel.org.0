Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C748A126E04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLSTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 14:32:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45083 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSTcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:32:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id v10so3537816oiv.12;
        Thu, 19 Dec 2019 11:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/3+u5nfmJRUSjWuCZi9Cc2P4QvLSHbddWtWRoN34F7M=;
        b=Y0kjNxnNRgw9+Lt6snU7Z/pkdIWqZb6YN308RMEaN/gE0dW0esRJqT2VRKi4suQRTw
         xXibe4I8bzCxCkLXXLmEa1+81immIcWdfneQOs5Xr0FXIyknG/r+tR9FAljuwbZyBfqE
         FP414JLpNU9G9N+IGX/lkAkVs31u2quw8lgT1M6rQkNbhDcrMW0K3gQph40nMPftYI14
         NV/rh9ncx7toaIHF/Ps4qosPbus5g1pntT1fTJSJmrNbminTr4HznkiqVseKqlFBb04y
         n3uyQvZaWNQ62StpmEiq+Jnz8P3gtKC1vN8Mr+qff1n8lA97dYoZ80glXXJeO4W70ePI
         t5pw==
X-Gm-Message-State: APjAAAWpx+vTRSrb+E4pF7EIL3JPWx5qK1Fd0CVfDiUu4NFRZ4A2f0bV
        0pG21qQpKcWaJlABcGj19A==
X-Google-Smtp-Source: APXvYqw7KNOeV0JRcaYUuus1QiPtpU8AaUClW7xSRdDup6Vt0VeF3TS39xCOwBXU2dOiF4ei5XvVeg==
X-Received: by 2002:a05:6808:c:: with SMTP id u12mr1281368oic.107.1576783974229;
        Thu, 19 Dec 2019 11:32:54 -0800 (PST)
Received: from localhost ([2607:fb90:20de:fb54:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id e65sm2448415otb.62.2019.12.19.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:32:53 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:32:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 3/5] dt-bindings: arm: fsl: add LS1028A based boards
Message-ID: <20191219193245.GA20831@bogus>
References: <20191209234350.18994-1-michael@walle.cc>
 <20191209234350.18994-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209234350.18994-4-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 00:43:48 +0100, Michael Walle wrote:
> Add the Freescale LS1028A evaluation boards.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
