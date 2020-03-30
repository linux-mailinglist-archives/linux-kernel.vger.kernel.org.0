Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0EA19861B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 23:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgC3VJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 17:09:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34261 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:09:46 -0400
Received: by mail-il1-f195.google.com with SMTP id t11so17365274ils.1;
        Mon, 30 Mar 2020 14:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=COOE7UO5NDI4mMF54C/5Y59lNCuCguuIGL5DhFc72gA=;
        b=AQdkx3JEU8meunJvaFhIMX4yPoX9Ob2pWEhPS8BXDP7xD51TXvrQmfsXW+DmzXqYDi
         Si/Wr0sXso3KI3lLJPi1fIiciFIn8zr2jvK3dEMT95kN+pIMTJj4RRkH2ZhJ0bU77OT0
         TOEHWw2kVk9DxxqQxDyYDEh6FWVNhBpwpDRJ/ApHM8qjO0KmVT9rs0xCBsYT50jEfCLa
         UF97BKLiQZhRetTgFCIqIlIxRHmh23q4Mq0g4SWiq2DxjdTyO8L/GG8h0ZBxxMGSRL7e
         ym6Ya6JTTkgXoSEypQGMGVaPBl2kHqhbyztBhrFFBDFDfGp6TL3hgnj98SP/A+TbsWwy
         +1Hg==
X-Gm-Message-State: ANhLgQ2J+xhKkODaMK8RAsGCPeSqgAc6eyfjtS1ABsWUjakEl6NYA8Bu
        XSN7yCnjv5sTZGgJAtQdMg==
X-Google-Smtp-Source: ADFU+vsaJ9mfFrdgtJM+MyHyE34Hx7/1lqQPWxHwKUvbnvXtcEuUU1LUbg978F2gwF9lLkefY7D9oA==
X-Received: by 2002:a92:a103:: with SMTP id v3mr13349952ili.194.1585602584993;
        Mon, 30 Mar 2020 14:09:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z8sm4538540iom.15.2020.03.30.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:09:44 -0700 (PDT)
Received: (nullmailer pid 13873 invoked by uid 1000);
        Mon, 30 Mar 2020 21:09:42 -0000
Date:   Mon, 30 Mar 2020 15:09:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: dt: fix broken reference to
 phy-cadence-torrent.yaml
Message-ID: <20200330210942.GA13777@bogus>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <afff684f552c7f3855439da3a0bb30ec5592c682.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afff684f552c7f3855439da3a0bb30ec5592c682.1584450500.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 14:10:46 +0100, Mauro Carvalho Chehab wrote:
> This file was removed, and another file was added instead of
> it, on two separate commits.
> 
> Splitting a single logical change (doc conversion) on two
> patches is a bad thing, as it makes harder to discover what
> crap happened.
> 
> Anyway, this patch fixes the broken reference, making it
> pointing to the new location of the file.
> 
> Fixes: 922003733d42 ("dt-bindings: phy: Remove Cadence MHDP PHY dt binding")
> Fixes: c6d8eef38b7f ("dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
