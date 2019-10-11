Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE55DD42DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfJKO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 10:29:57 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43575 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJKO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:29:57 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so8144560oih.10;
        Fri, 11 Oct 2019 07:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h5fJtEFtuFWUvHJqhVRZ1UlcM18fQiX2JNGn59cu8yU=;
        b=WgyCOGznGOolF+pni2oprgBdcGgoNrB1OxHHFBqgamF28AbGU6cWzm7s3/7kqBsK7l
         NJlCYz3kAaeYoWEIQZGEy8tyquCK9HPVAwOd1hgA7zI+fMQdGppnoCeSgWCflCYeqAyk
         SaiM70Iahc9pMVndl8UZ3DL/1eZMMQOggibMQebrf7D78dqKWL/fPzB2N54BZ98hBJ1i
         9ovNbtoSHVmBsvH1A0AolVw98l4C1Q02UgUJBpTZth+2kpYyGIdsBGmfwMvWmOrORT16
         eZynVy8emloICgiYmBkCLJpgduIpr1Nn0od2tOzoswtfoH+Ky8tRF+DEEGKXr8wWFMNO
         praA==
X-Gm-Message-State: APjAAAVZKzqf3i6N1pfmCqhgfwpbhtG7uUFGWxS5eXy3cxMU20q/9KC+
        y0T8gm+rqpA4o/pxr0TA6ufynRQ=
X-Google-Smtp-Source: APXvYqz05OapU2prguSEcOrqwZWAQU1X1DxbQzFT40Q80aueTFtb/bR//kdv9SfBZWyms41o+zLBXw==
X-Received: by 2002:aca:490f:: with SMTP id w15mr12557573oia.159.1570804196350;
        Fri, 11 Oct 2019 07:29:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e18sm2707532oib.57.2019.10.11.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:29:55 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:29:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: add compatible string for
 Kobo Clara HD
Message-ID: <20191011142955.GA16526@bogus>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010192357.27884-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 21:23:55 +0200, Andreas Kemnade wrote:
> This adds a compatible string for the Kobo Clara HD eBook reader.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2: reordered, was 2/3
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
