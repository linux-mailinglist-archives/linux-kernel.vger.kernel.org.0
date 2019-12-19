Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E924126E09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfLSTeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 14:34:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41303 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSTeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:34:18 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so8523939otc.8;
        Thu, 19 Dec 2019 11:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4s0UeefcmQPxDO9I0vP0cU6H8/zBXgxnJhl+iNskVSk=;
        b=sLnhB+4aWAcvZDoR6jisSulkxR+eIUrnWykxZrphobgUZvbRw0EjpBH1hKNIASV6Pa
         B3Hh8w4t6aiU2BZM91hMhAyeL4HhsTTvOXVCaX/6ZR+Wk+xaZgm8qKZe8/pTtfuduSXk
         Ttrx8xLkVN18pkzKlzNt27uTz31E88OnrY6fyRBcDDtXA8kPaPi1Ex+vcGIvTYL38aQF
         T4gnIBgYObsoZbmUc5vSrRFKwG3LDN6hD7Ao3U6tJRAMDpsF2qeoUrY5o5VAHrh3eU8g
         JjEoGRcbECRojz2IFatv9UMCltx8l3PqpjDF/QrejXc/cvDgKYQg5UQB6qSON2DE6XSo
         7ChA==
X-Gm-Message-State: APjAAAW1y4gKch+d5inEqqzHl3CFd+IRRveB8rSwb2olu/H8tCa8hcae
        m+RnwybfcfbaKnVZwuDiQQ==
X-Google-Smtp-Source: APXvYqwRRb0TpvCkbAd8DOTvX/AnQt1KbPO4q7/X6jdpiZYbQd+IW8/opQXVYnWiRvA6JuPFH2Fx4g==
X-Received: by 2002:a9d:6251:: with SMTP id i17mr10703698otk.14.1576784058062;
        Thu, 19 Dec 2019 11:34:18 -0800 (PST)
Received: from localhost ([2607:fb90:20de:fb54:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id 97sm2469562otx.29.2019.12.19.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:34:17 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:34:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 4/5] dt-bindings: arm: fsl: add Kontron sl28 boards
Message-ID: <20191219193415.GA23458@bogus>
References: <20191209234350.18994-1-michael@walle.cc>
 <20191209234350.18994-5-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209234350.18994-5-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 00:43:49 +0100, Michael Walle wrote:
> Add the Kontron SMARC-sAL28 board, its variants and combination with
> carriers.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
