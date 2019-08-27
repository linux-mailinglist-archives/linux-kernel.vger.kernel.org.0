Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8177D9F16B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfH0RWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:22:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46108 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0RWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:22:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so19379045otk.13;
        Tue, 27 Aug 2019 10:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPpftmwK3OKZMRgsYVJviNISUJHoAZwIDI0S7LTpL6w=;
        b=W0q92+WG6hCNW+vZej+6W4tkglz6MvMiPcScFFbwIDKersDaYwaz5iZ69l9Lowm3mH
         W2PYVJsAC344SMc6Qs6LTdp7IH5O4rntek+d+WoLCYkdqE3gKLDLPPe8/TgFiiwGvV8Y
         HZrFf6vOP94RpxTsmoA35BE0KDXIbEnQGkM/gGNIpIB/pScW0RK6f/e/FppHaoxhPDpl
         BX/6B7M+F90wq7xRMs9ZeKg3WD5AvDKZbzqhHwx+Vou1GbhcZu4gahDy89IvI/1beUfl
         tfN+oJ8VwNoYMpADUTw3fQv0SpzBHzhlZk+p/WGTPui/jH9ABh6DT0pd359T3R680bhh
         pL6w==
X-Gm-Message-State: APjAAAVGaewFrJqMkEg5bHxsOcZvimoyzKUTmQHgOdFUF36kl9CJ7K1+
        /Jpf1fpVJK5LeowD1eyFlRof96c=
X-Google-Smtp-Source: APXvYqxjZ8uf2LA9GzcCtuUvEFrM392BMVxwyyzfao6eluhjcJIf98avFVPEXxAiKtXFK5u0LaztRA==
X-Received: by 2002:a9d:39c4:: with SMTP id y62mr20481062otb.313.1566926523239;
        Tue, 27 Aug 2019 10:22:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm5477424otf.25.2019.08.27.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:22:02 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:22:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: lantiq: Update for new SoC
Message-ID: <20190827172202.GA10615@bogus>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
 <ffb6855d4c8d47412775b5fa4ce6ae4dd1161cb8.1566370151.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffb6855d4c8d47412775b5fa4ce6ae4dd1161cb8.1566370151.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2019 15:06:52 +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) reuses Lantiq ASC serial controller IP.
> Update the dt bindings to support LGM as well.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq,asc.yaml     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
