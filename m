Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7258A1785B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCCWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 17:37:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33201 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCCWho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:37:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so89586oig.0;
        Tue, 03 Mar 2020 14:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QRrz4U/hUD8JdGIzknzghXTEGOx2fMtenx9l1J/HTgk=;
        b=AvR7qW2gb+3ouHZnJxV7vTm5g8LbtgC4ykcc9Z9cHdDeduIMysimsNM15oPIqTHJZ9
         pVg/B7MjYBI9SaNoDTfQ85xsA53uu8H68Its//EHvPbgMmL90CLMwNamzvZoljMHl8by
         WTFtdGR7oOx+kncePY/FVtsahGP3EzsGWr3UK2x9v9MxE4DGX7tVkWIlHFFqaCV3FfeF
         Fhup5HnAdMBEfJ1IzyGNv1ndO6gvJ6OaKIU4iKFEBNh9uJPrrcbIOVxBnoyH4FbR+t61
         Yce/tP7mcGKj83ANGSYMllIFnmgiyvGq9WckmOKGhs9Fuv3bRRNAdHdfY+puBYRBA0EF
         WYXw==
X-Gm-Message-State: ANhLgQ3GZKbp6S+2Blp4PA6VzJpWF8Nq8RcoZZDGO9wjTH+3UZPFLccI
        UDuUW99U2CBppqmp3HUu5w==
X-Google-Smtp-Source: ADFU+vuYN3P6DEkf554SWGL2CX0kcuu1YRq1rNKiSQx57b/A4yfIQEDeAocfsyA5LEN4mASP5C2rBw==
X-Received: by 2002:a05:6808:658:: with SMTP id z24mr565050oih.91.1583275063485;
        Tue, 03 Mar 2020 14:37:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm8358412otq.58.2020.03.03.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:37:42 -0800 (PST)
Received: (nullmailer pid 18796 invoked by uid 1000);
        Tue, 03 Mar 2020 22:37:41 -0000
Date:   Tue, 3 Mar 2020 16:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: zii,rave-sp: Fix a typo ("onborad")
Message-ID: <20200303223741.GA18714@bogus>
References: <20200227155500.13594-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227155500.13594-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 16:55:00 +0100, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= wrote:
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/zii,rave-sp.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
