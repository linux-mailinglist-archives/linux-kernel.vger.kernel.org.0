Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42F154D75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 21:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgBFUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 15:45:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgBFUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:45:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id y73so60853pfg.2;
        Thu, 06 Feb 2020 12:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p3IMIbr/J9CTW2/B2PDo91i8UjkmasWwxiEZYW81UxQ=;
        b=rF0rqyQDa4P9YFcwRjqnRA0YMozYq0fcTwY67TcCRJDdrIDQMPh1ltUSjYvAeKwau6
         LeJyF8HmGsKRf+Jmmrm6jRofhv9zh6zyfxx3yGhLMmcJXm88MrIF+cW5Fn54H+dhPwLa
         NrAg8CaElGLvEYN5RTI1FYRI3sbTqAc60edagJoI4hfB9YWSTYTmtt9mXF8sH5+uo/QW
         ZIyZe1WeyzbEmfokgbo2IctLWbGEQrvSxh+im1q43wNFkQuVvxoLnR65tqlGWLZFTzgm
         7uvXvFyu1ic0PAl/Wds9zXxE8BIkeMNuQvV2O4EtVWSEbRafS6ulhlqI2aBkbriWl8mo
         1bNA==
X-Gm-Message-State: APjAAAUuCWNFyeUfpesue2AA5psmQcm+kBnvh/9jP6NfvugaC8pQIDHL
        FfqMEgj8XKM5i929JlMmIQ==
X-Google-Smtp-Source: APXvYqzPL+ZDB178qEFY2njUEyFS57NH70RPQPC702j/FcQGVNzk0fFb3Yshxc5YmsTqVemI7K/DHg==
X-Received: by 2002:a63:4c60:: with SMTP id m32mr5523373pgl.433.1581021936531;
        Thu, 06 Feb 2020 12:45:36 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id i66sm282634pfg.85.2020.02.06.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:45:35 -0800 (PST)
Received: (nullmailer pid 19744 invoked by uid 1000);
        Thu, 06 Feb 2020 19:10:57 -0000
Date:   Thu, 6 Feb 2020 19:10:57 +0000
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: regulator: add document bindings for
 mp5416
Message-ID: <20200206191057.GA19653@bogus>
References: <20200204110419.25933-1-sravanhome@gmail.com>
 <20200204110419.25933-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204110419.25933-2-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Feb 2020 12:04:17 +0100, Saravanan Sekar wrote:
> Add device tree binding information for mp5416 regulator driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mps,mp5416.yaml        | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
