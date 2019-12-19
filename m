Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F70126B56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 19:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfLSSzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 13:55:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44840 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfLSSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:55:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so5829048otj.11;
        Thu, 19 Dec 2019 10:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXgmx2Ya6ChzyKkm+w7jzvBT8XbvFcpO0BqUgNxYIdk=;
        b=LsOlbLSl/Vnrx0vUjwoh2gQsGuS+XuvDkEspbSE0XcxVvQak+wWUa9WeFefkfDlX+o
         2R6OwnuvafOZPRm7ee9T/TcpLt8N1SqmMyYUcn1crA0UPppZBNZxLQ6XqFVthE2nYKGi
         fyZFCpYyp8ona297yoS4gKQyAaaD/Xm21YFI8PiDMDO50eh8/KwiVrWM1shTADl7EYfv
         +u+Il0a1kAGL8V1DadtVfMSg2LIsebSNYboUcWN/mMNKlYSuCdcOpTScykJ7owdYMUJv
         YlWWLjKEtXfOjtUaKXzBg9V9AcvX3ancAKXyRiYKhfc91M0t+T3FWqMwxrXUoNFJrNEL
         ceuA==
X-Gm-Message-State: APjAAAWZfqdXTpTYMdA1KOdm149cUZTSTEQOQkEAMChVS0txPNnXNJa8
        R8Ybuo2Tq2Y3/po/EFXGVQ==
X-Google-Smtp-Source: APXvYqxeB4DOtUVYcpXXJFu5X4OixvgM6U/N50o8s9FjCHRYhR58jeSq3kd209OlqlF1nvQCEA0K2A==
X-Received: by 2002:a05:6830:1047:: with SMTP id b7mr10714492otp.77.1576781751311;
        Thu, 19 Dec 2019 10:55:51 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id e6sm2414722otl.12.2019.12.19.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:55:50 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:55:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, hhhawa@amazon.com,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        tglx@linutronix.de, khilman@baylibre.com, chanho.min@lge.com,
        heiko@sntech.de, nm@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dwmw@amazon.co.uk, benh@amazon.com, ronenk@amazon.com,
        talel@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 3/6] dt-bindings: arm: amazon: update maintainers of
 amazon,al DT bindings
Message-ID: <20191219185548.GA4637@bogus>
References: <20191209161341.29607-1-hhhawa@amazon.com>
 <20191209161341.29607-4-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209161341.29607-4-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 16:13:38 +0000, Hanna Hawa wrote:
> Update maintainers of amazon,al DT bindings.
> 
> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> ---
>  Documentation/devicetree/bindings/arm/amazon,al.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
