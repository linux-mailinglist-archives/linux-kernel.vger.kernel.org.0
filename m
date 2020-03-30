Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC51198613
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgC3VHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:07:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34615 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:07:23 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so19418782iof.1;
        Mon, 30 Mar 2020 14:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFhY4ASs+nrRWDCzVunQPKUFb3bIelB89N683NPJ1pU=;
        b=Tz0npkqoJ3l19zsgjAygMj16gg0mlTZfIZj9RFy3cCcqqlxPu28TxHY3i0rz5e2B+n
         RCKVW9Cj3p/GEYCt4vN1LVGEjQFdYdwSv/ZDUDVchAu6EcNoMT2fRGer6BBWjmON4is/
         kkhmer8gjbcDSJLpvCbwtR2PcYdNWzRNB6/MUZuY+BqNbfT8PhejxjFCNxrJBc6d0joj
         pQrGH8XtSMkVdT8eepcKHP2UEdkKTYfkN+7sLAKsGr/fH//YS59IQzMpLe7ka9O56TSB
         rdn2lgA+TEl+WUomlMKaHcdFAnY4pM5iXXGI7OVEPBnCBXvh3bTCWFLK9CeiAVF51MCx
         InGg==
X-Gm-Message-State: ANhLgQ0tlMD2k9oxLVDpOrRbIiCR1eSo0vP9JDNSIgedtxUrQ74ojp1b
        o1IwoupgdUnfYeIoholnDA==
X-Google-Smtp-Source: ADFU+vshZsl865DqEmGdlPGknft1UjTIfXlyoQCnH02llIqKLKK6OFoUUz9udQJ30GQ1Qgh95RHf0A==
X-Received: by 2002:a5e:8c13:: with SMTP id n19mr12291670ioj.116.1585602442111;
        Mon, 30 Mar 2020 14:07:22 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z20sm4426438iod.25.2020.03.30.14.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:07:21 -0700 (PDT)
Received: (nullmailer pid 10443 invoked by uid 1000);
        Mon, 30 Mar 2020 21:07:19 -0000
Date:   Mon, 30 Mar 2020 15:07:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/12] docs: dt: fix a broken reference to input.yaml
Message-ID: <20200330210719.GA9972@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <5a10b58afa9ec03acaaddbd7668899da674dae15.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a10b58afa9ec03acaaddbd7668899da674dae15.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 14:10:45 +0100, Mauro Carvalho Chehab wrote:
> The old file was converted to yaml, but its reference was
> still pointing to the old one.
> 
> Fixes: 7cef1079e3ad ("dt-bindings: input: Add common input binding in json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
