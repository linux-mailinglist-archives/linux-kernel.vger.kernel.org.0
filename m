Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B34A5963
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfIBO3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 10:29:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIBO3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:29:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id 30so3296995wrk.11;
        Mon, 02 Sep 2019 07:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DjYd27e5rUrA0mFadxSqkNYgMFL3Biunt8BWTcHyQek=;
        b=OaFlLxenZ+Vm2UjyPrGkK2ueFEVZYdL1wGIbk7VZVXSCfDPxeYg9TZen5SnweM6wRt
         iXS84cDlFO5vEcT+hhREU5d75GWq3T1z8oKphnNF4addQVpEKEPZjRyObMLtfgBwiber
         3aWDD2p52JNnjF9X1pdlmvJlyCnuB63YwIyrVcmTGePi+0eBkbMqHbjZSGOjk4EYYyz6
         cajBMEFBCZu1i2LqfL/SgZo01Mete/Povew8wTJu6UvSgI8E3lFwkDbG246Vng6gdLvV
         FevINGF20oFX40X209LK8Vo8yXNyqDVcsin1Hlq1cfvzCUbjnZUVEyB1/++O2tYJDcXf
         S1Bw==
X-Gm-Message-State: APjAAAUfmhYvagRz07m6pIHcmxHlPXR/Yt8IMkEEwpOlLP1V5pwwOs2K
        I+eQWAY/p8DQtgzi7MTkvA==
X-Google-Smtp-Source: APXvYqzW/GN1ey91R5BmJA5pnLC5WiMXFYRMPae9O7nnw0okaF9xqO9oDPIM4raCO3nV0T/6K8Ptrw==
X-Received: by 2002:adf:bc84:: with SMTP id g4mr36664702wrh.135.1567434555598;
        Mon, 02 Sep 2019 07:29:15 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id f13sm13885177wrq.3.2019.09.02.07.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:29:14 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:29:14 +0100
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (as370-hwmon) Add DT bindings for
 Synaptics  AS370 PVT
Message-ID: <20190902142914.GA3170@bogus>
References: <20190827113214.13773d45@xhacker.debian>
 <20190827113337.384457f6@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827113337.384457f6@xhacker.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 03:44:57 +0000, Jisheng Zhang wrote:
> Add device tree bindings for Synaptics AS370 PVT sensors.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/hwmon/as370.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
