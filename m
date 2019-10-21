Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8CDE9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfJUKoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 06:44:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42975 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbfJUKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:44:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id s20so3626407edq.9;
        Mon, 21 Oct 2019 03:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPk+zW2Uh1IyfLspnOq4VuQeoxXgENof6rMmo7roKvU=;
        b=bzGwabbzysTubX+bz/FaDSbWxk1paEmoowj7+p2x7qMlbmgcN3eys2v+1Wkjyb5IJ4
         PyWxbkeuBesri5+SKQiwG+Uzh8Ikd8GdSt5SeHCeFambAuuYiOBewe9NzExNdGqIWH35
         wxsaca5vS403mTi5PtycHdfk1i8OjZr58mEJbtdanDdHhTWsHgY34gzUHcCBMHutnIbw
         goc7UuAiBPf/xFTad7aVq2hxx18G74Jbixflq9djvtaNy+x7TvVZgrgrRiPveCL3tEIY
         xGgxAr9SlGU0Wtkrf5I6KWLwFDf6vl0igd7Ao367dNhrxf1jFOne1S6k+KY1U4MRV3yV
         +LIA==
X-Gm-Message-State: APjAAAVetwL7nIfQqh0IPrUK5X7MkPOQWqDu0rAv7/JwWRY+dNPaqX0d
        ZEq6/nTmbN2y3ygQyqOP4pI=
X-Google-Smtp-Source: APXvYqxczdOZjA9php0/5fjX3pzvJRLSyjTSCBTVq/E+8TAiiet/JvyLBINaMrU/Xqk6OHTP+Wjr7A==
X-Received: by 2002:a17:906:b245:: with SMTP id ce5mr21254799ejb.52.1571654644555;
        Mon, 21 Oct 2019 03:44:04 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id a3sm593650edk.51.2019.10.21.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:44:03 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:44:01 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: arm: fsl: Add more Kontron
 i.MX6UL/ULL compatibles
Message-ID: <20191021104401.GA2054@pi3>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-10-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-10-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:07:36PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add the compatibles for Kontron i.MX6UL N6311 SoM and boards and
> the compatibles for Kontron i.MX6ULL N6411 SoM and boards.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

