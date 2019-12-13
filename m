Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A122711EC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 22:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLMVBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 16:01:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38169 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMVBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:01:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id b8so1888421oiy.5;
        Fri, 13 Dec 2019 13:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOxUGgicEuCv+hKKbBEUiThIOKvSQbqIIf6kqpfyaVc=;
        b=swhInsy5FbbZDT64urBsfBUuxZjnmwKqhK5BXganbfDuY4IJs/Y9Wil7am06/hh0gy
         zPy9RMpn/y8iqmXHWfnVBt6vhhOJ4Gc8JkDvgCU/u0pjfhfs6LkgY8TJugCDIcWxWUhe
         z1U/eY8iki5x2mxQCrBFVcYwdQX9JdVOrxayV+/t+OFDXHO3l/JLYnojBDTdbSgOFUSt
         xZs6GbBbUlO7PwZHy0OWy3NdExBdoBbdbw5IOTEnjb27AjxR0xf85rEHWqeo1kW/ccDr
         h8mdWMoZTv3EQf+fTCkWNsNEeEx3Ac2u2ut8hRn6E/lRGq1nYB5q76xDJ1jyoTPVRS/Q
         HPUQ==
X-Gm-Message-State: APjAAAVYF0a/B2angSwlbjSEkbffddiUiqnwRPGh9dD3DmzxMCWtd0OS
        xLIoXMKA43xX4b661xytrw==
X-Google-Smtp-Source: APXvYqyu5bi0OplQ8EqPYVfMSdVGRLNuQ2frsbckjG/8mRvUUzDsb55kQPsfvbWV4Nz+AJW/ejlSRw==
X-Received: by 2002:aca:c507:: with SMTP id v7mr8001693oif.157.1576270905038;
        Fri, 13 Dec 2019 13:01:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm3696429oim.13.2019.12.13.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:01:44 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:01:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Simon Goda <simon.goda@doulos.com>,
        Kieran Bingham <kbingham@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor: Add JHD LCD vendor
Message-ID: <20191213210144.GA18725@bogus>
References: <20191128105508.3916-1-kbingham@kernel.org>
 <20191128105508.3916-2-kbingham@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128105508.3916-2-kbingham@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 10:55:06 +0000, kbingham@kernel.org wrote:
> From: Kieran Bingham <kbingham@kernel.org>
> 
> Jing Handa Electronics is an LCD manufacturer based in Shenzhen, China.
>  http://www.jhdlcd.com.cn/Company.html
> 
> Signed-off-by: Kieran Bingham <kbingham@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
