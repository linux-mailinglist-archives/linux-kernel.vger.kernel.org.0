Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3AFBC270A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfI3UpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 16:45:08 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40966 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfI3UpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id w17so12386357oiw.8;
        Mon, 30 Sep 2019 13:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHeCpN2463mRdVd4Een2eG9NLKq6PLofbIreirL6ULM=;
        b=WeNIIIj60biT8hJrNvDwy832Ruk6fDeCQTb05GLVlZMMjedjLGn/KINSo1Vje802HB
         jO4i98jSvdqR+ukfJh19+EClMyRhtBJMhkvbwKzq4gr3sp582okXRbvcLgFO7FBY988C
         /2PMOI3ORCav3OTa2nBqTEEp5bSVyZZ1ubdasNUCx6XOLiAbi3EhARhUhKh4UmVxZ4/A
         lXS+nes8QYc2ix8QIPDlR4IZdP6Hi1Jw+1UDVOFfU4D/f2+mjSmj3bgjxyetQUeMeFOw
         HJdRuP+8XXVCpbicg4/CK66st/FgpAKn+WRUwScr0r3ZnfG/9qTN30Ch/dZWPC5GuVoD
         QDYg==
X-Gm-Message-State: APjAAAWAYvYvgxaMOu/D4vsbR0vT14e2C8f4OrvIz1evoeEm+g1kjdlo
        czwd0fyhWRvDn/Bdu5USp3ulriI=
X-Google-Smtp-Source: APXvYqwwR+as++oOAeBfzG/uIVrhnm3yF5hx+JyUgYRKMiH7ZEmlrV6X71etrsLz0P1tGpDCcgNPZQ==
X-Received: by 2002:aca:d846:: with SMTP id p67mr550811oig.144.1569869862328;
        Mon, 30 Sep 2019 11:57:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b5sm4531019oia.20.2019.09.30.11.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:57:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 13:57:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/2] ASoC: fsl_mqs: add DT binding documentation
Message-ID: <20190930185741.GA18160@bogus>
References: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019 17:42:13 +0800, Shengjiu Wang wrote:
> Add the DT binding documentation for NXP MQS driver
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> Changes in v2
> -refine the comments for properties
> 
>  .../devicetree/bindings/sound/fsl,mqs.txt     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
