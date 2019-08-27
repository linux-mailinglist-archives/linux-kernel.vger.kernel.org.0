Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B0A9F12A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfH0RGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:06:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43750 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:06:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so19362390otp.10;
        Tue, 27 Aug 2019 10:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yb7OsvRoJ3pUmTC3nieNUsZv+jJ8H0pkWBr1pJcDLEI=;
        b=FbL2f6kM4yQz/YOJdliRSmInIJILVXDzeP0QxTAF/vVbMcSRXRM8k4SM9L3LO9GSOs
         g1WemaktECumnCgj6SWYf8lhQbE3/TnN74T4Tx9vmJd+1stGCGgzvIP+p0WhdnRSQAMd
         dn9ModkP85S9L8mBjriGaMPHsi9p0I6ELL6p2E2edyzPLWM9/uejOrKxDUKuHxqDFJZi
         C9Xn8LwEcSfvo5QT8V3NqL8F/x323MsW2IIpsI74n2HMPcSJPl6R1UK7vr0EttgvZz1x
         U2bTofH/b77lPXk+Li1I2B3uJTPBaiJLMyejPfEkz4QthDxK8tjFpLmp3VYwPBGd4JwX
         BKrA==
X-Gm-Message-State: APjAAAUJp6x7E+mF7bI9BBRzk92jgQx8pGvSjnqYkBlgBf2F4YO7lNoj
        5GvotJl0fGa26WVIQXaHXQ==
X-Google-Smtp-Source: APXvYqxN/blzNEpxMuatrg1y1bReIJVGv0mbRaK1UFr6lrK0MNRwnxCRcbDArmesumhflYNdAmNv1g==
X-Received: by 2002:a9d:5551:: with SMTP id h17mr21256881oti.194.1566925601070;
        Tue, 27 Aug 2019 10:06:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm5525773otq.0.2019.08.27.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:06:40 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:06:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/4] dt-bindings: Add optional label property for ina2xx
Message-ID: <20190827170639.GA18927@bogus>
References: <cover.1566310292.git.michal.simek@xilinx.com>
 <3c56deb8cc1842d2915b203e622be1eb442414de.1566310292.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c56deb8cc1842d2915b203e622be1eb442414de.1566310292.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 16:11:40 +0200, Michal Simek wrote:
> Using optional "label" property is adding an option to user to use better
> name for device identification.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/hwmon/ina2xx.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
