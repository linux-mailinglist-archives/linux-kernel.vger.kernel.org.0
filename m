Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93A1054AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 15:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 09:39:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44901 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:39:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so3069304otr.11;
        Thu, 21 Nov 2019 06:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYYqbOVycEdgZHO+SXnt+K02+QDnVzkJ47TaoH1kdjg=;
        b=NWN+khUH0MexrV3NVPvl8hIickugu/e99ZmNsRY1zzEuR0PXbVJOnxHgJH8gu6HEMm
         iEK2nzgS44RSkf7pT4+oBlG/+4azNinjlpZ8XIUN1cwQh0kGFAxorO26Q1lSLiyDPReq
         TFCmWJNxzRnkgs9a//7fP/tXSyAoJDmTaUpxT3B4J33r8cZUJeCI9pcaI5we/KeHHgCs
         aF/IA3hw1snczecYOtE7vGKp3lWnpTU1NJN9wSgu4ATpQuzAfxhTUECG/cnlH+kmosxP
         Jrp0UiiaiT4QZi0OP519PRcHnyChUm5tYX4CZdUSFI1ltxo6FRbgVVW8aCm8tWFl+pt3
         2QHQ==
X-Gm-Message-State: APjAAAVi8C8mCUuHZpcfK0a/ULimwlFfwTeCVhOkXFzEuiQgUiYxQPyd
        y2ZVXzjGHEjAAGCMPWrJrg==
X-Google-Smtp-Source: APXvYqwUu/biujtjVLDWyb16pwLG4pruuYMM8CW4+uuGpATDphuBWh04Vk6lWGDYxf1mYwHiGV55vA==
X-Received: by 2002:a9d:b83:: with SMTP id 3mr6529158oth.56.1574347188483;
        Thu, 21 Nov 2019 06:39:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y145sm955719oia.21.2019.11.21.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:39:47 -0800 (PST)
Date:   Thu, 21 Nov 2019 08:39:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3] dt-bindings: mailbox: convert stm32-ipcc to
 json-schema
Message-ID: <20191121143947.GA25003@bogus>
References: <20191121095102.26693-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121095102.26693-1-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 10:51:02 +0100, Arnaud Pouliquen wrote:
> Convert the STM32 IPCC bindings to DT schema format using
> json-schema
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  .../bindings/mailbox/st,stm32-ipcc.yaml       | 84 +++++++++++++++++++
>  .../bindings/mailbox/stm32-ipcc.txt           | 47 -----------
>  2 files changed, 84 insertions(+), 47 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> 

Applied, thanks.

Rob
