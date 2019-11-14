Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB0FCE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfKNTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 14:14:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33314 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:14:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so5861909ote.0;
        Thu, 14 Nov 2019 11:14:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kxLLQE/JqRR/Jbs96WVmwWzDnecL0QTETfc0TZ/qlQc=;
        b=bKHIRvJV0C5VC+tHNJ+/fy+EHdPih9wLOr0Pv3Ps4gaBfrM22gNVy9p7fU17wRVlJm
         G4f+W3WRn2ozEhmFrFtfzsHsKwTPz5Kd4dmS+dfQy0i3xnRoO2nShmliEtwqo4+2Xm5m
         S1kQJg02ASq8XMBT7Nfa9308/9sZdIgFwsfcvw/HbMcjf4Gc2vTVDYn3jH2yBqvtQQJg
         +6ONnvdItPT4CcYIoV7EoY8li/3gEtqvQiywzD11N3aSt4xx2qq7/RWqLwzQfsYH0fwz
         9Q63srKp1MmpwAoy2nlr8BbAjKHiVEQLAuBo4LJP4SF0z5tEvFDy7ZWEL40RS8zJmDuZ
         4+PA==
X-Gm-Message-State: APjAAAWizXCvZPboo//Zruq5hm1lzZNKI2JyLAUQM6GO3RQMcVLIeoBV
        BIiu+Lc3w2P6ZxfOk4BhiN2Ka4E=
X-Google-Smtp-Source: APXvYqyfJ87LD/QB5c0TMX/wIWoYP6o9C36/6w/reacZ6clzrv95SPvMKEP9+KvMr6GemvBs7XNNOQ==
X-Received: by 2002:a9d:4813:: with SMTP id c19mr8176906otf.337.1573758869585;
        Thu, 14 Nov 2019 11:14:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k18sm1965555oij.32.2019.11.14.11.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:14:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:14:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: arm: realtek: Add RTD1395 and Banana Pi
 BPI-M4
Message-ID: <20191114191428.GA8113@bogus>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-7-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111030434.29977-7-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 04:04:33 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define compatible strings for Realtek RTD1395 SoC and BPI-M4 SBC.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
