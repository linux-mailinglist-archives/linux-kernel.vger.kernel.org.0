Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B611704CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgBZQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:48:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37700 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:48:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so165779oic.4;
        Wed, 26 Feb 2020 08:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jHw4ngjVXB8T2PU45eGKR13llpnjZ9TB1h6gXwWneRQ=;
        b=jhNLElVZc699qbYoDEW6WoRA9wVUpDndXwlG6JeOUp3zTvv0Z8iIdKwXskBhI+Yq24
         dueZYAQeHg39YkGBgf0yWwdtoX0VWO+HVsll28BWZ9agU1strllnJ9W5ub3QW6Y24vNM
         qK9uUUqECY2ZYV06/DHnxYNzZylb3ms22sAkKfeDwWSIVyaw9FRXD0O6aO36pADXQYqW
         9KHtHC6sMSGBDAsvl/t9JIQ6Bw+62N0x5bBphoYSU9aasQIOYXl7B8H0QKJ+gQaiHOXo
         gsfcTav7/UjcMVMblQpTu6Oot7UM56g5aOswm7UEO7t6m3k3rmdOcKG5q2KnmJ+d0J1S
         NnJg==
X-Gm-Message-State: APjAAAXk++NltWLUEq7rxaHIzuT9bXLptgPdxMOfByB5+TKMmIpJS9h+
        rvkirAszrGfv2aTrz3E7JQ==
X-Google-Smtp-Source: APXvYqx18Z/v/4iN8R6CZrp92Er0P2zNbyeqssC0LiTbHDTS1rfusrMZHEu4FappFe1fTYPGsU/aeg==
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr3791106oii.118.1582735722218;
        Wed, 26 Feb 2020 08:48:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm968900ois.20.2020.02.26.08.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:48:41 -0800 (PST)
Received: (nullmailer pid 20572 invoked by uid 1000);
        Wed, 26 Feb 2020 16:48:41 -0000
Date:   Wed, 26 Feb 2020 10:48:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        logan.shaw@alliedtelesis.co.nz,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v4 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
Message-ID: <20200226164841.GA20519@bogus>
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
 <20200221041631.10960-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221041631.10960-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 17:16:28 +1300, Chris Packham wrote:
> 
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> 
> Add documentation for the bypass-attenuator-in[0-4] property.
> 
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v4:
>     - use $ref uint32 and enum
>     - add 'adi' vendor prefix
>     
>     Changes in v3:
>     - separated addition of new properties from conversion to yaml
> 
>  .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
