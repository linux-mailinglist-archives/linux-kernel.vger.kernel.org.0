Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B643712FFE4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgADBDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 20:03:09 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39918 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgADBDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 20:03:09 -0500
Received: by mail-il1-f195.google.com with SMTP id x5so38045435ila.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 17:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/iGc+RKtnsFuMU64/4qfZ200vWGywjrQ0igZLbD2L0=;
        b=pIj1bcYJ9S0DuNDP/5hpSjgF6j5q+vWFB4kSFeioLFCO01hcNCABQbNvp7N0l7anRm
         uSwuoYuLPeir9MT3+RfsuW9wTIMiZvzcB0ono/jgswch26Kr5SFXWu+wP2WGJdIvLbRD
         F8hZcBiLA3x5UmtFPrkEJ2MkL55/dz38qeCQkBjfgfSIH6xHv2FzC/woEBHTIVdsXeFj
         CsWKDb7JAxktiM0t5FfMfM1UYpjCe8Fschet4ycHSpQymiH3tFiE6CtevuEKTX2BRKLj
         NoghTkO60+L7ygzxkafiF2u9zKxgWt/MAf7pXxIf1F+5MKbH4sR+xiqxhqxdP9N3Y3M1
         4ptQ==
X-Gm-Message-State: APjAAAU3BXCWPp0YKrqyaQlKb8FlLESBvJiZM0g9qlvdKali0+qU45r0
        enuM/B/XEaqjocfIPg9oGXrjgRI=
X-Google-Smtp-Source: APXvYqyOIN+EpGdrdT3UzhFyy/Yxq4YBabLZTVQhvr2s4vIemWmrK0rh95DBsy/gY0XNdXQXvs9v6A==
X-Received: by 2002:a92:5805:: with SMTP id m5mr72823184ilb.59.1578099788029;
        Fri, 03 Jan 2020 17:03:08 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y75sm21415143ill.87.2020.01.03.17.03.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:03:07 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 18:03:05 -0700
Date:   Fri, 3 Jan 2020 18:03:05 -0700
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        biabeniamin@outlook.com, Beniamin Bia <beniamin.bia@analog.com>
Subject: Re: [PATCH v2 2/3] dt-binding: hwmon: Add documentation for ADM1177
Message-ID: <20200104010305.GA21152@bogus>
References: <20191219114127.21905-1-beniamin.bia@analog.com>
 <20191219114127.21905-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219114127.21905-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 13:41:26 +0200, Beniamin Bia wrote:
> Documentation for ADM1177 was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v2:
> -adi,r-sense-micro-ohms: replaced by shunt-resistor-micro-ohms 
>  .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
