Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79AA70C64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 00:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfGVWKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 18:10:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39015 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:10:47 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so77500855ioh.6;
        Mon, 22 Jul 2019 15:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=so3TguXhHjajKSvaOLSucOk7rXy936Gzk4d2QA02XtA=;
        b=WeuhNjzs2wAIAQW/8qBkGqSB2h29TZH5THjlzO9ICQdI7xu4sbIlo026bqCoNVNVm8
         1g+U4wPGN8jiBo/ZO4rTEFBLqgXqRHM1W/6hJVUwSVeYVBsfAQMBnPDpSlbZ4C2EHiu5
         JhreBc95egnz+hj3XPN2YUdmioHZPMjVPp1ly7VgbWwbNkLNfNhJ20WXpZWIZXEUnLH/
         QWe6hoXuykHVjJRa2tAeqB/VfABZUPMpLSSPA9sFdr03fpwMcNThUcpwxaMAM0TqckwI
         N1jX++oabOqCeaFMe9/Ob7FtXvsYvRTu91dubcsopuP+8PDBI2H3RewGNV0VyZyVwv7O
         qRCA==
X-Gm-Message-State: APjAAAWxHQw1zHF/DBCbjoXmf1FyIwEF7uoYusCjbcym5B3m+zTVBPy7
        JNyinUQSRhk9uVb80GkFB00N8X8=
X-Google-Smtp-Source: APXvYqwhN7RA27SVa6mIjcHdSIUhlwnMBkhE2+F2OczdEmCOQCiFU41dl37RKc0vjcv14UOGyFPR+g==
X-Received: by 2002:a5d:8890:: with SMTP id d16mr20374962ioo.274.1563833446531;
        Mon, 22 Jul 2019 15:10:46 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id s2sm29616314ioj.8.2019.07.22.15.10.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:10:45 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:10:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC 05/11] dt-bindings: soc: amlogic: clk-measure: Add SM1
 compatible
Message-ID: <20190722221045.GA30948@bogus>
References: <20190701104705.18271-1-narmstrong@baylibre.com>
 <20190701104705.18271-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701104705.18271-6-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jul 2019 12:46:59 +0200, Neil Armstrong wrote:
> Add the Amlogic SM1 Compatible for the clk-measurer IP.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
