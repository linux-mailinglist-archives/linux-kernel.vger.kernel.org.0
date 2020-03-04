Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D28179554
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 17:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgCDQbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 11:31:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42301 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:31:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so2592925otd.9;
        Wed, 04 Mar 2020 08:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rFXkjTWHsplVbdF1oVVcfM4j+4ayf9BM6NdtGQfJExk=;
        b=JPM3XLOOinRtO8cA0ET0+e3lWbG2KJVgHKUq1+I/kUDDyrO66Ltz5YueAwKEBrwxCg
         AGwHxx+3UI88jmkzwhcWoLExfJne55KxMcZXe+aXOXCn+1MwMsyv4/IMDhSD9lTFYT6H
         eTU6q41Zsn+fbtMooFe+AIw9s+ZU6zS/fq4Vlb7StI48v+Kcts5O6qGFir2ctNY3Na58
         McrXC37JrEIjbu8kn35x3khqsVx5BCrdJjogbRlKenHQ9+0GvSBACoRzGWtPTm+i7Kn1
         GyFm76ctA1pdBrY/74f81D8ug29ccwaXzcNCgcZ2YEQ7aEib40zyE+fbRX4VW2h9QNSb
         qj1g==
X-Gm-Message-State: ANhLgQ1BlgCW+ZKuhDhmz6T4r9xSVTs/WWPbsYg15D3HpylqT4SLZVpZ
        HbfMNHNlwXeNr20zcrn9uw==
X-Google-Smtp-Source: ADFU+vu1QDyc1xCSXEIrcz7/NjjRmHetwn5Pi7gqrRpZiLN1BGuoB0i/i/2pvrzhj/J3rgDEWZp6Rg==
X-Received: by 2002:a9d:68ce:: with SMTP id i14mr3122164oto.233.1583339502993;
        Wed, 04 Mar 2020 08:31:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b2sm6697131oii.20.2020.03.04.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:31:42 -0800 (PST)
Received: (nullmailer pid 16517 invoked by uid 1000);
        Wed, 04 Mar 2020 16:31:41 -0000
Date:   Wed, 4 Mar 2020 10:31:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     sudeep.holla@arm.com, robh+dt@kernel.org, viresh.kumar@linaro.org,
        f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transport
Message-ID: <20200304163141.GA16460@bogus>
References: <1583201219-15839-1-git-send-email-peng.fan@nxp.com>
 <1583201219-15839-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583201219-15839-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 10:06:58 +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI could use SMC/HVC as tranports. Since there is no
> standardized id, we need to use vendor specific id. So
> add into devicetree binding doc.
> 
> Also add arm,scmi-smc compatible string for smc/hvc transport
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
