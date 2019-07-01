Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321832A0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbfEXV45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 17:56:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33563 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404259AbfEXV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:56:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so10043412otq.0;
        Fri, 24 May 2019 14:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ho8YvTqp0rATg7l+txR/qg/9Dte5oTGHToN5b94uwag=;
        b=DJ5n5whxSS/c3bDQXYbF2pxt+Hwm8GASO+NWPhkX0gq80t3lGLfk5Gyx0IYS9kZR8f
         vFuctPpOyFY5wz+rBdXd3lhRYHKXvf90ooWL1I3GaWUC80g92Ru3cUYKB19NbQA43Kr1
         APBjFGqhUWmtTzpIzzi/u4XuUGswyYa3KAA3k9QRP1fptCAGZ5ycOVH9iscxH9+c210z
         DcC5D+cGQdlG3QKmv13oa0cubHgk7nXoMh4xtEOl1xPcXBYEMQ0PFM1V2jDy566bB9nc
         iKVF0X/XI3YNprfT1H6zURfWAtAry4TF6HKLbtvTYuPl3P2/GmaDPdUdGgfyq0T3p6LZ
         aPkg==
X-Gm-Message-State: APjAAAXttStZWNAP22st/Pk2zyYlSF4yF+9pj659m8yAceUj40pyB7s3
        4QqNp/dZoQarnmIJGbp7Rg==
X-Google-Smtp-Source: APXvYqwNL/0FgdI+TnsnkddnX1osuGlQibiQd+IDZ28cDtbOtb/DaqZmuifSiFaX3pdWvLKsmpm92Q==
X-Received: by 2002:a9d:6b99:: with SMTP id b25mr41053536otq.242.1558735015676;
        Fri, 24 May 2019 14:56:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 37sm1345038oti.45.2019.05.24.14.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 14:56:55 -0700 (PDT)
Date:   Fri, 24 May 2019 16:56:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: display/panel: Add KOE tx14d24vm1bpa
 display description
Message-ID: <20190524215654.GA16085@bogus>
References: <20180412143715.6828-1-lukma@denx.de>
 <20190515160428.6114-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515160428.6114-1-lukma@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 18:04:28 +0200, Lukasz Majewski wrote:
> This commit adds documentation entry description for KOE's 5.7" display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> ---
> Previous discussion (and Rob's Reviewed-by) about this patch
> https://patchwork.kernel.org/patch/10339595/
> 
> Changes for v4:
> - Rebase on top of newest mainline
> SHA1: 5ac94332248ee017964ba368cdda4ce647e3aba7
> 
> Changes for v3 :
> - New patch
> ---
>  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
