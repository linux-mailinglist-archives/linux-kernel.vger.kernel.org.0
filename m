Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C07B18DB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCTW4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 18:56:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32797 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgCTW4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:56:07 -0400
Received: by mail-io1-f68.google.com with SMTP id o127so7761544iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=If8ZGUiYaRNsPj48As/65Y+MiI4TR33cXbEvCIdYniA=;
        b=I/J3oCLVmJ8GmXOBck1BMwPpneg8C2cyuNNqUn8vOzdtctsdZ0r55JA+qB8mr3d3uf
         VCpRMFfWh613zVGplIPA4lixxgU00ZjYvR/tyC/8lYZ1QUfc1Mt7es4fxI/YYJK1nIuD
         FTdDAYNEFHTddsttJrTJewQ0eUSvI/P83Bpo/yDSNGUJE5Z7S1gc4JspCofK7DspxVTm
         4VuZaOd0QIFXtTxK4bx28MDh8gP2CAVWAnymq22I5X+y5bzfv8tMROT4G19WOD20UMmM
         ECQhPOTavPrupHayGN18/PBSDfI6qvuEmb0W8g8+EsyxbM7gkFq99lmnugs+7n44IZTN
         sA/Q==
X-Gm-Message-State: ANhLgQ2BEjFa1fOBgQO0Y+zDkc4Z1dX1rukz1uwxmM1HMkHlG///3alx
        v+zWxaxeLVVRcgW5a0HFIA==
X-Google-Smtp-Source: ADFU+vvimgOh9nMdjOeQExAYUtVnr5XDKxKRBYQ48DdJMmrDzu2gfFgAP+2UBEehfBEpmTboFrheMw==
X-Received: by 2002:a5d:9301:: with SMTP id l1mr9713673ion.68.1584744965363;
        Fri, 20 Mar 2020 15:56:05 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h70sm1413733ilf.8.2020.03.20.15.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:56:04 -0700 (PDT)
Received: (nullmailer pid 24038 invoked by uid 1000);
        Fri, 20 Mar 2020 22:56:02 -0000
Date:   Fri, 20 Mar 2020 16:56:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next v5 05/11] dt-binding: ti: am65x: document mcu
 cpsw nuss
Message-ID: <20200320225602.GA23955@bogus>
References: <20200319162806.25705-1-grygorii.strashko@ti.com>
 <20200319162806.25705-6-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319162806.25705-6-grygorii.strashko@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 18:28:00 +0200, Grygorii Strashko wrote:
> Document device tree bindings for The TI AM654x/J721E SoC Gigabit Ethernet MAC
> (Media Access Controller - CPSW2G NUSS). The CPSW NUSS provides Ethernet packet
> communication for the device.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 226 ++++++++++++++++++
>  1 file changed, 226 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
