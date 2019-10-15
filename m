Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0552FD7FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbfJOTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:20:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41017 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfJOTUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:20:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so17959332otp.8;
        Tue, 15 Oct 2019 12:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+oOVcTi5TNY4VogBo/JaAuINBgvnutAyJtQop7VD0N4=;
        b=nRchP4dHkqpCi4jLrmRrynARfOul2tE1FIdA+sBqU8upQTaqzbG06NSILSVz1jjERv
         xVAzZ/n6E8yPTxI5zS33g1urRT22KU0PCpfE+BacWV3U9KnfdiPEVLKOXNblbe6AiRCp
         5ibOreb7mNHw8Di71AuXvTJP3HpBClR2C4apixPisoJmcGrqZ+2ur2LHcPa2cnZS15zb
         UQWyc0wuG2xpBKiptKGqKbm812NbQV9J9YKqYCPkQVQXMt5JcVuvK7jfIUD0e3/Rnbmb
         OmRpXAoF/wTUV9r50JufL0E/x2LhA9hPb7Am2SXzMHH/4mIT1wSsTHiHTXjksSpNgHDa
         Q/HA==
X-Gm-Message-State: APjAAAUQt0HE67ESde5bh4+brLNLTm2QqNtFNSeb8g33+DobYPLXEnoI
        qKOOb/n+ZsfKqc4AjFUv1g==
X-Google-Smtp-Source: APXvYqymw2gd99WpAtyL7TZ3Rpm02EYujZK7f1nyw1Pl2Wxu+9ZsHyfXjWccCMkmAsMB4SY5pVHcDA==
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr28552182otq.31.1571167211298;
        Tue, 15 Oct 2019 12:20:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z5sm6518336oto.77.2019.10.15.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:20:10 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:20:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH] dt-bindings: usb: rt1711h: Add connector bindings
Message-ID: <20191015192010.GA25405@bogus>
References: <20191003032232.115832-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003032232.115832-1-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Oct 2019 03:22:32 +0000, John Stultz wrote:
> Add connector binding documentation for Richtek RT1711H Type-C
> chip driver
> 
> It was noted by Rob Herring that the rt1711h binding docs
> doesn't include the connector binding.
> 
> Thus this patch adds such documentation following the details
> in Documentation/devicetree/bindings/usb/typec-tcpci.txt
> 
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  .../bindings/usb/richtek,rt1711h.txt          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
