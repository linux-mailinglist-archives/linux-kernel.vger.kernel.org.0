Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCDFB145
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 14:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKMNZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 08:25:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38576 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:25:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id z25so1576183oti.5;
        Wed, 13 Nov 2019 05:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zF4OrVOU8WtT6uwOS1llThZPK6g4CW7m4WLqSZ9QK+U=;
        b=k5qP6Smp44aSRMBG1oWc/lFEKhltE+ePuFno7B9eKQxYFZX4AxAqPxKGpny8boRE9I
         saI/2ujEuJy2FszjlE0Im7Me55vSU3Pe5zqaPHUC3s5vEb0omgRW320tk2IQ+hcpu9AF
         MKYAL2Ay8Dox0hQYcO+KkjYjqYCe2EBrlnHMABBvg3Rpf9q2gw/0iGI9yv1lAu5syKCB
         yWFpU3ZllH1ULIkIA5HS31B7x6ADK5mgFHTZDJWZMMiCGclhwrFacyywuzgDzHRnBGvq
         zaskrZgDTD/TQoxl3C0of27+8insNTqm7Q8vCiZLAzjbQY4dIlXdeafi1PWl5DZm5kEv
         XQmg==
X-Gm-Message-State: APjAAAWXJB3Ls0UQB0EnwNkyS/ZzrZfjJj6vuTIO9bCKefgoNewKZk8P
        QZeKEiaUt5RAWCsRBgFosA==
X-Google-Smtp-Source: APXvYqxa5oCymW1X33KicNWwWitm0b9BXVkar45AAp9n6f/mNdSb/0UQLBJjA7aAtBxOa+njKTY5Ig==
X-Received: by 2002:a9d:1b4b:: with SMTP id l69mr3085182otl.303.1573651502292;
        Wed, 13 Nov 2019 05:25:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 63sm704069oty.58.2019.11.13.05.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 05:25:01 -0800 (PST)
Date:   Wed, 13 Nov 2019 07:25:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] dt-bindings: arm: imx: Add the i.MX7D-SDB Rev-A board
Message-ID: <20191113132501.GA21993@bogus>
References: <1573092893-10612-1-git-send-email-Anson.Huang@nxp.com>
 <1573092893-10612-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573092893-10612-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 10:14:53 +0800, Anson Huang wrote:
> Add board binding for i.MX7D-SDB Rev-A board which is already
> supported.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
