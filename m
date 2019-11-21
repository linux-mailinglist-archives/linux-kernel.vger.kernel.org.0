Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F29105A74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 20:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUThq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 14:37:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38863 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:37:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id a14so4310698oid.5;
        Thu, 21 Nov 2019 11:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tMER4MOHixp2wY9ZjS4RrN2RrDNX7H+o1z/zXkM48ZU=;
        b=Q6RCCcByjVSTwLs6zjTOIOogAiyLZ88aGbigw4CCXGdpEBXhshluevOsoZdVvdXezw
         Nv4UHxtPTXHRBFmncvxRUMQiBqJaMzJFIwONlIt3uDBU2phtHHkXOjjV628nZegsXhYg
         9DZNV+Jnj1n9DYALod4ddSmyypviR5CR+qlQnAvBSQumgu+rc6lJYeMJ0iG0BlMMGypL
         WiV2EvM3HILbJT3D4CHtCvE/dk+pNQTOdBisWsxZDabDF0u6m20Wwzf/NWxs4t+sTRCy
         +NG585cjEx70sHR5KmyebZVPVyNn4L+UIsRlDPbwx4onIsM8z2Qq3BOC9hwCfHNbNU7+
         lKtg==
X-Gm-Message-State: APjAAAVZNWmFdo625UEW9ywLD+jrw1S3R8qudJNSB3/3j1tEIzR17ztp
        cK9Ro9yXOGSXJcG/yefSgw==
X-Google-Smtp-Source: APXvYqxz3r1XfhG46Xqzohy//cfJAs84lDW7vsquvPUXB2FPHrRH/1ETgZRryOu7acvqdws+X02tgA==
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr8823046oia.148.1574365065094;
        Thu, 21 Nov 2019 11:37:45 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e88sm1305777ote.39.2019.11.21.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:37:44 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:37:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: Re: [PATCH] dt-bindings: mtd: Convert stm32 fmc2-nand bindings to
 json-schema
Message-ID: <20191121193743.GA3627@bogus>
References: <20191121130615.13007-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121130615.13007-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 14:06:15 +0100, Benjamin Gaignard wrote:
> Convert the STM32 fmc2-nand binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../bindings/mtd/st,stm32-fmc2-nand.yaml           | 98 ++++++++++++++++++++++
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 61 --------------
>  2 files changed, 98 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
> 

Applied, thanks.

Rob
