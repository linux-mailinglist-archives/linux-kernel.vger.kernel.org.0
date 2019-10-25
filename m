Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653F4E55C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfJYVVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:21:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYVV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:21:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id 53so3022110otv.4;
        Fri, 25 Oct 2019 14:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t2kppBEOgy6RnOJeg3mWNTbWNUIFFBZPEWBzlZe65iU=;
        b=EEmlV7BG5gzFll2Uegx3j7UU0kpLZnb0/VVrcLfZFGf+zm0CpY15akfH0BOkg9x8MD
         6jFtpaZVInPhXiYrQsjWA/7wgaA3RNkpIlLIJFQ1J9g3cccE2JmzSJ7vr3JcLaL4LJPO
         3fSp+GOFtqtLvOl6mYkp06BUXZBN5Ve/r7kQxoRGMnYHJ3HHgv46mD2eA09K/4GHnyq5
         9Zqkl1RN836wwOEzlLnxgprhR2xRRvyhU/A9r6iGohEtDVbcDJZUb+ppKJz1dG7y0HkA
         axTjDHXi6buPtfhbA1AhOl4M0NXOiWAXW0OyvcFXXOwmtnTrCspnxxv70srzyQpMGJJI
         PHRQ==
X-Gm-Message-State: APjAAAUDjVzEqIoUNzd5XJjhBLp0+a6pQYOG5DP3OlPgm9W4uf8vBT6m
        e/8weOCoBL+kH+heVgofHw==
X-Google-Smtp-Source: APXvYqzfALz/bSOT92RSeok6HEe+wg7/IAkKBr5Ut9pLPU5O+zQ3UDEKAg0PqDzo3TuhVW8gFCuqsw==
X-Received: by 2002:a9d:82e:: with SMTP id 43mr4568743oty.23.1572038488683;
        Fri, 25 Oct 2019 14:21:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b31sm1129632otc.70.2019.10.25.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:21:28 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:21:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] dt-bindings: arm: realtek: Tidy up conversion to
 json-schema
Message-ID: <20191025212127.GA4819@bogus>
References: <20191020040817.16882-1-afaerber@suse.de>
 <20191020040817.16882-4-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191020040817.16882-4-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2019 06:08:12 +0200, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Restore the device names for compatible strings as comments.
> Prepare for adding more SoCs by inserting oneOf.
> 
> Fixes: 693af5f3eeaa ("dt-bindings: arm: Convert Realtek board/soc bindings to json-schema")
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  Documentation/devicetree/bindings/arm/realtek.yaml | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
