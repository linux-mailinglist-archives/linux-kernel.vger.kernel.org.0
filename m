Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE17E8C04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbfJ2Plm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 11:41:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38712 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390107AbfJ2Pll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:41:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so9313782oie.5;
        Tue, 29 Oct 2019 08:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wmaHuM4Ke2s1q9WnAzV1ZhRUAkvBF3goEpAIjBiR5sc=;
        b=Pr407qKxPx1bmw/I4SZWcrkKs/OFK2Oq9drnZRegtXrvh5zKqDpD7xOFWevXJqE9+M
         pTbGC79amJZu7dob0a3Dd0ZU2WL/uGMow76GniReBuAwSu/MOf6WnFxlsRRUleL4xzuf
         nt9Z7ylQdwB7AqjNUoVk0xj02q20wEkVeMdO4EjMj7Jd86iVuKNpKmb1C0P65DMLO/GO
         X+WBhjQK6SKO6b2uz3Z2+jniTwEiLfrmhCHBx13gLajLYWZIYqnuSJ6JX2it2u4TvwFH
         OelbitjhlH+OVzcPgpLdKS9vvcZgQcmyU8+CSoKo0uDagMCDJUSKb0JNcRGRJWx6Krij
         hJ9A==
X-Gm-Message-State: APjAAAVYaQs8sYjbI77NhuVC+JbBF+IRZc8TVAlr2A2Z2iYIK41JzH+U
        KcNiGXDdhaDcxxQfqO+yjw==
X-Google-Smtp-Source: APXvYqx5jPhqK8HfOIYgiuuC3CdIAJxGUrr5q2AmzHtm5vu+4agDK3awrGIUDuk972iYzsZhR7YMcQ==
X-Received: by 2002:aca:3b8a:: with SMTP id i132mr4491682oia.24.1572363700364;
        Tue, 29 Oct 2019 08:41:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k25sm2447223otl.21.2019.10.29.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 08:41:39 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:41:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
Message-ID: <20191029154138.GA2409@bogus>
References: <20191021021035.7032-1-afaerber@suse.de>
 <20191021021035.7032-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021021035.7032-2-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 04:10:33 +0200, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Add bindings for Realtek RTD1195 SoC and MeLE X1000 TV box.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
