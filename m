Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4508AA71CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfICRiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:38:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38418 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:38:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so9574892wrx.5;
        Tue, 03 Sep 2019 10:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKVEXZU6W+dO4/h+hhmxBNGUoZMyM7LM4xnC1FiFh60=;
        b=AwdYi5gBTTraNKDSnuI3uq4AtowOkxX9hqoscbGn2sLeRKzuYhTF+j6vLXaiXBFYR4
         xWHn08KvYWT0jQG5QcwK0pPG0OhiXTGzIfWM8fpXhR/5p8YgWf0pPs6CiWlm1t3gZKOG
         P/oEg5x4dxBaoEfPxmr42hvVWAV+F1/EGOR/PNTWEdK3Wi+87j2VGcd47qsE+qtb9iY6
         zb7KGysk0LNhXj1MtmmFV4i/M3jfqRhvS4sdCb8oacRSQutQEG16lz73WPtGdKwCvthE
         7tDXJV3HIcPle7H6dAyOBLbt5jI4wNJUwuvxFkg1/+kWxnBGiXTSAr/KiYsTpbVY/YKM
         eafQ==
X-Gm-Message-State: APjAAAUKBNquDZugbma5kpbz/TgufPmBdAvvlNg2S+n+KH7Ael92zlNm
        7w/dQYEOa4A39hrPUq2rCQ==
X-Google-Smtp-Source: APXvYqzRQYJLzntZeTliorX2sDTxhd2HeDwz/MkYnaY3eYsSmuW3XzY+VKFpZ82MlkNM+XLjzG8B7g==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr11533990wrq.183.1567532294879;
        Tue, 03 Sep 2019 10:38:14 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id t22sm326468wmi.11.2019.09.03.10.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:38:14 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:38:12 +0100
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: amlogic: add A1 bindings
Message-ID: <20190903173812.GA30084@bogus>
References: <1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com>
 <1567493475-75451-3-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567493475-75451-3-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2019 02:51:13 -0400, Jianxin Pan wrote:
> Add bindings for the new Amlogic A1 SoC family.
> 
> A1 is an application processor designed for smart audio and IoT applications,
> with dual core Cortex-A35.
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
