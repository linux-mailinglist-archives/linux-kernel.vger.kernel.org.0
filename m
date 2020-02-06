Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7F154E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 23:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBFWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 17:02:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBFWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:02:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so147235pfh.7;
        Thu, 06 Feb 2020 14:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKy2GPfvS9CgxLQkVubqsZ+Y91Atlf8a7/klYM5O6+k=;
        b=hG8xjm+BjK6Zf8RYQk7NuQT3ffDfjJfSizPP0SkMM80yEicsvi3k4pUAh+zBNpcQJH
         7z1QtfF1GqbLRV7roK0DftgPIMuK/8JQBZKgMRRfQGPr/h4AT88TmgcSVnQL21ph2bug
         +17xgiDTrxmCtxlMVxyICIn6Dhnr1v9FQRUZVxZqs50bl9xe2/l/k+nQTiXrrzNI8bB/
         D0Guf9R9ztLx26X0j0tRDMvYPnajFtSLq0OGYkS+k7VyeBnauKw75mQwvPxqAPp18uHc
         x02kHuxQ4pcsZYB0439FdRsdUSHcvgY1iElIGpPdyXd2vh68YJcau1N/68SGLoMDzEie
         fO5g==
X-Gm-Message-State: APjAAAVbdHKY1yEcFND9t9xOeaR8mOcSoMABenNSqRPVoVH13lg1EDCf
        YP+uMipdJ2fRZJJ0ZuYemg==
X-Google-Smtp-Source: APXvYqz2m/5KnaAfhQtR8QLh7i+VVO2GOuIJv1P44fBKu1hhLSuBxUnTemY6S8EUbWIOGw9Oj/QRjw==
X-Received: by 2002:a62:2a07:: with SMTP id q7mr6263858pfq.153.1581026524104;
        Thu, 06 Feb 2020 14:02:04 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id z16sm347177pgl.92.2020.02.06.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:02:03 -0800 (PST)
Received: (nullmailer pid 27083 invoked by uid 1000);
        Thu, 06 Feb 2020 22:02:01 -0000
Date:   Thu, 6 Feb 2020 15:02:01 -0700
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        philippe.cornu@st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: panel: Convert raydium,rm68200 to
 json-schema
Message-ID: <20200206220201.GA27021@bogus>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206133344.724-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 14:33:43 +0100, Benjamin Gaignard wrote:
> Convert raydium,rm68200 to json-schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/display/panel/raydium,rm68200.txt     | 25 ----------
>  .../bindings/display/panel/raydium,rm68200.yaml    | 56 ++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm68200.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
