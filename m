Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F470C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfGVWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 18:06:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45101 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfGVWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:06:41 -0400
Received: by mail-io1-f67.google.com with SMTP id g20so77445216ioc.12;
        Mon, 22 Jul 2019 15:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRWJN0Pa0lu43wjFvqcKPLwhiVJDCNgY6Ir4WcVPL0g=;
        b=s/8mh4RtBosHHrJgksmc5cEffwgZgsKmUcS57OVAnglBhBaQaogtLUYFHmNPdN5iCJ
         b6Gxb5vRyMoCHAbc0pzBmYcJen5uRGHttnSnOrWISpXb+eDNfH9LWN8VBFBjGA6n+UHD
         ZlQwFoILmHhIq7vWohXn0SHs+VZ+QyxJpQ9e76peMtFiIQFHcL1+xvsuahEOUes8MqsL
         ygQMDsPWagFZOj2cjJ5rP71EP0IKVYQGbHf75dfC3az+XHh4sxMSUONMOdpX1RB7bEqy
         8sfA9veV2yJZK03LuCa5bV2jGHaci7JgCkybmxK4i88VJvcUMmDp4eJ+4LrRK35t+D7r
         r/cA==
X-Gm-Message-State: APjAAAWOAeqso2Uor7ddNzeWrdXZ2kUMu8GvJwfQEIK15+1/eXhgnVPP
        WpPmszunxkMWzE1h1BIWmw==
X-Google-Smtp-Source: APXvYqxYaQypvjgJjL4nEq60H2lrbcBokHTCk9QsZW/tkXjnakchPi/nUyMhPfg5PNswHH6iJPMjCg==
X-Received: by 2002:a02:1948:: with SMTP id b69mr76064747jab.55.1563833200601;
        Mon, 22 Jul 2019 15:06:40 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id r5sm37505920iom.42.2019.07.22.15.06.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:06:39 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:06:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com,
        christoph.muellner@theobroma-systems.com,
        philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org,
        scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk,
        tony.xie@rock-chips.com, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org,
        manish.narani@xilinx.com, olof@lixom.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 10/11] dt-bindings: mmc: arasan: Document
 'xlnx,zynqmp-8.9a' controller
Message-ID: <20190722220639.GA24419@bogus>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-11-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561958991-21935-11-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jul 2019 10:59:50 +0530, Manish Narani wrote:
> Add documentation for 'xlnx,zynqmp-8.9a' SDHCI controller and optional
> properties followed by example.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
