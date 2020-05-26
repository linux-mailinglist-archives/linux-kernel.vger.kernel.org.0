Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B2219881D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 01:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgC3XVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 19:21:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41220 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC3XVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:21:39 -0400
Received: by mail-io1-f67.google.com with SMTP id b12so3539801ion.8;
        Mon, 30 Mar 2020 16:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVnw6FbVGtknI/LXqWPEB0fCBLV8ok47WPEsicGJKgc=;
        b=UTZXXajbyMtlnjw0IM251oLIrn08qXfCtNA44hqb+ZF6DNI+DF/im6iC4QQaeojrHs
         pAS05T5rPWDZ7iFn5UidaycMPdG6L4HbnMqgF+9Cj1b1jRHLKT5um/4cohXD1Qld7GI3
         xtDLyWuLx7L0r4rODLA0RTvHjTsl4n7FqDRsDHACnnNey+FEAF3wRElNG9DjfruBeATz
         No6gGuaTAnZ4B052BWlaMDH7S+K+eB2jG8Colht/mkHnIgtmhaHY/Qv4I0mAbuCsasgk
         x9g6lNjJMR1Gzk1obyOYefCTXXOlVYRQc1Axvw4qqDa+RAKLZUI1BnqkHyGKlzeZW3+b
         7QUw==
X-Gm-Message-State: ANhLgQ2AHAlpyGQ5qlUhexFZI6G9QSmVXBHpL1ROaWPaN2SjlodHl+3U
        LtZJupICmpy1UQ0IW1X3qw==
X-Google-Smtp-Source: ADFU+vvLjBYxSJO2if2o0gwQCWJ+uAWhliFrL8r8v9ZHNOquhf0xFKTFptjnxSL3vxEJ724p7DSufA==
X-Received: by 2002:a5e:c104:: with SMTP id v4mr12880353iol.122.1585610498381;
        Mon, 30 Mar 2020 16:21:38 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i16sm5401647ils.40.2020.03.30.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:21:37 -0700 (PDT)
Received: (nullmailer pid 18111 invoked by uid 1000);
        Mon, 30 Mar 2020 23:21:36 -0000
Date:   Mon, 30 Mar 2020 17:21:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@gmail.com, linux-imx@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        yuehaibing@huawei.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 5/5] dt-bindings: dsp: fsl: Add fsl,imx8mp-dsp entry
Message-ID: <20200330232136.GA18056@bogus>
References: <20200319194957.9569-1-daniel.baluta@oss.nxp.com>
 <20200319194957.9569-6-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319194957.9569-6-daniel.baluta@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 21:49:57 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Minimal implementation needs the same DT properties as
> existing compatible strings. So, we just add the new
> compatible string in the list.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
