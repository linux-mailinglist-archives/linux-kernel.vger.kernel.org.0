Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36CA9F60C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 00:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfH0WX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 18:23:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39478 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0WX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:23:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so535831oiq.6;
        Tue, 27 Aug 2019 15:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ak1Ltzk+8Oi0R4K1Lp5OobPOn5sQccTcHrAqgoaftJM=;
        b=p++6cFWGEiuiDg6SYM3Ikj3RboitkDvXRmLJIuXRU32J6s1i6viBnrXGraHfGb/CsW
         gqlYrrt809mOLCMCmmV6/VMWh1vwWOHjPbDgW9lxRxAffkWalfqCSFPltHyuNJlnlBdZ
         hxO3IbVTcDLAAyumlI8ejE2mblIl45vDh1airnT94g9XvKdf7UruEA6cSmI5kAOTXgLt
         Lh+zxcR9EcIr37rxtwAGQtNZuMS7XxGYeBXo9NU+sLQL8+OVzepeLl5Y4wKTD/ARwVrk
         ImQLGJqO2gUbeTwJ8dqj3f7HdaHC28qNKdxhFhU7KpQyRTQysHVMHDeOS2uUcrnRSNm8
         dfGw==
X-Gm-Message-State: APjAAAXGKGr4+xm87xv2ZBOL3UvsWJGuQbhKMa35jGibXF6EZSYoKdK9
        UeraoyEr+UyHpw554S4Bjw==
X-Google-Smtp-Source: APXvYqxyIVVXcuN5TLs0dRB0WP2tIuaq4qbD4o0PU2O6h+sJ5p5TyK/Dqle5zHoPbA5V0Vc3+/trxg==
X-Received: by 2002:aca:b482:: with SMTP id d124mr714809oif.14.1566944635694;
        Tue, 27 Aug 2019 15:23:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a4sm245454otp.72.2019.08.27.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:23:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:23:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 04/20] dt-bindings: mrvl,intc: Add a MMP3 interrupt
 controller
Message-ID: <20190827222354.GA15294@bogus>
References: <20190822092643.593488-1-lkundrak@v3.sk>
 <20190822092643.593488-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822092643.593488-5-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 11:26:27 +0200, Lubomir Rintel wrote:
> Similar to MMP2 one, but has an extra range for the other core. The
> muxes stay the same.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Reformat the compatible property documentation to higlight the valid
>   combinations
> - Drop an unneeded mmp3-intc example
> 
>  .../bindings/interrupt-controller/mrvl,intc.txt    | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
