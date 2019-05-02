Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A1110AA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEBAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 20:32:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40108 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:32:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id y64so381380oia.7;
        Wed, 01 May 2019 17:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wgEIGrGukaLVLbtDeS6Wsag5jk/JLmHn7SpQXQlHSQ=;
        b=ik+WYiiF3GKr48FKeQSxO1YLTNiPahAP5r0S9VOyR4+kOVl7o7NcYUCq4pkbjsTkwO
         4OyNgPVjmNniX6LIFUtrXoLSX3Ur3nI67EJUVjSTvIvHLPq/4YTFMKNyKTow1ipKHaM6
         jaAhZ4O1aJQhAH+azrT7hxQ6wGBDCYwo0ANGWs203F5xURDXoXJefHBSOy2Ei/++pRM9
         RhNgqDt52XiECrEsaZCWELjhQlEFDwYr0saeKseu5qttGd2bOoVf55bSFAGXz3p8rIaK
         fsOahtnNzzwurculiHT/XBORDvlRPBSCzjqE/RBPQsf6Ff6zSCG3pHxZ1t0ZSERwxbBf
         MvqQ==
X-Gm-Message-State: APjAAAXFzedoLWskq3yfTww4XczfeRZoW9SpmlWKfODMblTMz7gB3Opc
        322QQTb6Jbfi4nhZre+eIA==
X-Google-Smtp-Source: APXvYqzwJP1UnuiC0wbqjICyUhnBVsmSW0ZOcUAgKwu4Kq1ydsOwGYCuEPGm+p/lCUcchgBvgdcxtQ==
X-Received: by 2002:aca:c553:: with SMTP id v80mr665228oif.43.1556757166989;
        Wed, 01 May 2019 17:32:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm17659810oii.58.2019.05.01.17.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:32:46 -0700 (PDT)
Date:   Wed, 1 May 2019 19:32:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: usb251xb: Add US lanes inversion dts-bindings
Message-ID: <20190502003245.GA19265@bogus>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
 <20190424211208.17499-2-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424211208.17499-2-fancer.lancer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 00:12:05 +0300, Serge Semin wrote:
> Since a separate US ports lanes polarity inversion property is going to
> be available the bindings doc-file should be updated with information
> about swap-us-lanes bool property, which will be responsible for it.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usb251xb.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
